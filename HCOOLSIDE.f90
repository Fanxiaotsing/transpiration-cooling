! THIS SUBROUTINE CALCULATES THE COLD GAS SIDE HEAT TRANSFER
! COEFFICIENT GIVEN COOLANT BULK PRESSURE AND TEMPERATURE,
! POROUS SOLID TEMPERATURE, MASS FLOW RATE THROUGH THE COOLANT
! CHANNEL, AND HYDRAULIC DIAMETER AND PERIMETER
!
SUBROUTINE HCOOLSIDE(PB, TB, TS, MDOT, DH, PH,HCS)
IMPLICIT NONE
!
! VARIABLES USED IN HCOOLSIDE
!
! PB = COOLANT LINE PRESSURE (BULK CONDITIONS)
! TB = COOLANT BULK TEMPERATURE IN COOLANT CHANNEL
! TS = SURFACE TEMPERATURE OF POROUS SOLID ON COLD GAS SIDE
! MDOT = MASS FLOW RATE OF COOLANT IN COOLANT CHANNEL
! DH = HYDRAULIC DIAMETER OF COOLANT CHANNEL
! PH = HYDRAULIC PERIMETER OF COOLANT CHANNEL
! HCS = COLD GAS SIDE HEAT TRANSFER COEFFICIENT
! MUB = COOLANT VISCOSITY AT BULK CONDITIONS
! KB = COOLANT THERMAL CONDUCTIVITY AT BULK CONDITIONS
! RHOB = COOLANT DENSITY AT BULK CONDITIONS
! CPB = COOLANT SPECIFIC HEAT AT BULK CONDITIONS
! h4ULS = COOLANT VISCOSITY AT SOLID SURFACE TEMPERATURE
! KLS = COOLANT THERMAL CONDUCTIVITY AT SOLID SURFACE TEMPERATURE
! RHOLS = COOLANT DENSITY AT SOLID SURFACE TEMPERATURE
! CPLS = COOLANT SPECIFIC HEAT AT SOLID SURFACE TEMPERATURE
! PRB = PRANDTL NUMBER AT BULK CONDITIONS
! REDB = REYNOLD'S NUMBER AT BULK CONDITIONS
!
! DECLARE VARIABLES
!
DOUBLE PRECISION PB, TB, TS, MDOT, DH, PH, HCS
DOUBLE PRECISION MUB, KB, RHOB, CPB, MULS, KLS, RHOLS, CPLS
DOUBLE PRECISION PRB, REDB
DOUBLE PRECISION C0,EPS,R,PB1,TB1,KW,HCL,MDOTL
CHARACTER*64 COOLANT_MATERIAL,FLUX_METHOD

COMMON /MATERIALBLK/COOLANT_MATERIAL
COMMON /METHODBLK/FLUX_METHOD
COMMON /TSTL/C0, EPS, R, PB1, TB1, KW, MDOTL
!
! GENERATE HYDROGEN PROPERTIES AT BULK CONDITIONS
!
IF       (COOLANT_MATERIAL=='H2')  THEN
CALL H2PROP(PB, TB, MUB, KB, RHOB, CPB)
ELSE IF  (COOLANT_MATERIAL=='H2O') THEN
    
ELSE IF  (COOLANT_MATERIAL=='CO2') THEN
ELSEIF   (COOLANT_MATERIAL=='N2')  THEN
CALL N2PROP(PB, TB, MUB, KB, RHOB, CPB)    
    
    
ELSE IF  (COOLANT_MATERIAL=='Air') THEN
CALL AIRPROP(PB, TB, MUB, KB, RHOB, CPB)    
ELSE IF  (COOLANT_MATERIAL=='Ar')  THEN
    
ELSE IF  (COOLANT_MATERIAL=='He')  THEN
    
END IF

!
! GENERATE HYDROGEN PROPERTIES AT SOLID SURFACE TEMPERATURE
!

IF       (COOLANT_MATERIAL=='H2')  THEN
CALL H2PROP(PB, TS, MULS, KLS, RHOLS, CPLS)
ELSE IF  (COOLANT_MATERIAL=='H2O') THEN
    
ELSE IF  (COOLANT_MATERIAL=='CO2') THEN
    
ELSEIF       (COOLANT_MATERIAL=='N2')  THEN
CALL N2PROP(PB,TS, MULS, KLS, RHOLS, CPLS)

ELSE IF  (COOLANT_MATERIAL=='Air') THEN
CALL AIRPROP(PB, TS, MULS, KLS, RHOLS, CPLS)   
ELSE IF  (COOLANT_MATERIAL=='Ar')  THEN
    
ELSE IF  (COOLANT_MATERIAL=='He')  THEN
    
END IF


!
! CALCULATE THE COLD GAS SIDE HEAT TRANSFER COEFFICENT
! IF CHANNEL  FLOW
IF  (FLUX_METHOD=='rocket') THEN
!
! CALCULATE PRANDTL NUMBER AND REYNOLD'S NUMBER
!
PRB = (MUB*CPB)/KB
REDB = (4.0*MDOT)/(MUB*PH)    
HCS = ((KB*0.027)/DH)*(REDB**0.8)*(PRB**(1.0/3.0))*((MUB/MULS)**0.14)
END IF
! ELSEIF ACTUAL HEAT TRANSFER COEFFICENT
IF  (FLUX_METHOD=='plate') THEN
HCS=MDOTL*CPLS
!HCS=10D10
END IF

RETURN
!
! END HCOOLSIDE SUBROUTINE
!
END
!