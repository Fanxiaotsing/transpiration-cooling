! THIS SUBROUTINE CALCULATES THE ADIABATIC WALL TEMPERATURE
!
SUBROUTINE FINDTAW(TG, T0G, TWH, TAW)
IMPLICIT NONE
!
! VARIABLES USED IN FINDTAW
!
! TG = STATIC COMBUSTION GAS TEMPERATURE AT THROAT
! TOG = COMBUSTION GAS STAGNATION TEMPERATURE
! TWH = HOT GAS SIDE SOLID SURFACE TEMPERATURE
! TAW = ADIABATIC WALL TEMPERATURE
! DELTA = CONVERGENCE CRITERIA
! TFNEW = NEW FILM TEMPERATURE
! TFOLD = OLD FILM TEMPERATURE
! MLJF = COMBUSTION GAS VISCOSITY AT FILM TEMPERATURE
! CPF = COMBUSTION GAS SPECIFIC HEAT AT FILM TEMPERATURE
! KF = COMBUSTION GAS THERMAL CONDUCTIVITY AT FILM TEMPERATURE
! PRF = COMBUSTION GAS PRANDTL NUMBER AT FILM TEMPERATURE
!
! DECLARE VARIABLES
!
DOUBLE PRECISION TG, T0G,TWH, TAW, DELTA, TFNEW, TFOLD, MUF
DOUBLE PRECISION CPF, KF, PRF
!
! INITIALIZE VAFUABLES
!
DELTA = 9999.0
TFOLD = (TWH+T0G)/2.0
!
! BEGIN MAIN LOOP AND ITERATE UNTIL CONVERGED ON CORRECT FILM
! TEMPERATURE
!
DO WHILE (DELTA.GE.1D-04)
!
! GENERATE COMBUSTION GAS PROPERTIES AT OLD FILM TEMPERATURE
!
CALL HOTGASPROP(TFOLD, MUF, CPF, KF)
!
! CALCULATE NEW PRANDTL NUMBER ADIABATIC WALL TEMPERATURE AND
! FILM TEMPERATURE
!
PRF = (MUF*CPF)/KF
TAW = (PRF**(1.0/3.0))*(T0G-TG)+TG
TFNEW = TWH+0.23*(TG-TWH)+0.19*(TAW-TWH)
!
! COMPARE OLD AND NEW FILM TEMPERATURES TO CHECK FOR CONVERGENCE
!
DELTA = (TFNEW-TFOLD)**2.0
TFOLD = TFNEW
!
! END MAIN LOOP
!
END DO
RETURN
!
! END FINDTAW SUBROUTINE
!
END
!

