/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: TCLab_Implementation.h
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

#ifndef TCLab_Implementation_h_
#define TCLab_Implementation_h_
#ifndef TCLab_Implementation_COMMON_INCLUDES_
#define TCLab_Implementation_COMMON_INCLUDES_
#include "rtwtypes.h"
#include "rtw_extmode.h"
#include "sysran_types.h"
#include "rtw_continuous.h"
#include "rtw_solver.h"
#include "MW_AnalogIn.h"
#include "MW_PWM.h"
#endif                               /* TCLab_Implementation_COMMON_INCLUDES_ */

#include "TCLab_Implementation_types.h"
#include "Controller_implementacion.h"
#include "rt_nonfinite.h"
#include "MW_target_hardware_resources.h"

/* Macros for accessing real-time model data structure */
#ifndef rtmGetFinalTime
#define rtmGetFinalTime(rtm)           ((rtm)->Timing.tFinal)
#endif

#ifndef rtmGetRTWExtModeInfo
#define rtmGetRTWExtModeInfo(rtm)      ((rtm)->extModeInfo)
#endif

#ifndef rtmGetErrorStatus
#define rtmGetErrorStatus(rtm)         ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatus
#define rtmSetErrorStatus(rtm, val)    ((rtm)->errorStatus = (val))
#endif

#ifndef rtmGetErrorStatusPointer
#define rtmGetErrorStatusPointer(rtm)  ((const char_T **)(&((rtm)->errorStatus)))
#endif

#ifndef rtmGetStopRequested
#define rtmGetStopRequested(rtm)       ((rtm)->Timing.stopRequestedFlag)
#endif

#ifndef rtmSetStopRequested
#define rtmSetStopRequested(rtm, val)  ((rtm)->Timing.stopRequestedFlag = (val))
#endif

#ifndef rtmGetStopRequestedPtr
#define rtmGetStopRequestedPtr(rtm)    (&((rtm)->Timing.stopRequestedFlag))
#endif

#ifndef rtmGetTFinal
#define rtmGetTFinal(rtm)              ((rtm)->Timing.tFinal)
#endif

#ifndef rtmGetTPtr
#define rtmGetTPtr(rtm)                (&)
#endif

/* Block signals (default storage) */
typedef struct {
  real32_T Constant;                   /* '<Root>/Constant' */
  real32_T Model;                      /* '<Root>/Model' */
  real32_T MovingAverage;              /* '<Root>/Moving Average' */
} B_TCLab_Implementation_T;

/* Block states (default storage) for system '<Root>' */
typedef struct {
  dsp_simulink_MovingAverage_TC_T obj; /* '<Root>/Moving Average' */
  codertarget_arduinobase_inter_T obj_d;/* '<Root>/Analog Input' */
  codertarget_arduinobase_int_j_T obj_i;/* '<Root>/PWM1' */
  struct {
    void *LoggedData[3];
  } Scope_PWORK;                       /* '<Root>/Scope' */

  MdlrefDW_Controller_implement_T Model_InstanceData;/* '<Root>/Model' */
} DW_TCLab_Implementation_T;

/* Parameters (default storage) */
struct P_TCLab_Implementation_T_ {
  real32_T MovingAverage_ForgettingFactor;/* Expression: 0.5
                                           * Referenced by: '<Root>/Moving Average'
                                           */
  real32_T Gain_Gain;                  /* Computed Parameter: Gain_Gain
                                        * Referenced by: '<Root>/Gain'
                                        */
  real32_T Bias_Bias;                  /* Expression: single(-50)
                                        * Referenced by: '<Root>/Bias'
                                        */
  real32_T Saturation_UpperSat;       /* Computed Parameter: Saturation_UpperSat
                                       * Referenced by: '<Root>/Saturation'
                                       */
  real32_T Saturation_LowerSat;       /* Computed Parameter: Saturation_LowerSat
                                       * Referenced by: '<Root>/Saturation'
                                       */
  real32_T Gain1_Gain;                 /* Expression: single(0.9*255/100)
                                        * Referenced by: '<Root>/Gain1'
                                        */
};

/* Real-time Model Data Structure */
struct tag_RTM_TCLab_Implementation_T {
  const char_T *errorStatus;
  RTWExtModeInfo *extModeInfo;

  /*
   * Sizes:
   * The following substructure contains sizes information
   * for many of the model attributes such as inputs, outputs,
   * dwork, sample times, etc.
   */
  struct {
    uint32_T checksums[4];
  } Sizes;

  /*
   * SpecialInfo:
   * The following substructure contains special information
   * related to other components that are dependent on RTW.
   */
  struct {
    const void *mappingInfo;
  } SpecialInfo;

  /*
   * Timing:
   * The following substructure contains information regarding
   * the timing information for the model.
   */
  struct {
    uint32_T clockTick0;
    time_T tFinal;
    boolean_T stopRequestedFlag;
  } Timing;
};

/* Block parameters (default storage) */
extern P_TCLab_Implementation_T TCLab_Implementation_P;

/* Block signals (default storage) */
extern B_TCLab_Implementation_T TCLab_Implementation_B;

/* Block states (default storage) */
extern DW_TCLab_Implementation_T TCLab_Implementation_DW;

/* Model block global parameters (default storage) */
extern real32_T rtP_T_ref;             /* Variable: T_ref
                                        * Referenced by: '<Root>/Constant'
                                        */

/* Model entry point functions */
extern void TCLab_Implementation_initialize(void);
extern void TCLab_Implementation_step(void);
extern void TCLab_Implementation_terminate(void);

/* Real-time Model object */
extern RT_MODEL_TCLab_Implementation_T *const TCLab_Implementation_M;
extern volatile boolean_T stopRequested;
extern volatile boolean_T runModel;

/*-
 * The generated code includes comments that allow you to trace directly
 * back to the appropriate location in the model.  The basic format
 * is <system>/block_name, where system is the system number (uniquely
 * assigned by Simulink) and block_name is the name of the block.
 *
 * Use the MATLAB hilite_system command to trace the generated code back
 * to the model.  For example,
 *
 * hilite_system('<S3>')    - opens system 3
 * hilite_system('<S3>/Kp') - opens and selects block Kp which resides in S3
 *
 * Here is the system hierarchy for this model
 *
 * '<Root>' : 'TCLab_Implementation'
 */
#endif                                 /* TCLab_Implementation_h_ */

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
