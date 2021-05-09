! THIS SUBROUTINE SENDS THE TEMPERATURE PROFILES TO THE SPECIFIED
! FILENAME, AND THE SCREEN
!
SUBROUTINE OUTPUT(TSNEW, TLNEW)
IMPLICIT NONE
!
! VARIABLES USED IN OUTPUT
!
! DX = INCREMENTAL DISTANCE STEP
! TSNEW = SOLID TEMPERATURE PROFILE AT NEW TIME STEP
! TLNEW = COOLANT TEMPERATURE PROFILE AT NEW TIME STEP
! PB = COOLANT LINE PRESSURE
! R = POROUS SPHERE RADIUS
! CO = PROPORTIONALITY CONSTANT FOR POROUS SOLID SURFACE AREA
! EPS = POROSITY
! KW = SOLID THERMAL CONDUCTIVITY
! MDOTL = COOLANT MASS FLOW RATE THROUGH POROUS SOLID
! BR = BLOWING RATIO
! HCS = COLD GAS SIDE HEAT TRANSFER COEFFICIENT
! HG = HOT GAS SIDE HEAT TRANSFER COEFFICIENT
! HCL = PACKED BED OF SPHERES HEAT TRANSFER COEFFICIENT
! TAW = ADIABATIC WALL TEMPERATURE
! TB = COOLANT BULK TEMPERATURE
! N = INDEX USED FOR SOLID TEMPERATURE ARRAY
! M = INDEX USED FOR COOLANT TEMPERATURE ARRAY
! LASTX = GRID SIZE
! FILE1 = OUTPUT FILENAME
!
! DECLARE VARIABLES
!
DOUBLE PRECISION DX, TSNEW, TLNEW, PB, R, C0, EPS, KW
DOUBLE PRECISION MDOTL, BR, HCS, HG, HCL, TAW, TB
INTEGER N, M, LASTX
CHARACTER*64 FILE1
!
! DIMENSION VARIABLES THAT ARE ARRAYS
!
DIMENSION TSNEW(20000), TLNEW(20000)
!
! THIS COMMON BLOCK CONTAINS THE GRID DIMENSIONS
!
COMMON /DIMEN/LASTX, DX
!
! THIS COMMON BLOCK CONTAINS VARIABLES COMMON TO TSOLID AND TLIQUID
!
COMMON /TSTL/C0, EPS, R, PB, TB, KW, HCL, MDOTL
!
! THIS COMMON BLOCK CONTAINS THE OUTPUT FILENAME
!
COMMON /FILEBLK/FILE1
!
! THIS COMMON BLOCK CONTAINS OUTPUT DATA FROM HOTGAS
!
COMMON /RATIOBLK/BR
!
! THIS COMMON BLOCK CONTAINS OUTPUT DATA FROM TSOLID
!
COMMON /SOLBLK/HCS, HG, TAW
!
! OPEN THE OUTPUT FILE
!
OPEN (UNIT= 14, FILE=FILE1)
!
! WRITE THE DATA TO THE OUTPUT FILE
!
WRITE (14,*) PB
DO N=1,(LASTX+1)
M = N+2
WRITE (14,10) 1000.0*(N-1)*DX, TSNEW(N), TLNEW(M)
END DO
CLOSE(14)
!
!
! FORMATTED OUTPUT STATEMENT
!
10 FORMAT (1X,F15.9,1X,F15.9,1X,F15.9)
RETURN
!
! END OUTPUT SUBROUTINE
!
END
!
