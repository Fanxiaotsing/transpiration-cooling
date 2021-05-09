! THIS SUBROUTINE GENERATES THE COMBUSTION GAS PROPERTIES AT
! DIFFERENT TEMPERATURES
!
SUBROUTINE HOTGASPROP(T, MUF, CPF, KF)
IMPLICIT NONE
!
! VARIABLES USED IN HOTGASPROP
!
! T = LOCAL STATIC TEMPERATURE AT THROAT
! MUF = COMBUSTION GAS VISCOSITY
! CPF = COMBUSTION GAS SPECIFIC HEAT
! KF = COMBUSTION GAS THERMAL CONDUCTIVITY
! PRF = COMBUSTION GAS PRANDTL NUMBER
!
! DECLARE VARIABLES
!
DOUBLE PRECISION T, MUF, CPF, KF, PRF
CHARACTER*64 FLUX_METHOD

COMMON /METHODBLK/FLUX_METHOD

!
! GENERATE THERMODYNAMIC PROPERTIES
!
MUF = (-3.19123D-12)*(T**2.0)+(4.21474D-08)*T-(1.91043D-06)
CPF = (-1.76051D-13)*(T**5.0)+(2.389596D-09)*(T**4.0) &
 -(1.12842D-05)*(T**3.0)+(0.0240347)*(T**2.0)-(22.7384*T)+10438
PRF = (-3.63422D-27)*(T**8.0)+(6.93638D-23)*(T**7.0) &
-(5.70795D-19)*(T**6.0)+(2.63999D-15)*(T**5.0) &
-(7.47121D-12)*(T**4.0)+(1.31513D-8)*(T**3.0) &
-(1.39728D-5)*(T**2.0)+(0.00818492)*T-1.4202
KF = MUF*CPF/PRF

IF  (FLUX_METHOD=='plate') THEN
    MUF=(1.0D-6)*1.458*(T**1.5)/(T+110.4)
    CPF=10*(0.021144)*((0.001*T)**9)+9*(-0.45165)*((0.001*T)**8) &
         +8*(3.83286)*((0.001*T)**7)+7*(-15.8513)*((0.001*T)**6) &
         +6*(26.75992)*((0.001*T)**5)+5*(29.9455575)*((0.001*T)**4) &
         +4*(-220.448)*((0.001*T)**3)+3*(388.667)*((0.001*T)**2) &
         +2*(-206.916)*((0.001*T)**1)+1043.76    
    KF=(1.0D-3)*2.648151*(T**1.5)/( T+( 245.4*(10**(-12/T)) ) )
    PRF=MUF*CPF/KF
END IF
    
    
    
RETURN
!
! END HOTGASPROP SUBROUTINE
!
END