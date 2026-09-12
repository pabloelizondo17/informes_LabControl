/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: TCLab_Implementation_types.h
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

#ifndef TCLab_Implementation_types_h_
#define TCLab_Implementation_types_h_
#include "MW_SVD.h"
#include "rtwtypes.h"
#ifndef struct_tag_pMPPJgn69ckPBhypf3vQzD
#define struct_tag_pMPPJgn69ckPBhypf3vQzD

struct tag_pMPPJgn69ckPBhypf3vQzD
{
  MW_Handle_Type MW_ANALOGIN_HANDLE;
};

#endif                                 /* struct_tag_pMPPJgn69ckPBhypf3vQzD */

#ifndef typedef_e_arduinodriver_ArduinoAnalog_T
#define typedef_e_arduinodriver_ArduinoAnalog_T

typedef struct tag_pMPPJgn69ckPBhypf3vQzD e_arduinodriver_ArduinoAnalog_T;

#endif                             /* typedef_e_arduinodriver_ArduinoAnalog_T */

#ifndef struct_tag_FIY6N64L77TlG9jHBRqBuB
#define struct_tag_FIY6N64L77TlG9jHBRqBuB

struct tag_FIY6N64L77TlG9jHBRqBuB
{
  boolean_T matlabCodegenIsDeleted;
  int32_T isInitialized;
  boolean_T isSetupComplete;
  e_arduinodriver_ArduinoAnalog_T AnalogInDriverObj;
};

#endif                                 /* struct_tag_FIY6N64L77TlG9jHBRqBuB */

#ifndef typedef_codertarget_arduinobase_inter_T
#define typedef_codertarget_arduinobase_inter_T

typedef struct tag_FIY6N64L77TlG9jHBRqBuB codertarget_arduinobase_inter_T;

#endif                             /* typedef_codertarget_arduinobase_inter_T */

#ifndef struct_tag_7VFuPw0vSNrn5pRgG8Mc4C
#define struct_tag_7VFuPw0vSNrn5pRgG8Mc4C

struct tag_7VFuPw0vSNrn5pRgG8Mc4C
{
  MW_Handle_Type MW_PWM_HANDLE;
};

#endif                                 /* struct_tag_7VFuPw0vSNrn5pRgG8Mc4C */

#ifndef typedef_e_matlabshared_ioclient_perip_T
#define typedef_e_matlabshared_ioclient_perip_T

typedef struct tag_7VFuPw0vSNrn5pRgG8Mc4C e_matlabshared_ioclient_perip_T;

#endif                             /* typedef_e_matlabshared_ioclient_perip_T */

#ifndef struct_tag_RWocY1aAVmuibq0rYX5t0G
#define struct_tag_RWocY1aAVmuibq0rYX5t0G

struct tag_RWocY1aAVmuibq0rYX5t0G
{
  boolean_T matlabCodegenIsDeleted;
  int32_T isInitialized;
  boolean_T isSetupComplete;
  e_matlabshared_ioclient_perip_T PWMDriverObj;
};

#endif                                 /* struct_tag_RWocY1aAVmuibq0rYX5t0G */

#ifndef typedef_codertarget_arduinobase_int_j_T
#define typedef_codertarget_arduinobase_int_j_T

typedef struct tag_RWocY1aAVmuibq0rYX5t0G codertarget_arduinobase_int_j_T;

#endif                             /* typedef_codertarget_arduinobase_int_j_T */

#ifndef struct_tag_BlgwLpgj2bjudmbmVKWwDE
#define struct_tag_BlgwLpgj2bjudmbmVKWwDE

struct tag_BlgwLpgj2bjudmbmVKWwDE
{
  uint32_T f1[8];
};

#endif                                 /* struct_tag_BlgwLpgj2bjudmbmVKWwDE */

#ifndef typedef_cell_wrap_TCLab_Implementatio_T
#define typedef_cell_wrap_TCLab_Implementatio_T

typedef struct tag_BlgwLpgj2bjudmbmVKWwDE cell_wrap_TCLab_Implementatio_T;

#endif                             /* typedef_cell_wrap_TCLab_Implementatio_T */

#ifndef struct_tag_4DbVzVIlnQgq6Gv1B9YRvG
#define struct_tag_4DbVzVIlnQgq6Gv1B9YRvG

struct tag_4DbVzVIlnQgq6Gv1B9YRvG
{
  boolean_T matlabCodegenIsDeleted;
  int32_T isInitialized;
  boolean_T isSetupComplete;
  boolean_T TunablePropsChanged;
  cell_wrap_TCLab_Implementatio_T inputVarSize;
  real32_T ForgettingFactor;
  int32_T NumChannels;
  int32_T FrameLength;
  real32_T pwN;
  real32_T pmN;
  real32_T plambda;
};

#endif                                 /* struct_tag_4DbVzVIlnQgq6Gv1B9YRvG */

#ifndef typedef_dsp_simulink_MovingAverage_TC_T
#define typedef_dsp_simulink_MovingAverage_TC_T

typedef struct tag_4DbVzVIlnQgq6Gv1B9YRvG dsp_simulink_MovingAverage_TC_T;

#endif                             /* typedef_dsp_simulink_MovingAverage_TC_T */

/* Parameters (default storage) */
typedef struct P_TCLab_Implementation_T_ P_TCLab_Implementation_T;

/* Forward declaration for rtModel */
typedef struct tag_RTM_TCLab_Implementation_T RT_MODEL_TCLab_Implementation_T;

#endif                                 /* TCLab_Implementation_types_h_ */

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
