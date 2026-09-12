/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: TCLab_Implementation.c
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
#include "TCLab_Implementation_types.h"
#include <math.h>
#include "rt_nonfinite.h"
#include "rtwtypes.h"
#include "TCLab_Implementation_private.h"
#include "Controller_implementacion.h"

/* Block signals (default storage) */
B_TCLab_Implementation_T TCLab_Implementation_B;

/* Block states (default storage) */
DW_TCLab_Implementation_T TCLab_Implementation_DW;

/* Real-time model */
static RT_MODEL_TCLab_Implementation_T TCLab_Implementation_M_;
RT_MODEL_TCLab_Implementation_T *const TCLab_Implementation_M =
  &TCLab_Implementation_M_;

/* Forward declaration for local functions */
static void TCLab_Implemen_SystemCore_setup(dsp_simulink_MovingAverage_TC_T *obj);
static void TCLab_Implemen_SystemCore_setup(dsp_simulink_MovingAverage_TC_T *obj)
{
  obj->isInitialized = 1L;

  /* Start for MATLABSystem: '<Root>/Moving Average' */
  obj->NumChannels = 1L;
  obj->FrameLength = 1L;
  obj->pwN = 0.0F;
  obj->pmN = 0.0F;
  obj->plambda = obj->ForgettingFactor;
  obj->isSetupComplete = true;
  obj->TunablePropsChanged = false;
}

/* Model step function */
void TCLab_Implementation_step(void)
{
  real32_T b_mN_tmp;
  real32_T b_wN;
  uint16_T b_varargout_1;

  /* Constant: '<Root>/Constant' */
  TCLab_Implementation_B.Constant = rtP_T_ref;

  /* MATLABSystem: '<Root>/Analog Input' */
  TCLab_Implementation_DW.obj_d.AnalogInDriverObj.MW_ANALOGIN_HANDLE =
    MW_AnalogIn_GetHandle(18UL);
  MW_AnalogInSingle_ReadResult
    (TCLab_Implementation_DW.obj_d.AnalogInDriverObj.MW_ANALOGIN_HANDLE,
     &b_varargout_1, MW_ANALOGIN_UINT16);

  /* MATLABSystem: '<Root>/Moving Average' */
  if (TCLab_Implementation_DW.obj.ForgettingFactor !=
      TCLab_Implementation_P.MovingAverage_ForgettingFactor) {
    if (TCLab_Implementation_DW.obj.isInitialized == 1L) {
      TCLab_Implementation_DW.obj.TunablePropsChanged = true;
    }

    TCLab_Implementation_DW.obj.ForgettingFactor =
      TCLab_Implementation_P.MovingAverage_ForgettingFactor;
  }

  if (TCLab_Implementation_DW.obj.TunablePropsChanged) {
    TCLab_Implementation_DW.obj.TunablePropsChanged = false;
    TCLab_Implementation_DW.obj.plambda =
      TCLab_Implementation_DW.obj.ForgettingFactor;
  }

  b_wN = TCLab_Implementation_DW.obj.plambda * TCLab_Implementation_DW.obj.pwN +
    1.0F;

  /* Start for MATLABSystem: '<Root>/Moving Average' */
  b_mN_tmp = 1.0F / b_wN;

  /* MATLABSystem: '<Root>/Moving Average' incorporates:
   *  Bias: '<Root>/Bias'
   *  DataTypeConversion: '<Root>/Data Type Conversion'
   *  Gain: '<Root>/Gain'
   *  MATLABSystem: '<Root>/Analog Input'
   * */
  TCLab_Implementation_B.MovingAverage = (TCLab_Implementation_P.Gain_Gain *
    (real32_T)b_varargout_1 + TCLab_Implementation_P.Bias_Bias) * b_mN_tmp +
    (1.0F - b_mN_tmp) * TCLab_Implementation_DW.obj.pmN;
  TCLab_Implementation_DW.obj.pwN = b_wN;
  TCLab_Implementation_DW.obj.pmN = TCLab_Implementation_B.MovingAverage;

  /* ModelReference: '<Root>/Model' */
  Controller_implementacion(&TCLab_Implementation_B.Constant,
    &TCLab_Implementation_B.MovingAverage, &TCLab_Implementation_B.Model,
    &(TCLab_Implementation_DW.Model_InstanceData.rtdw));

  /* MATLABSystem: '<Root>/PWM1' */
  TCLab_Implementation_DW.obj_i.PWMDriverObj.MW_PWM_HANDLE = MW_PWM_GetHandle
    (3UL);

  /* Saturate: '<Root>/Saturation' */
  if (TCLab_Implementation_B.Model > TCLab_Implementation_P.Saturation_UpperSat)
  {
    b_wN = TCLab_Implementation_P.Saturation_UpperSat;
  } else if (TCLab_Implementation_B.Model <
             TCLab_Implementation_P.Saturation_LowerSat) {
    b_wN = TCLab_Implementation_P.Saturation_LowerSat;
  } else {
    b_wN = TCLab_Implementation_B.Model;
  }

  /* DataTypeConversion: '<Root>/Data Type Conversion1' incorporates:
   *  Gain: '<Root>/Gain1'
   *  Saturate: '<Root>/Saturation'
   */
  b_wN = (real32_T)floor((real_T)(TCLab_Implementation_P.Gain1_Gain * b_wN));
  if (rtIsNaNF(b_wN) || rtIsInfF(b_wN)) {
    b_wN = 0.0F;
  } else {
    b_wN = (real32_T)fmod((real_T)b_wN, 256.0);
  }

  /* MATLABSystem: '<Root>/PWM1' incorporates:
   *  DataTypeConversion: '<Root>/Data Type Conversion1'
   */
  MW_PWM_SetDutyCycle(TCLab_Implementation_DW.obj_i.PWMDriverObj.MW_PWM_HANDLE,
                      (real_T)(b_wN < 0.0F ? (int16_T)(uint8_T)(int16_T)
    -(int16_T)(int8_T)(uint8_T)-b_wN : (int16_T)(uint8_T)b_wN));

  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The resolution of this integer timer is 1.0, which is the step size
   * of the task. Size of "clockTick0" ensures timer will not overflow during the
   * application lifespan selected.
   */
  TCLab_Implementation_M->Timing.clockTick0++;
}

/* Model initialize function */
void TCLab_Implementation_initialize(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));
  rtmSetTFinal(TCLab_Implementation_M, 1800.0);

  /* External mode info */
  TCLab_Implementation_M->Sizes.checksums[0] = (2473148885U);
  TCLab_Implementation_M->Sizes.checksums[1] = (3029332073U);
  TCLab_Implementation_M->Sizes.checksums[2] = (587624898U);
  TCLab_Implementation_M->Sizes.checksums[3] = (202977591U);

  {
    static const sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE;
    static RTWExtModeInfo rt_ExtModeInfo;
    static const sysRanDType *systemRan[4];
    TCLab_Implementation_M->extModeInfo = (&rt_ExtModeInfo);
    rteiSetSubSystemActiveVectorAddresses(&rt_ExtModeInfo, systemRan);
    systemRan[0] = &rtAlwaysEnabled;
    systemRan[1] = &rtAlwaysEnabled;
    systemRan[2] = &rtAlwaysEnabled;
    systemRan[3] = &rtAlwaysEnabled;
    rteiSetModelMappingInfoPtr(TCLab_Implementation_M->extModeInfo,
      &TCLab_Implementation_M->SpecialInfo.mappingInfo);
    rteiSetChecksumsPtr(TCLab_Implementation_M->extModeInfo,
                        TCLab_Implementation_M->Sizes.checksums);
    rteiSetTFinalTicks(TCLab_Implementation_M->extModeInfo, 1800);
  }

  /* Model Initialize function for ModelReference Block: '<Root>/Model' */
  Controller_implement_initialize(rtmGetErrorStatusPointer
    (TCLab_Implementation_M), &(TCLab_Implementation_DW.Model_InstanceData.rtm));

  /* Start for MATLABSystem: '<Root>/Analog Input' */
  TCLab_Implementation_DW.obj_d.matlabCodegenIsDeleted = false;
  TCLab_Implementation_DW.obj_d.isInitialized = 1L;
  TCLab_Implementation_DW.obj_d.AnalogInDriverObj.MW_ANALOGIN_HANDLE =
    MW_AnalogInSingle_Open(18UL);
  TCLab_Implementation_DW.obj_d.isSetupComplete = true;

  /* Start for MATLABSystem: '<Root>/Moving Average' */
  TCLab_Implementation_DW.obj.isInitialized = 0L;
  TCLab_Implementation_DW.obj.NumChannels = -1L;
  TCLab_Implementation_DW.obj.FrameLength = -1L;
  TCLab_Implementation_DW.obj.matlabCodegenIsDeleted = false;
  TCLab_Implementation_DW.obj.ForgettingFactor =
    TCLab_Implementation_P.MovingAverage_ForgettingFactor;
  TCLab_Implemen_SystemCore_setup(&TCLab_Implementation_DW.obj);

  /* Start for MATLABSystem: '<Root>/PWM1' */
  TCLab_Implementation_DW.obj_i.matlabCodegenIsDeleted = false;
  TCLab_Implementation_DW.obj_i.isInitialized = 1L;
  TCLab_Implementation_DW.obj_i.PWMDriverObj.MW_PWM_HANDLE = MW_PWM_Open(3UL,
    0.0, 0.0);
  TCLab_Implementation_DW.obj_i.isSetupComplete = true;

  /* SystemInitialize for ModelReference: '<Root>/Model' */
  Controller_implementacion_Init
    (&(TCLab_Implementation_DW.Model_InstanceData.rtdw));

  /* InitializeConditions for MATLABSystem: '<Root>/Moving Average' */
  TCLab_Implementation_DW.obj.pwN = 0.0F;
  TCLab_Implementation_DW.obj.pmN = 0.0F;
}

/* Model terminate function */
void TCLab_Implementation_terminate(void)
{
  /* Terminate for MATLABSystem: '<Root>/Analog Input' */
  if (!TCLab_Implementation_DW.obj_d.matlabCodegenIsDeleted) {
    TCLab_Implementation_DW.obj_d.matlabCodegenIsDeleted = true;
    if ((TCLab_Implementation_DW.obj_d.isInitialized == 1L) &&
        TCLab_Implementation_DW.obj_d.isSetupComplete) {
      TCLab_Implementation_DW.obj_d.AnalogInDriverObj.MW_ANALOGIN_HANDLE =
        MW_AnalogIn_GetHandle(18UL);
      MW_AnalogIn_Close
        (TCLab_Implementation_DW.obj_d.AnalogInDriverObj.MW_ANALOGIN_HANDLE);
    }
  }

  /* End of Terminate for MATLABSystem: '<Root>/Analog Input' */

  /* Terminate for MATLABSystem: '<Root>/Moving Average' */
  if (!TCLab_Implementation_DW.obj.matlabCodegenIsDeleted) {
    TCLab_Implementation_DW.obj.matlabCodegenIsDeleted = true;
    if ((TCLab_Implementation_DW.obj.isInitialized == 1L) &&
        TCLab_Implementation_DW.obj.isSetupComplete) {
      TCLab_Implementation_DW.obj.NumChannels = -1L;
      TCLab_Implementation_DW.obj.FrameLength = -1L;
    }
  }

  /* End of Terminate for MATLABSystem: '<Root>/Moving Average' */

  /* Terminate for MATLABSystem: '<Root>/PWM1' */
  if (!TCLab_Implementation_DW.obj_i.matlabCodegenIsDeleted) {
    TCLab_Implementation_DW.obj_i.matlabCodegenIsDeleted = true;
    if ((TCLab_Implementation_DW.obj_i.isInitialized == 1L) &&
        TCLab_Implementation_DW.obj_i.isSetupComplete) {
      TCLab_Implementation_DW.obj_i.PWMDriverObj.MW_PWM_HANDLE =
        MW_PWM_GetHandle(3UL);
      MW_PWM_SetDutyCycle
        (TCLab_Implementation_DW.obj_i.PWMDriverObj.MW_PWM_HANDLE, 0.0);
      TCLab_Implementation_DW.obj_i.PWMDriverObj.MW_PWM_HANDLE =
        MW_PWM_GetHandle(3UL);
      MW_PWM_Close(TCLab_Implementation_DW.obj_i.PWMDriverObj.MW_PWM_HANDLE);
    }
  }

  /* End of Terminate for MATLABSystem: '<Root>/PWM1' */
}

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
