    PROGRAM transpiration_cooling
!
! THIS PROGRAM CALCULATES THE TEMPERATURE PROFILES
! FOR A POROUS SOLID AND THE LIQUID TRANSPIRATION
! COOLANT OF A ROCKET NOZZLE WITH THE SPACE SHUTTLE
! MAIN ENGINE MAIN COMBUSTION CHAMBER COMBUSTION PRODUCTS,
! HYDROGEN COOLANT. AND NOZZLE GEOMETRY
!
IMPLICIT NONE
!
! VARIABLES USED IN MAIN PROGRAM
!
! TSOLD = VECTOR OF POROUS SOLID TEMPERATURE AT PREVIOUS TIME STEP
! TLOLD = VECTOR OF TRANSPIRATION COOLANT TEMPERATURE AT PREVIOUS
! TIME STEP
! TSNEW = SOLD TEMPERATURE AT NEW TIME STEP
! TLNEW = COOLANT TEMPERATURE AT NEW TIME STEP
! DX = X DISTANCE STEP SIZE THROUGH WALL
! RHOLAVG = AVERAGE COOLANT DENSITY
! MULAVG = AVERAGE COOLANT VISCOSITY
! DIFF = TOLERANCE USED TO DETERMINE CONVERGENCE
! DELTAS = SUM OF THE SQUARES DIFFERENCE OF SOLID TEMPERATURES
! DELTAL = SUM OF THE SQUARES DIFFERENCE OF COOLANT TEMPERATURES
! KL = LOCAL COOLANT THERMAL CONDUCTIVITY
! DIFFLIM = SPECIFIED TOLERANCE USED TO DETERMINE CONVERGENCE
! N = INDEX USED FOR SOLID TEMPERATURE ARRAY
! M = INDEX USED FOR COOLANT TEMPERATUFU ARRAY
! LASTX = GRID SIZE
! STEP = COUNTER THAT INDICATES NUMBER OF ITERATIONS OF MAIN LOOP
!
! DECLARE THE VARIABLES
!
DOUBLE PRECISION TSOLD, TLOLD, TSNEW, TLNEW, DX
DOUBLE PRECISION  DIFF,HCL,PL
DOUBLE PRECISION DELTAS, DELTAL, KL, DIFFLIM
INTEGER N, M, LASTX, STEP
!
! DIMENSION THE VARIABLES THAT ARE ARRAYS
!
DIMENSION TSOLD(20000), TLOLD(20000), TSNEW(20000), TLNEW(20000)
DIMENSION KL(20000) ,PL(20000) ,HCL(20000)
!
! THIS COMMON BLOCK CONTAINS THE GRID DIMENSIONS USED
!
COMMON /DIMEN/LASTX, DX
!
! BEGIN THE PROGRAM BY SPECIFYING THE INITIAL CONDITIONS
!
CALL INPUT(TSOLD, TLOLD, DIFFLIM, TLNEW)
!
! INITIALIZE THE CONVERGENCE CRITERIA VARIABLE, DIFF. TO A VERY
! LARGE NUMBER TO BEGIN MAIN LOOP
!
DIFF = 9999.0
STEP = 0
!
! BEGIN THE MAIN LOOP AND CONTINUE TO ITERATE UNTIL THE SUM OF
! THE SQUARES OF THE SOLID AND COOLANT TEMPERATURES IS LESS THAN
! THE SPECIFIED TOLERANCE, DIFFLIM
!
DO WHILE (DIFF.GE.(DIFFLIM))
!
! CALCULATE A NEW COOLANT TEMPERATURE PROFILE BASED ON PREVIOUS
! TIME STEP SOLID TEMPERATURE PROFILE. ALSO GENERATE NEW COOLANT
! THERMAL CONDUCTIVITIES, AVERAGE VISCOSITY, AND AVERAGE DENSITY
!
CALL TLIQUID(TSOLD, TLOLD, HCL, TLNEW)
!
! CALCULATE A NEW SOLID TEMPERAW PROFILE BASED ON NEW COOLANT
! TEMPERATURE PROFILE, AND COOLANT THERMAL CONDUCTIVITIES
!
CALL TSOLID(TSOLD, TLOLD ,HCL ,TSNEW)
!
! INITIALIZE THE SUM OF THE SQUARES DIFFERENCES. DELTAS AND DELTAL
! TO ZERO BEFORE SUMMING TERMS
!
DELTAS = 0.0
DELTAL = 0.0
!
! SUM UP THE SQUARES OF THE DIFFERENCES BETWEEN THE SOLID AND COOLANT
! TEMPERATURES
!
DO N= 1,(LASTX+1)
M=N+2
DELTAS = DELTAS + ((TSNEW(N)-TSOLD(N))**2.0)
DELTAL = DELTAL + ((TLNEW(M)-TLOLD(M))**2.0)
END DO
!
! THE TOLERANCE VARIABLE, DIFF, IS ASSIGNED THE SUM OF THE SQUARES
!
DIFF = DELTAS + DELTAL
!
! ASSIGN THE NEW TIME STEP VALUES TO THE PREVIOUS TIME STEP VARIABLES
!
DO N= 1,(LASTX+1)
M=N+2
TSOLD(N)= TSNEW(N)
TLOLD(M)= TLNEW(M)
END DO
!
! INCREMENT THE ITERATION COUNTER
!
 STEP=STEP+1
!
! END THE MAIN LOOP
!
END DO
!
! SEND THE NEWEST TEMPERATURE PROFILES TO THE OUTPUT SUBROUTINE TO
! BE STORED IN A FILE
!
CALL OUTPUT(TSNEW, TLNEW)
!
! END THE MAIN PROGRAM
!
STOP

END
!