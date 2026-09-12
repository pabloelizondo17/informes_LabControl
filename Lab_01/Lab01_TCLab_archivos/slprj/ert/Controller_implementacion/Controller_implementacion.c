/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: Controller_implementacion.c
 *
 * Code generated for Simulink model 'Controller_implementacion'.
 *
 * Model version                  : 1.30
 * Simulink Coder version         : 25.2 (R2025b) 28-Jul-2025
 * C/C++ source code generated on : Wed Sep  9 10:56:02 2026
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: Atmel->AVR
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "Controller_implementacion.h"
#include "rtwtypes.h"
#include "Controller_implementacion_private.h"

/* Exported block parameters */
real32_T Ki_SIMC = 0.0169F;            /* Variable: Ki_SIMC
                                        * Referenced by: '<S35>/Integral Gain'
                                        */
real32_T Kp_SIMC = 3.2039F;            /* Variable: Kp_SIMC
                                        * Referenced by: '<S43>/Proportional Gain'
                                        */
P_Controller_implementacion_T Controller_implementacion_P = {
  /* Variable: Q_max
   * Referenced by:
   *   '<S45>/Saturation'
   *   '<S30>/DeadZone'
   */
  90.0F,

  /* Variable: Q_min
   * Referenced by:
   *   '<S45>/Saturation'
   *   '<S30>/DeadZone'
   */
  0.0F,

  /* Mask Parameter: DiscretePIDController2_InitialC
   * Referenced by: '<S38>/Integrator'
   */
  0.0F,

  /* Computed Parameter: Constant1_Value
   * Referenced by: '<S28>/Constant1'
   */
  0.0F,

  /* Computed Parameter: Clamping_zero_Value
   * Referenced by: '<S28>/Clamping_zero'
   */
  0.0F,

  /* Computed Parameter: Integrator_gainval
   * Referenced by: '<S38>/Integrator'
   */
  1.0F,

  /* Computed Parameter: Constant_Value
   * Referenced by: '<S28>/Constant'
   */
  1,

  /* Computed Parameter: Constant2_Value
   * Referenced by: '<S28>/Constant2'
   */
  -1,

  /* Computed Parameter: Constant3_Value
   * Referenced by: '<S28>/Constant3'
   */
  1,

  /* Computed Parameter: Constant4_Value
   * Referenced by: '<S28>/Constant4'
   */
  -1
};

/* System initialize for referenced model: 'Controller_implementacion' */
void Controller_implementacion_Init(DW_Controller_implementacio_f_T *localDW)
{
  /* InitializeConditions for DiscreteIntegrator: '<S38>/Integrator' */
  localDW->Integrator_DSTATE =
    Controller_implementacion_P.DiscretePIDController2_InitialC;
}

/* Output and update for referenced model: 'Controller_implementacion' */
void Controller_implementacion(const real32_T *rtu_T_ref, const real32_T *rtu_T1,
  real32_T *rty_Q1, DW_Controller_implementacio_f_T *localDW)
{
  real32_T rtb_IntegralGain;
  real32_T rtb_Integrator;
  real32_T rtb_Sum;
  int8_T tmp;
  int8_T tmp_0;

  /* Sum: '<Root>/Sum5' */
  rtb_Integrator = *rtu_T_ref - *rtu_T1;

  /* Gain: '<S35>/Integral Gain' */
  rtb_IntegralGain = Ki_SIMC * rtb_Integrator;

  /* Sum: '<S47>/Sum' incorporates:
   *  DiscreteIntegrator: '<S38>/Integrator'
   *  Gain: '<S43>/Proportional Gain'
   */
  rtb_Sum = Kp_SIMC * rtb_Integrator + localDW->Integrator_DSTATE;

  /* DeadZone: '<S30>/DeadZone' incorporates:
   *  Saturate: '<S45>/Saturation'
   */
  if (rtb_Sum > Controller_implementacion_P.Q_max) {
    rtb_Integrator = rtb_Sum - Controller_implementacion_P.Q_max;
    *rty_Q1 = Controller_implementacion_P.Q_max;
  } else {
    if (rtb_Sum >= Controller_implementacion_P.Q_min) {
      rtb_Integrator = 0.0F;
    } else {
      rtb_Integrator = rtb_Sum - Controller_implementacion_P.Q_min;
    }

    if (rtb_Sum < Controller_implementacion_P.Q_min) {
      *rty_Q1 = Controller_implementacion_P.Q_min;
    } else {
      *rty_Q1 = rtb_Sum;
    }
  }

  /* End of DeadZone: '<S30>/DeadZone' */

  /* Switch: '<S28>/Switch1' incorporates:
   *  Constant: '<S28>/Clamping_zero'
   *  Constant: '<S28>/Constant'
   *  Constant: '<S28>/Constant2'
   *  RelationalOperator: '<S28>/fix for DT propagation issue'
   */
  if (rtb_Integrator > Controller_implementacion_P.Clamping_zero_Value) {
    tmp = Controller_implementacion_P.Constant_Value;
  } else {
    tmp = Controller_implementacion_P.Constant2_Value;
  }

  /* Switch: '<S28>/Switch2' incorporates:
   *  Constant: '<S28>/Clamping_zero'
   *  Constant: '<S28>/Constant3'
   *  Constant: '<S28>/Constant4'
   *  RelationalOperator: '<S28>/fix for DT propagation issue1'
   */
  if (rtb_IntegralGain > Controller_implementacion_P.Clamping_zero_Value) {
    tmp_0 = Controller_implementacion_P.Constant3_Value;
  } else {
    tmp_0 = Controller_implementacion_P.Constant4_Value;
  }

  /* Switch: '<S28>/Switch' incorporates:
   *  Constant: '<S28>/Clamping_zero'
   *  Constant: '<S28>/Constant1'
   *  Logic: '<S28>/AND3'
   *  RelationalOperator: '<S28>/Equal1'
   *  RelationalOperator: '<S28>/Relational Operator'
   *  Switch: '<S28>/Switch1'
   *  Switch: '<S28>/Switch2'
   */
  if ((Controller_implementacion_P.Clamping_zero_Value != rtb_Integrator) &&
      (tmp == tmp_0)) {
    rtb_IntegralGain = Controller_implementacion_P.Constant1_Value;
  }

  /* Update for DiscreteIntegrator: '<S38>/Integrator' incorporates:
   *  Switch: '<S28>/Switch'
   */
  localDW->Integrator_DSTATE += Controller_implementacion_P.Integrator_gainval *
    rtb_IntegralGain;
}

/* Model initialize function */
void Controller_implement_initialize(const char_T **rt_errorStatus,
  RT_MODEL_Controller_implement_T *const Controller_implementacion_M)
{
  /* Registration code */

  /* initialize error status */
  rtmSetErrorStatusPointer(Controller_implementacion_M, rt_errorStatus);
}

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
