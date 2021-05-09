! THIS SUBROUTINE PROVIDES THE INITIAL CONDITIONS AND CONSTANTS
! USED IN THE REST OF THE PROGRAM
!
SUBROUTINE INPUT(TSOLD, TLOLD, DIFFLIM, TLNEW)
IMPLICIT NONE
!
! VARIABLES USED IN INPUT
!
! TSOLD = VECTOR OF POROUS SOLID TEMPERATURE AT PREVIOUS TIME STEP
! TLOLD = VECTOR OF TRANSPIRATION COOLANT TEMPERATURE AT PREVIOUS
! TIME STEP
! EPS = POROSITY OF THE POROUS SOLID
! R = POROUS SPHERE RADIUS
! TB = BULK TEMPERATURE OF THE COOLANT IN THE COOLANT CHANNEL
! DX = X DISTANCE STEP SIZE THROUGH WALL
! CO = PROPORTIONALITY CONSTANT USED TO DETERMINE SOLID SURFACE AREA
! MDOTC = MASS FLOW RATE OF COOLANT IN COOLANT CHANNEL
! DH = HYDRAULIC DIAMETER OF COOLANT CHANNEL
! PB = COOLANT LINE PRESSURE (BULK CONDITIONS)
! PI = 3.14159
! THROATD = NOZZLE AERODYNAMIC THROAT DIAMETER
! MDOTF = MASS FLOW RATE OF COMBUSTION PRODUCTS
! W = VISCOSITY, TEMPERATURE EXPONENT
! PH = HYDRAULIC PERIMETER OF COOLANT CHANNEL
! GAM = RATIO OF SPECIFIC HEATS OF COMBUSTION PRODUCTS
! TOG = STAGNATION TEMPERATURE OF COMBUSTION PRODUCTS
! TG = STATIC TEMPERATURE OF COMBUSTION PRODUCTS AT THROAT
! DELTAP = CHANGE IN PRESSURE ACROSS THE POROUS WALL
! THICKNESS = POROUS NOZZLE WALL THICKNESS AT THROAT
! PERMEABLE = POROUS WALL PERMEABILITY
! RHOLAVG = AVERAGE COOLANT DENSITY
! MULAVG = AVERAGE COOLANT VISCOSITY
! PLAVG = AVERAGE PRESSURE WITHIN POROUS WALL
! PTHROAT = STATIC THROAT PRESSURE
! RHOB = COOLANT DENSITY AT BULK CONDITIONS
! DP = PRESSURE STEP SIZE THROUGH WALL
! RHOS = SOLID DENSITY
! CPS = SOLID SPECIFIC HEAT
! KW = SOLID THERMAL CONDUCTIVITY
! MUB = COOLANT VISCOSITY AT BULK CONDITIONS
! KB = COOLANT THERMAL CONDUCTIVITY AT BULK CONDITIONS
! CPB = COOLANT SPECIFIC HEAT, CONSTANT PRESSURE, AT BULK CONDITIONS
! DIFFLIM = SPECIFIED TOLERANCE USED TO DETERMINE CONVERGENCE
! PBB = COOLANT CHANNEL PRESSURE FOR REGENERATIVE COOLING CASE
! TLAVG = AVERAGE COOLANT TEMPERATURE THROUGH POROUS WALL
! MUOF = COMBUSTION PRODUCTS VISCOSITY AT TOG
! CPOF = COMBUSTION PRODUCTS SPECIFIC HEAT AT TOG
! PROF = COMBUSTION PRODUCTS PRANDTL NUMBER AT TOG
! TLNEW = COOLANT TEMPERATURE AT NEW TIME STEP
! KLAVG = COOLANT THERMAL CONDUCTIVITY AT TLAVG AND PLAVG
! CPLAVG = COOLANT SPECIFIC HEAT AT TLAVG AND PLAVG
! TLSTART = INITIAL COOLANT TEMPERATURE AT FRST GRID POINT
! TLEND = INITIAL COOLANT TEMPERATURE AT LAST GRID POINT
! DTEMP = INCREMENTAL CHANGE IN TEMPERATURE FOR INITIAL PROFILE
! HCL = PACKED BED OF SPHERES HEAT TRANSFER COEFFICIENT
! MDOTL = MASS FLOW RATE OF COOLANT THROUGH POROUS WALL
! N = INDEX USED FOR SOLID TEMPERATURE ARRAY
! M = INDEX USED FOR COOLANT TEMPERATURE ARRAY
! LASTX = GRID SIZE
! FILE1 = FILENAME USED TO STORE OUTPUT
!
! DECLARE THE VARIABLES
!
DOUBLE PRECISION TSOLD, TLOLD, EPS, R, TB, DX, C0
DOUBLE PRECISION MDOTC, DH, PB, PI, THROATD, MDOTF, W, PH
DOUBLE PRECISION GAM, T0G, TG, DELTAP, THICKNESS, PERMEABLE
DOUBLE PRECISION RHOLAVG, MULAVG, PLAVG, PTHROAT, RHOB
DOUBLE PRECISION DP, RHOS, CPS, KW, MUB, KB, CPB, DIFFLIM
DOUBLE PRECISION PBB, TLAVG, MU0F, CP0F, PR0F, TLNEW
DOUBLE PRECISION KLAVG, CPLAVG, TLSTART, TLEND, DTEMP
DOUBLE PRECISION HCL, MDOTL
INTEGER LASTX, N, M
CHARACTER*64 FILE1,FILE2,FILE3
CHARACTER*64 FLUX_METHOD,COOLANT_MATERIAL
DOUBLE PRECISION MASS_FLOW_GAS,Ma,Tt,BR,Pt
!
! DIMENSION THE VARIABLES THAT ARE ARRAYS
!
DIMENSION TSOLD(20000), TLOLD(20000), TLNEW(20000)
! THIS COMMON BLOCK CONTAINS THE GRlD DIMENSIONS USED
!
COMMON /DIMEN/LASTX, DX
!
! THIS COMMON BLOCK CONTAINS THE OUTPUT FILENAME
!
COMMON /FILEBLK/FILE1
COMMON /ERROR_BR_FILEBLK/FILE2
COMMON /ERROR_STAB_FILEBLK/FILE3
!
! THIS COMMON BLOCK CONTAINS THE METHOD TO CALCULATE THE HEAT FLUX 
!
COMMON /METHODBLK/FLUX_METHOD
COMMON /MATERIALBLK/COOLANT_MATERIAL
COMMON /HGBLK/MASS_FLOW_GAS
!
! THIS COMMON BLOCK CONTAINS VARIABLES COMMON TO TSOLID AND TLIQUID
!
COMMON /TSTL/C0, EPS, R, PB, TB, KW, MDOTL
!
! THIS COMMON BLOCK CONTAINS VARIABLES USED IN TLIQUID ONLY
!
COMMON /TLBLK/ PLAVG, TLAVG, RHOB, DP ,DELTAP ,PERMEABLE ,THICKNESS
!
! THIS COMMON BLOCK CONTAINS VARIABLES USED IN TSOLID ONLY
!
COMMON /TSBLK/ RHOS, CPS, MDOTC, DH, PI, THROATD, MDOTF
COMMON /TSBLK/ PH, W, GAM, T0G, TG, PBB, MU0F, CP0F, PR0F
!
! SPECIFY CONSTANT VALUES
!
PI = 3.14159
! PTHROAT = STATIC THROAT PRESSURE
!PTHROAT = 11.890000000D6
! PBB = COOLANT CHANNEL PRESSURE FOR REGENERATIVE COOLING CASE
!PBB = 41.37D6
!THICKNESS = 7.112D-4
! TB = BULK TEMPERATURE OF THE COOLANT IN THE COOLANT CHANNEL
!TB = 138.89

! THROATD = NOZZLE AERODYNAMIC THROAT DIAMETER
!THROATD = 0.26006

! DH = HYDRAULIC DIAMETER OF COOLANT CHANNEL
!DH = 1.45143D-03
! PH = HYDRAULIC PERIMETER OF COOLANT CHANNEL
!PH = 7.112D-03
! MDOTC = MASS FLOW RATE OF COOLANT IN COOLANT CHANNEL
!MDOTC = 3.344D-02

!RHOS = SOLID DENSITY
!RHOS = 19300.0
! CPS = SOLID SPECIFIC HEAT
!CPS = 129.0

!!COMBUSTION PRODUCTS
!TOG = STAGNATION TEMPERATURE OF COMBUSTION PRODUCTS
!T0G = 3656.7
!TG = STATIC TEMPERATURE OF COMBUSTION PRODUCTS AT THROAT
!TG = 3439.4
! W = VISCOSITY, TEMPERATURE EXPONENT
!W = 0.875
!GAM = RATIO OF SPECIFIC HEATS OF COMBUSTION PRODUCTS
!GAM = 1.1481
!MDOTF = MASS FLOW RATE OF COMBUSTION PRODUCTS
!MDOTF = 468.3134
!MUOF = COMBUSTION PRODUCTS VISCOSITY AT TOG
!MU0F = 1.10236699599D-4
!CPOF = COMBUSTION PRODUCTS SPECIFIC HEAT AT TOG
!CP0F = 3740.68492
!PROF = COMBUSTION PRODUCTS PRANDTL NUMBER AT TOG
!PR0F = 0.6151
!
! READ M VARIABLES SPECIFIC TO THIS RUN
!
OPEN(15,file='input_control.txt')
READ (15,*) FLUX_METHOD
READ (15,*) FILE1,FILE2,FILE3
READ (15,*) DIFFLIM
READ (15,*) LASTX,THICKNESS
READ (15,*) EPS,R
READ (15,*) RHOS,CPS,KW
READ (15,*) COOLANT_MATERIAL
CLOSE(15)

IF  (FLUX_METHOD=='rocket') THEN
    OPEN(16,file='rocket_input.txt')
    ! PB = COOLANT LINE PRESSURE (BULK CONDITIONS),! PTHROAT = STATIC THROAT PRESSURE
    READ (16,*) PB,PTHROAT
    READ (16,*) TB
    READ (16,*) T0G,TG
    READ (16,*) W 
    READ (16,*) GAM
    READ (16,*) MDOTF
    
    READ (16,*) MU0F
    READ (16,*) CP0F 
    READ (16,*) PR0F
    
    READ (16,*) THROATD
    
    READ (16,*) DH 
    READ (16,*) PH 
    READ (16,*) MDOTC
    CLOSE(16)
END IF
!
IF  (FLUX_METHOD=='plate') THEN
    OPEN(17,file='plate_input.txt')
    ! PB = COOLANT LINE PRESSURE (BULK CONDITIONS),! PTHROAT = STATIC THROAT PRESSURE
   
    READ (17,*) Ma
    READ (17,*) Tt
    READ (17,*) Pt
    
    READ (17,*) BR
    READ (17,*) TB
    
    CLOSE(17)
    
    T0G=Tt
    TG =T0G/(1.0+(1.4-1)/2.0*Ma*Ma)
    !IF Total pressure
    !PTHROAT=Pt/( (1.0+(1.4-1)/2.0*Ma*Ma)**(1.4/(1.4-1)) )
    !IF static pressure
    PTHROAT=Pt
    MASS_FLOW_GAS=PTHROAT*Ma*sqrt(1.4/287/TG)
    MDOTL=BR*MASS_FLOW_GAS
END IF

OPEN (UNIT= 14, FILE=FILE1)
!
! WRITE THE DATA TO THE OUTPUT FILE
!
WRITE (14,*) MDOTL
    
!
! CALCULATE THE REST OF THE NECESSARY VARIABLES FROM KNOWN VALUES
!
C0=3.0*(1-EPS)
DX = THICKNESS/LASTX
PLAVG=PTHROAT
IF (R.GT.1.0D-9) THEN
PERMEABLE = ((2.0*R)**2.0)*(EPS**3.0)/(150.0*((1.0-EPS)**2.0))
END IF
IF (R.LT.1.0D-9) THEN
PERMEABLE=R
R=1.0/2*SQRT( 150*PERMEABLE*(1-EPS)*(1-EPS)/(EPS**3.0) )
END IF


TLSTART = TB
TLEND   = TB
DTEMP = (TLEND-TLSTART)/LASTX
!
! SPECIFY THE BEGINNING LIQUID AND SOLID TEMPERATURE PROFILES
!
DO N= 1,(LASTX+1)
M = N + 2
TLOLD(M) = TLSTART + DTEMP*(N-1)
TSOLD(N) = TLOLD(M)
TLNEW(M) = TLOLD(M)
END DO
!
! SPECIFY NEW AND OLD COOLANT TEMPERATURES JUST PRIOR TO THE
! POROUS WALL SURFACE
!
TLOLD(1) = TB
TLOLD(2) = TB
TLNEW(1) = TB
TLNEW(2) = TB
!
  

RETURN
!
! END INPUT SUBROUTINE
!
END
!