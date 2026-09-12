###########################################################################
## Makefile generated for component 'Controller'. 
## 
## Makefile     : Controller.mk
## Generated on : Wed Sep 09 08:53:22 2026
## Final product: ./Controller.elf
## Product type : executable
## 
###########################################################################

###########################################################################
## MACROS
###########################################################################

# Macro Descriptions:
# PRODUCT_NAME            Name of the system to build
# MAKEFILE                Name of this makefile

PRODUCT_NAME              = Controller
MAKEFILE                  = Controller.mk
MATLAB_ROOT               = C:/PROGRA~1/MATLAB/R2025b
MATLAB_BIN                = C:/PROGRA~1/MATLAB/R2025b/bin
MATLAB_ARCH_BIN           = $(MATLAB_BIN)/win64
START_DIR                 = C:/Users/matia/Downloads/Lab01_TCLab_MIL
SOLVER                    = 
SOLVER_OBJ                = 
CLASSIC_INTERFACE         = 0
TGT_FCN_LIB               = None
MODEL_HAS_DYNAMICALLY_LOADED_SFCNS = 0
RELATIVE_PATH_TO_ANCHOR   = ../../../..
C_STANDARD_OPTS           = 
CPP_STANDARD_OPTS         = 

###########################################################################
## TOOLCHAIN SPECIFICATIONS
###########################################################################

# Toolchain Name:          Arduino AVR
# Supported Version(s):    
# ToolchainInfo Version:   2025b
# Specification Revision:  1.0
# 
#-------------------------------------------
# Macros assumed to be defined elsewhere
#-------------------------------------------

# ARDUINO_ROOT
# ARDUINO_PORT
# ARDUINO_MCU
# ARDUINO_BAUD
# ARDUINO_PROTOCOL
# ARDUINO_F_CPU

#-----------
# MACROS
#-----------

SHELL            = %SystemRoot%/system32/cmd.exe
PRODUCT_HEX      = $(RELATIVE_PATH_TO_ANCHOR)/$(PRODUCT_NAME).hex
PRODUCT_BIN      = $(RELATIVE_PATH_TO_ANCHOR)/$(PRODUCT_NAME).eep
ARDUINO_TOOLS    = $(ARDUINO_AVR_ROOT)/tools/avr-gcc/$(AVR_GCC_LIB_VERSION)/bin
ELF2EEP_OPTIONS  = -O ihex -j .eeprom --set-section-flags=.eeprom=alloc,load --no-change-warnings --change-section-lma .eeprom=0
DOWNLOAD_ARGS    =  >tmp.trash 2>&1 -P$(ARDUINO_PORT) -V -q -q -q -q -F -C$(ARDUINO_ROOT)/hardware/tools/avr/etc/avrdude.conf -p$(ARDUINO_MCU) -c$(ARDUINO_PROTOCOL) -b$(ARDUINO_BAUD) -D -Uflash:w:

TOOLCHAIN_SRCS = 
TOOLCHAIN_INCS = 
TOOLCHAIN_LIBS = -lm

#------------------------
# BUILD TOOL COMMANDS
#------------------------

# Assembler: Arduino AVR Assembler
AS_PATH = $(ARDUINO_TOOLS)
AS = "$(AS_PATH)/avr-gcc"

# C Compiler: Arduino AVR C Compiler
CC_PATH = $(ARDUINO_TOOLS)
CC = "$(CC_PATH)/avr-gcc"

# Linker: Arduino AVR Linker
LD_PATH = $(ARDUINO_TOOLS)
LD = "$(LD_PATH)/avr-gcc"

# C++ Compiler: Arduino AVR C++ Compiler
CPP_PATH = $(ARDUINO_TOOLS)
CPP = "$(CPP_PATH)/avr-g++"

# C++ Linker: Arduino AVR C++ Linker
CPP_LD_PATH = $(ARDUINO_TOOLS)
CPP_LD = "$(CPP_LD_PATH)/avr-gcc"

# Archiver: Arduino AVR Archiver
AR_PATH = $(ARDUINO_TOOLS)
AR = "$(AR_PATH)/avr-ar"

# MEX Tool: MEX Tool
MEX_PATH = $(MATLAB_ARCH_BIN)
MEX = "$(MEX_PATH)/mex"

# Binary Converter: Binary Converter
OBJCOPY_PATH = $(ARDUINO_TOOLS)
OBJCOPY = "$(OBJCOPY_PATH)/avr-objcopy"

# Hex Converter: Hex Converter
OBJCOPY_PATH = $(ARDUINO_TOOLS)
OBJCOPY = "$(OBJCOPY_PATH)/avr-objcopy"

# Download: Download
DOWNLOAD_PATH = $(ARDUINO_TOOLS)
DOWNLOAD = "$(DOWNLOAD_PATH)/avrdude"

# Execute: Execute
EXECUTE = $(PRODUCT)

# Builder: Make Tool
MAKE_PATH = %MATLAB%\bin\win64
MAKE = "$(MAKE_PATH)/gmake"


#-------------------------
# Directives/Utilities
#-------------------------

ASDEBUG             = -g
AS_OUTPUT_FLAG      = -o
CDEBUG              = -g
C_OUTPUT_FLAG       = -o
LDDEBUG             = -g
OUTPUT_FLAG         = -o
CPPDEBUG            = -g
CPP_OUTPUT_FLAG     = -o
CPPLDDEBUG          = -g
OUTPUT_FLAG         = -o
ARDEBUG             =
STATICLIB_OUTPUT_FLAG =
MEX_DEBUG           = -g
RM                  =
ECHO                = echo
MV                  =
RUN                 =

#--------------------------------------
# "Faster Runs" Build Configuration
#--------------------------------------

ARFLAGS              = rcs
ASFLAGS              = -MMD -MP -MF"$(@:%.o=%.dep)" -MT"$@"  \
                       -Wall \
                       -x assembler-with-cpp \
                       $(ASFLAGS_ADDITIONAL) \
                       $(DEFINES) \
                       $(INCLUDES) \
                       -c
OBJCOPYFLAGS_BIN     = $(ELF2EEP_OPTIONS) $(PRODUCT) $(PRODUCT_BIN)
CFLAGS               = -std=gnu11  \
                       -c \
                       -w \
                       -ffunction-sections \
                       -fdata-sections  \
                       -MMD \
                       -DARDUINO=10801  \
                       -MMD -MP -MF"$(@:%.o=%.dep)" -MT"$@"  \
                       -Os
CPPFLAGS             = -std=gnu++11 -fpermissive -fno-exceptions -fno-threadsafe-statics  \
                       -c \
                       -w \
                       -ffunction-sections \
                       -fdata-sections  \
                       -MMD \
                       -DARDUINO=10801  \
                       -MMD -MP -MF"$(@:%.o=%.dep)" -MT"$@"  \
                       -Os
CPP_LDFLAGS          =  -w -Os -Wl,--gc-sections,--relax
CPP_SHAREDLIB_LDFLAGS  =
DOWNLOAD_FLAGS       = $(DOWNLOAD_ARGS)$(PRODUCT_HEX):i
EXECUTE_FLAGS        =
OBJCOPYFLAGS_HEX     = -O ihex -R .eeprom $(PRODUCT) $(PRODUCT_HEX)
LDFLAGS              =  -w -Os -Wl,--gc-sections,--relax
MEX_CPPFLAGS         =
MEX_CPPLDFLAGS       =
MEX_CFLAGS           =
MEX_LDFLAGS          =
MAKE_FLAGS           = -f $(MAKEFILE)
SHAREDLIB_LDFLAGS    =



###########################################################################
## OUTPUT INFO
###########################################################################

PRODUCT = ./Controller.elf
PRODUCT_TYPE = "executable"
BUILD_TYPE = "Top-Level Standalone Executable"

###########################################################################
## INCLUDE PATHS
###########################################################################

INCLUDES_BUILDINFO = -I$(START_DIR) -I$(START_DIR)/slprj/ert/Controller -I$(MATLAB_ROOT)/extern/include -I$(MATLAB_ROOT)/simulink/include -I$(MATLAB_ROOT)/rtw/c/src -I$(MATLAB_ROOT)/rtw/c/src/ext_mode/common -I$(MATLAB_ROOT)/rtw/c/ert -I$(START_DIR)/slprj/ert/_sharedutils -I$(ARDUINO_AVR_ROOT)/hardware/avr/$(AVR_LIB_VERSION)/cores/arduino -I$(ARDUINO_AVR_ROOT)/hardware/avr/$(AVR_LIB_VERSION)/variants/standard -IC:/ProgramData/MATLAB/SupportPackages/R2025b/toolbox/target/supportpackages/arduinotarget/include -IC:/ProgramData/MATLAB/SupportPackages/R2025b/toolbox/target/supportpackages/arduinotarget/scheduler/include -IC:/ProgramData/MATLAB/SupportPackages/R2025b/toolbox/target/supportpackages/arduinobase/include -I$(ARDUINO_AVR_ROOT)/tools/avr-gcc/$(AVR_GCC_LIB_VERSION)/avr/include -I$(MATLAB_ROOT)/toolbox/rtw/targets/pil/c -I$(START_DIR)/slprj/ert/Controller/pil -I$(MATLAB_ROOT)/extern/include/coder/connectivity/XILTgtAppSvc -I$(MATLAB_ROOT)/toolbox/coder/rtiostream/src/utils -I$(MATLAB_ROOT)/toolbox/coder/rtiostream/src -IC:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino -IC:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/variants/standard

INCLUDES = $(INCLUDES_BUILDINFO)

###########################################################################
## DEFINES
###########################################################################

DEFINES_ = -D__MW_TARGET_USE_HARDWARE_RESOURCES_H__ -DMW_TIMERID=1 -DMW_PRESCALAR=1024 -DMW_TIMERCOUNT=49911 -DMW_SCHEDULERCOUNTER=1 -DARDUINO_NUM_SERIAL_PORTS=1 -DARDUINO_SERIAL_RECEIVE_BUFFER_SIZE=64 -D_RTT_BAUDRATE_SERIAL0_=9600 -D_RTT_CONFIG_SERIAL0_=SERIAL_8N1 -D_RTT_ANALOG_REF_=0 -DMW_NUM_PINS=20 -D_ONBOARD_EEPROM_SIZE_=1024 -DMW_PIL_SERIAL_BAUDRATE=115200 -DMW_PIL_ARUDINOSERIAL
DEFINES_BUILD_ARGS = -DCLASSIC_INTERFACE=0 -DALLOCATIONFCN=0 -DTERMFCN=1 -DONESTEPFCN=1 -DMAT_FILE=0 -DMULTI_INSTANCE_CODE=0 -DINTEGER_CODE=0 -DMT=0
DEFINES_CUSTOM = 
DEFINES_OPTS = -DTID01EQ=0 -DCODER_ASSUMPTIONS_ENABLED=0 -DRTIOSTREAM_RX_BUFFER_BYTE_SIZE=128 -DRTIOSTREAM_TX_BUFFER_BYTE_SIZE=128 -DMEM_UNIT_BYTES=1 -DMemUnit_T=uint8_T
DEFINES_SKIPFORSIL = -DXCP_CUSTOM_PLATFORM -DEXIT_FAILURE=1 -DEXTMODE_DISABLEPRINTF -DEXTMODE_DISABLETESTING -DEXTMODE_DISABLE_ARGS_PROCESSING=1 -DSTACK_SIZE=64 -DRT
DEFINES_STANDARD = -DMODEL=Controller -DNUMST=1 -DNCSTATES=0 -DHAVESTDIO -DMODEL_HAS_DYNAMICALLY_LOADED_SFCNS=0

DEFINES = $(DEFINES_) $(DEFINES_BUILD_ARGS) $(DEFINES_CUSTOM) $(DEFINES_OPTS) $(DEFINES_SKIPFORSIL) $(DEFINES_STANDARD)

###########################################################################
## SOURCE FILES
###########################################################################

SRCS = $(MATLAB_ROOT)/toolbox/rtw/targets/pil/c/xil_interface_lib.c $(MATLAB_ROOT)/toolbox/rtw/targets/pil/c/xil_data_stream.c $(MATLAB_ROOT)/toolbox/rtw/targets/pil/c/xil_services.c $(START_DIR)/slprj/ert/Controller/pil/xil_interface.c $(MATLAB_ROOT)/toolbox/rtw/targets/pil/c/xilcomms_rtiostream.c $(MATLAB_ROOT)/toolbox/rtw/targets/pil/c/xil_rtiostream.c $(MATLAB_ROOT)/toolbox/coder/rtiostream/src/utils/rtiostream_utils.c C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/hooks.c C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/WInterrupts.c C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/wiring.c C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/wiring_analog.c C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/wiring_digital.c C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/wiring_pulse.c C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/wiring_shift.c C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/abi.cpp C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/CDC.cpp C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/HardwareSerial.cpp C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/HardwareSerial0.cpp C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/HardwareSerial1.cpp C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/HardwareSerial2.cpp C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/HardwareSerial3.cpp C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/PluggableUSB.cpp C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/IPAddress.cpp C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/new.cpp C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/Print.cpp C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/Stream.cpp C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/Tone.cpp C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/USBCore.cpp C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/WMath.cpp C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/WString.cpp C:/ProgramData/MATLAB/SupportPackages/R2025b/toolbox/target/supportpackages/arduinobase/src/io_wrappers.cpp C:/ProgramData/MATLAB/SupportPackages/R2025b/toolbox/target/supportpackages/arduinotarget/src/MW_ArduinoHWInit.cpp C:/ProgramData/MATLAB/SupportPackages/R2025b/toolbox/target/supportpackages/arduinotarget/src/rtiostream_serial.cpp C:/ProgramData/MATLAB/SupportPackages/R2025b/toolbox/target/supportpackages/arduinotarget/src/pil_main_arduino.c

ALL_SRCS = $(SRCS)

###########################################################################
## OBJECTS
###########################################################################

OBJS = xil_interface_lib.o xil_data_stream.o xil_services.o xil_interface.o xilcomms_rtiostream.o xil_rtiostream.o rtiostream_utils.o hooks.o WInterrupts.o wiring.o wiring_analog.o wiring_digital.o wiring_pulse.o wiring_shift.o abi.o CDC.o HardwareSerial.o HardwareSerial0.o HardwareSerial1.o HardwareSerial2.o HardwareSerial3.o PluggableUSB.o IPAddress.o new.o Print.o Stream.o Tone.o USBCore.o WMath.o WString.o io_wrappers.o MW_ArduinoHWInit.o rtiostream_serial.o pil_main_arduino.o

ALL_OBJS = $(OBJS)

###########################################################################
## PREBUILT OBJECT FILES
###########################################################################

PREBUILT_OBJS = 

###########################################################################
## LIBRARIES
###########################################################################

MODELREF_LIBS = ../../../../slprj/ert/Controller/Controller_rtwlib.a

LIBS = 

###########################################################################
## SYSTEM LIBRARIES
###########################################################################

SYSTEM_LIBS = 

###########################################################################
## ADDITIONAL TOOLCHAIN FLAGS
###########################################################################

#---------------
# C Compiler
#---------------

CFLAGS_SKIPFORSIL = -mmcu=atmega328p -DF_CPU=16000000L -DARDUINO_AVR_UNO -DARDUINO_ARCH_AVR -D_RUNONTARGETHARDWARE_BUILD_
CFLAGS_BASIC = $(DEFINES) $(INCLUDES)

CFLAGS += $(CFLAGS_SKIPFORSIL) $(CFLAGS_BASIC)

#-----------------
# C++ Compiler
#-----------------

CPPFLAGS_SKIPFORSIL = -mmcu=atmega328p -DF_CPU=16000000L -DARDUINO_AVR_UNO -DARDUINO_ARCH_AVR -D_RUNONTARGETHARDWARE_BUILD_
CPPFLAGS_BASIC = $(DEFINES) $(INCLUDES)

CPPFLAGS += $(CPPFLAGS_SKIPFORSIL) $(CPPFLAGS_BASIC)

#---------------
# C++ Linker
#---------------

CPP_LDFLAGS_SKIPFORSIL = -mmcu=atmega328p 

CPP_LDFLAGS += $(CPP_LDFLAGS_SKIPFORSIL)

#------------------------------
# C++ Shared Library Linker
#------------------------------

CPP_SHAREDLIB_LDFLAGS_SKIPFORSIL = -mmcu=atmega328p 

CPP_SHAREDLIB_LDFLAGS += $(CPP_SHAREDLIB_LDFLAGS_SKIPFORSIL)

#-----------
# Linker
#-----------

LDFLAGS_SKIPFORSIL = -mmcu=atmega328p 

LDFLAGS += $(LDFLAGS_SKIPFORSIL)

#--------------------------
# Shared Library Linker
#--------------------------

SHAREDLIB_LDFLAGS_SKIPFORSIL = -mmcu=atmega328p 

SHAREDLIB_LDFLAGS += $(SHAREDLIB_LDFLAGS_SKIPFORSIL)

###########################################################################
## INLINED COMMANDS
###########################################################################


DERIVED_SRCS = $(subst .o,.dep,$(OBJS))

build:

%.dep:



-include arduino_macros.mk
-include codertarget_assembly_flags.mk
-include *.dep


###########################################################################
## PHONY TARGETS
###########################################################################

.PHONY : all build buildobj clean info prebuild postbuild download execute


all : build postbuild
	echo "### Successfully generated all binary outputs."


build : prebuild $(PRODUCT)


buildobj : prebuild $(OBJS) $(PREBUILT_OBJS)
	echo "### Successfully generated all binary outputs."


prebuild : 


postbuild : $(PRODUCT)
	echo "### Invoking postbuild tool "Binary Converter" ..."
	$(OBJCOPY) $(OBJCOPYFLAGS_BIN)
	echo "### Done invoking postbuild tool."
	echo "### Invoking postbuild tool "Hex Converter" ..."
	$(OBJCOPY) $(OBJCOPYFLAGS_HEX)
	echo "### Done invoking postbuild tool."


download : postbuild
	echo "### Invoking postbuild tool "Download" ..."
	$(DOWNLOAD) $(DOWNLOAD_FLAGS)
	echo "### Done invoking postbuild tool."


execute : download
	echo "### Invoking postbuild tool "Execute" ..."
	$(EXECUTE) $(EXECUTE_FLAGS)
	echo "### Done invoking postbuild tool."


###########################################################################
## FINAL TARGET
###########################################################################

#-------------------------------------------
# Create a standalone executable            
#-------------------------------------------

$(PRODUCT) : $(OBJS) $(PREBUILT_OBJS) $(MODELREF_LIBS)
	echo "### Creating standalone executable "$(PRODUCT)" ..."
	$(CPP_LD) $(CPP_LDFLAGS) -o $(PRODUCT) $(OBJS) ../../../../slprj/ert/Controller/Controller_rtwlib.a $(SYSTEM_LIBS) $(TOOLCHAIN_LIBS)
	echo "### Created: $(PRODUCT)"


###########################################################################
## INTERMEDIATE TARGETS
###########################################################################

#---------------------
# SOURCE-TO-OBJECT
#---------------------

%.o : %.c
	$(CC) $(CFLAGS) -o "$@" "$<"


%.S.o : %.s
	$(AS) $(ASFLAGS) -o "$@" "$<"


%.S.o : %.S
	$(AS) $(ASFLAGS) -o "$@" "$<"


%.o : %.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


%.o : $(RELATIVE_PATH_TO_ANCHOR)/%.c
	$(CC) $(CFLAGS) -o "$@" "$<"


%.S.o : $(RELATIVE_PATH_TO_ANCHOR)/%.s
	$(AS) $(ASFLAGS) -o "$@" "$<"


%.S.o : $(RELATIVE_PATH_TO_ANCHOR)/%.S
	$(AS) $(ASFLAGS) -o "$@" "$<"


%.o : $(RELATIVE_PATH_TO_ANCHOR)/%.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


%.o : $(MATLAB_ROOT)/toolbox/rtw/targets/pil/c/%.c
	$(CC) $(CFLAGS) -o "$@" "$<"


%.S.o : $(MATLAB_ROOT)/toolbox/rtw/targets/pil/c/%.s
	$(AS) $(ASFLAGS) -o "$@" "$<"


%.S.o : $(MATLAB_ROOT)/toolbox/rtw/targets/pil/c/%.S
	$(AS) $(ASFLAGS) -o "$@" "$<"


%.o : $(MATLAB_ROOT)/toolbox/rtw/targets/pil/c/%.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


%.o : $(MATLAB_ROOT)/toolbox/coder/rtiostream/src/utils/%.c
	$(CC) $(CFLAGS) -o "$@" "$<"


%.S.o : $(MATLAB_ROOT)/toolbox/coder/rtiostream/src/utils/%.s
	$(AS) $(ASFLAGS) -o "$@" "$<"


%.S.o : $(MATLAB_ROOT)/toolbox/coder/rtiostream/src/utils/%.S
	$(AS) $(ASFLAGS) -o "$@" "$<"


%.o : $(MATLAB_ROOT)/toolbox/coder/rtiostream/src/utils/%.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


xil_interface_lib.o : $(MATLAB_ROOT)/toolbox/rtw/targets/pil/c/xil_interface_lib.c
	$(CC) $(CFLAGS) -o "$@" "$<"


xil_data_stream.o : $(MATLAB_ROOT)/toolbox/rtw/targets/pil/c/xil_data_stream.c
	$(CC) $(CFLAGS) -o "$@" "$<"


xil_services.o : $(MATLAB_ROOT)/toolbox/rtw/targets/pil/c/xil_services.c
	$(CC) $(CFLAGS) -o "$@" "$<"


xil_interface.o : $(START_DIR)/slprj/ert/Controller/pil/xil_interface.c
	$(CC) $(CFLAGS) -o "$@" "$<"


xilcomms_rtiostream.o : $(MATLAB_ROOT)/toolbox/rtw/targets/pil/c/xilcomms_rtiostream.c
	$(CC) $(CFLAGS) -o "$@" "$<"


xil_rtiostream.o : $(MATLAB_ROOT)/toolbox/rtw/targets/pil/c/xil_rtiostream.c
	$(CC) $(CFLAGS) -o "$@" "$<"


rtiostream_utils.o : $(MATLAB_ROOT)/toolbox/coder/rtiostream/src/utils/rtiostream_utils.c
	$(CC) $(CFLAGS) -o "$@" "$<"


hooks.o : C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/hooks.c
	$(CC) $(CFLAGS) -o "$@" "$<"


WInterrupts.o : C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/WInterrupts.c
	$(CC) $(CFLAGS) -o "$@" "$<"


wiring.o : C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/wiring.c
	$(CC) $(CFLAGS) -o "$@" "$<"


wiring_analog.o : C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/wiring_analog.c
	$(CC) $(CFLAGS) -o "$@" "$<"


wiring_digital.o : C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/wiring_digital.c
	$(CC) $(CFLAGS) -o "$@" "$<"


wiring_pulse.o : C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/wiring_pulse.c
	$(CC) $(CFLAGS) -o "$@" "$<"


wiring_shift.o : C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/wiring_shift.c
	$(CC) $(CFLAGS) -o "$@" "$<"


abi.o : C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/abi.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


CDC.o : C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/CDC.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


HardwareSerial.o : C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/HardwareSerial.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


HardwareSerial0.o : C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/HardwareSerial0.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


HardwareSerial1.o : C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/HardwareSerial1.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


HardwareSerial2.o : C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/HardwareSerial2.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


HardwareSerial3.o : C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/HardwareSerial3.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


PluggableUSB.o : C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/PluggableUSB.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


IPAddress.o : C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/IPAddress.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


new.o : C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/new.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


Print.o : C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/Print.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


Stream.o : C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/Stream.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


Tone.o : C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/Tone.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


USBCore.o : C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/USBCore.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


WMath.o : C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/WMath.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


WString.o : C:/ProgramData/MATLAB/SupportPackages/R2025b/aCLI/data/packages/arduino/hardware/avr/1.8.3/cores/arduino/WString.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


io_wrappers.o : C:/ProgramData/MATLAB/SupportPackages/R2025b/toolbox/target/supportpackages/arduinobase/src/io_wrappers.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


MW_ArduinoHWInit.o : C:/ProgramData/MATLAB/SupportPackages/R2025b/toolbox/target/supportpackages/arduinotarget/src/MW_ArduinoHWInit.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


rtiostream_serial.o : C:/ProgramData/MATLAB/SupportPackages/R2025b/toolbox/target/supportpackages/arduinotarget/src/rtiostream_serial.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


pil_main_arduino.o : C:/ProgramData/MATLAB/SupportPackages/R2025b/toolbox/target/supportpackages/arduinotarget/src/pil_main_arduino.c
	$(CC) $(CFLAGS) -o "$@" "$<"


###########################################################################
## DEPENDENCIES
###########################################################################

$(ALL_OBJS) : rtw_proj.tmw $(MAKEFILE)


###########################################################################
## MISCELLANEOUS TARGETS
###########################################################################

info : 
	echo "### PRODUCT = $(PRODUCT)"
	echo "### PRODUCT_TYPE = $(PRODUCT_TYPE)"
	echo "### BUILD_TYPE = $(BUILD_TYPE)"
	echo "### INCLUDES = $(INCLUDES)"
	echo "### DEFINES = $(DEFINES)"
	echo "### ALL_SRCS = $(ALL_SRCS)"
	echo "### ALL_OBJS = $(ALL_OBJS)"
	echo "### LIBS = $(LIBS)"
	echo "### MODELREF_LIBS = $(MODELREF_LIBS)"
	echo "### SYSTEM_LIBS = $(SYSTEM_LIBS)"
	echo "### TOOLCHAIN_LIBS = $(TOOLCHAIN_LIBS)"
	echo "### ASFLAGS = $(ASFLAGS)"
	echo "### CFLAGS = $(CFLAGS)"
	echo "### LDFLAGS = $(LDFLAGS)"
	echo "### SHAREDLIB_LDFLAGS = $(SHAREDLIB_LDFLAGS)"
	echo "### CPPFLAGS = $(CPPFLAGS)"
	echo "### CPP_LDFLAGS = $(CPP_LDFLAGS)"
	echo "### CPP_SHAREDLIB_LDFLAGS = $(CPP_SHAREDLIB_LDFLAGS)"
	echo "### ARFLAGS = $(ARFLAGS)"
	echo "### MEX_CFLAGS = $(MEX_CFLAGS)"
	echo "### MEX_CPPFLAGS = $(MEX_CPPFLAGS)"
	echo "### MEX_LDFLAGS = $(MEX_LDFLAGS)"
	echo "### MEX_CPPLDFLAGS = $(MEX_CPPLDFLAGS)"
	echo "### OBJCOPYFLAGS_BIN = $(OBJCOPYFLAGS_BIN)"
	echo "### OBJCOPYFLAGS_HEX = $(OBJCOPYFLAGS_HEX)"
	echo "### DOWNLOAD_FLAGS = $(DOWNLOAD_FLAGS)"
	echo "### EXECUTE_FLAGS = $(EXECUTE_FLAGS)"
	echo "### MAKE_FLAGS = $(MAKE_FLAGS)"


clean : 
	$(ECHO) "### Deleting all derived files ..."
	$(RM) $(PRODUCT)
	$(RM) $(ALL_OBJS)
	$(RM) *.dep
	$(ECHO) "### Deleted all derived files."


