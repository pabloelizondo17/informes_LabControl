/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: TCLab_Implementation_data.c
 *
 * Code generated for Simulink model 'TCLab_Implementation'.
 *
 * Model version                  : 1.31
 * Simulink Coder version         : 25.2 (R2025b) 28-Jul-2025
 * C/C++ source code generated on : Wed Sep  9 10:58:45 2026
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: Atmel->AVR
 * Code generation objectives:
 *    1. Execution efficiency
 *    2. Traceability
 * Validation result: Not run
 */

#include "TCLab_Implementation.h"

/* Model block global parameters (default storage) */
real32_T rtP_T_ref = 60.0F;            /* Variable: T_ref
                                        * Referenced by: '<Root>/Constant'
                                        */

/* Block parameters (default storage) */
P_TCLab_Implementation_T TCLab_Implementation_P = {
  /* Expression: 0.5
   * Referenced by: '<Root>/Moving Average'
   */
  0.5F,

  /* Computed Parameter: Gain_Gain
   * Referenced by: '<Root>/Gain'
   */
  0.488758564F,

  /* Expression: single(-50)
   * Referenced by: '<Root>/Bias'
   */
  -50.0F,

  /* Computed Parameter: Saturation_UpperSat
   * Referenced by: '<Root>/Saturation'
   */
  90.0F,

  /* Computed Parameter: Saturation_LowerSat
   * Referenced by: '<Root>/Saturation'
   */
  0.0F,

  /* Expression: single(0.9*255/100)
   * Referenced by: '<Root>/Gain1'
   */
  2.295F
};

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
