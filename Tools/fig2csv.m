function outFiles = fig2csv(figFile, outDir)
% FIG2CSV  Export plotted data from a MATLAB .fig file to CSV — one CSV
% per subplot/axes in the figure.
%
% Usage:
%   fig2csv('myplot.fig')            % writes CSVs next to myplot.fig
%   fig2csv('myplot.fig', 'out/')    % writes CSVs into out/
%   files = fig2csv('myplot.fig')    % also returns the list of CSV paths
%
% If the fig has 1 subplot, you get 1 CSV. If it has 3 subplots, you get
% 3 CSVs (one per axes), each named "<figname>_<axesN or title>.csv".
%
% Each CSV is long-format so it handles any number of curves per subplot,
% even with different lengths:
%
%   Series, Index, X, Y, Z
%
% "Series" is the legend/display name (or auto-generated), "Index" is
% the point number within that series.

    if nargin < 1 || isempty(figFile)
        [f, p] = uigetfile('*.fig', 'Select a .fig file');
        if isequal(f, 0)
            error('fig2csv:noFile', 'No .fig file selected.');
        end
        figFile = fullfile(p, f);
    end

    [figPath, figName] = fileparts(figFile);
    if nargin < 2 || isempty(outDir)
        outDir = figPath;
    end
    if ~isempty(outDir) && ~exist(outDir, 'dir')
        mkdir(outDir);
    end

    fig = openfig(figFile, 'invisible');
    cleanupObj = onCleanup(@() close(fig));

    axesList = findall(fig, 'Type', 'axes');
    axesList = flipud(axesList(:)); % top-to-bottom, left-to-right order

    supportedTypes = {'line', 'scatter', 'stem', 'bar', 'area', 'surface', ...
        'histogram', 'errorbar', 'stair', 'quiver', 'contour', 'patch', ...
        'animatedline', 'functionline', 'image', 'bubblechart'};
    outFiles = {};

    fprintf('Found %d axes in %s\n', numel(axesList), figFile);

    for ai = 1:numel(axesList)
        ax = axesList(ai);

        rows = {};
        rows(1,:) = {'Series', 'Index', 'X', 'Y', 'Z'};
        rowCount = 1;

        objs = findall(ax, '-depth', 1);
        seriesCounterByType = struct();
        skippedTypes = {};

        for oi = 1:numel(objs)
            obj = objs(oi);
            t = lower(get(obj, 'Type'));
            if ~ismember(t, supportedTypes)
                skippedTypes{end+1} = t; %#ok<AGROW>
                continue
            end

            [X, Y, Z] = extractData(obj, t);

            if isempty(X) && isempty(Y)
                skippedTypes{end+1} = [t ' (no usable data)']; %#ok<AGROW>
                continue
            end

            name = get(obj, 'DisplayName');
            if isempty(name)
                if ~isfield(seriesCounterByType, t)
                    seriesCounterByType.(t) = 0;
                end
                seriesCounterByType.(t) = seriesCounterByType.(t) + 1;
                name = sprintf('%s%d', t, seriesCounterByType.(t));
            end

            X = X(:); Y = Y(:);
            if isempty(Z)
                Z = nan(size(Y));
            else
                Z = Z(:);
            end
            n = max([numel(X), numel(Y), numel(Z)]);
            X = padTo(X, n); Y = padTo(Y, n); Z = padTo(Z, n);

            for k = 1:n
                rowCount = rowCount + 1;
                rows(rowCount, :) = { ...
                    name, k, ...
                    numOrEmpty(X, k), numOrEmpty(Y, k), numOrEmpty(Z, k) ...
                };
            end
        end

        if rowCount == 1
            % No plotted data in this axes (e.g. empty/legend-only axes) — skip it.
            if ~isempty(skippedTypes)
                fprintf('Axes %d: no exportable series (found but skipped: %s)\n', ...
                    ai, strjoin(unique(skippedTypes), ', '));
            else
                fprintf('Axes %d: no plotted objects found\n', ai);
            end
            continue
        end

        if numel(axesList) == 1
            outName = sprintf('%s.csv', figName);
        else
            outName = sprintf('%s_%s.csv', figName, axesLabel(ax, ai));
        end
        outPath = fullfile(outDir, outName);

        writeCsv(outPath, rows);
        fprintf('Wrote %d data rows to %s\n', rowCount - 1, outPath);
        outFiles{end+1} = outPath; %#ok<AGROW>
    end

    if isempty(outFiles)
        warning('fig2csv:noData', 'No plotted data found in %s', figFile);
    end
end

function [X, Y, Z] = extractData(obj, t)
    Z = [];
    switch t
        case 'histogram'
            edges = getSafe(obj, 'BinEdges');
            vals  = getSafe(obj, 'Values');
            if ~isempty(edges) && ~isempty(vals)
                X = edges(1:end-1) + diff(edges)/2; % bin centers
                Y = vals;
            else
                X = []; Y = [];
            end
        case 'image'
            % XData/YData for images are just [min max] ranges; the real
            % content is CData. Flatten the matrix to (row, col, value).
            C = getSafe(obj, 'CData');
            if isempty(C)
                X = []; Y = [];
            else
                [nRows, nCols, nCh] = size(C);
                if nCh > 1
                    C = mean(C, 3); % collapse RGB to a single intensity value
                end
                [colIdx, rowIdx] = meshgrid(1:nCols, 1:nRows);
                X = colIdx(:);
                Y = rowIdx(:);
                Z = C(:);
            end
        otherwise
            X = getSafe(obj, 'XData');
            Y = getSafe(obj, 'YData');
            Z = getSafe(obj, 'ZData');
    end
end

function v = getSafe(obj, prop)
    if isprop(obj, prop)
        v = get(obj, prop);
    else
        v = [];
    end
end

function v = padTo(v, n)
    if numel(v) < n
        v(end+1:n) = NaN;
    end
end

function s = numOrEmpty(v, k)
    if k > numel(v) || isnan(v(k))
        s = '';
    else
        s = sprintf('%.10g', v(k));
    end
end

function lbl = axesLabel(ax, idx)
    t = get(get(ax, 'Title'), 'String');
    if iscell(t), t = strjoin(t, ' '); end
    if ~isempty(t)
        lbl = matlab.lang.makeValidName(t);
    else
        lbl = sprintf('axes%d', idx);
    end
end

function writeCsv(outCsv, rows)
    fid = fopen(outCsv, 'w');
    if fid == -1
        error('Could not open %s for writing', outCsv);
    end
    cleanupObj = onCleanup(@() fclose(fid));
    for r = 1:size(rows, 1)
        line = rows(r, :);
        line = cellfun(@toStr, line, 'UniformOutput', false);
        fprintf(fid, '%s\n', strjoin(line, ','));
    end
end

function s = toStr(v)
    if ischar(v)
        s = v;
    elseif isnumeric(v)
        s = num2str(v);
    else
        s = '';
    end
end