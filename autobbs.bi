' Easy-Door V2.60 Automatic Multi-BBS detection
' ---------------------------------------------

' Depending on the filename, the corresponding BBS drop file is used.
' Example: DOOR.EXE C:\RA\DORINFO1.DEF

Ok = 0                          ' Succes flag when reading DOOR file

FileName$ = UCASE$(COMMAND$)
BBSType = -1

IF FileName$ = "" THEN
        FileName$ = "No file Name"
        FullName$ = "Unknown"
        Location$ = "Nowhere"
        Baud$ = "0 BAUD,N,8,1"
        Com$ = "0"
        AnsiFlag$ = "1"
        TimeRemaining$ = "20"
        Security$ = "32768"
        BBSType = 0
ELSE
       
        IF FileExist%(FileName$) THEN
          IF INSTR(FileName$, "DORINFO") THEN BBSType = 1
          IF INSTR(FileName$, "DOOR.SYS") THEN BBSType = 2
          IF RIGHT$(FileName$, 8) = "INFO.BBS" THEN BBSType = 3
          IF INSTR(FileName$, "CALLINF") THEN BBSType = 4
          IF INSTR(FileName$, "SF") AND INSTR(FileName$, ".DAT") THEN BBSType = 5
          IF INSTR(FileName$, "CHAIN.TXT") THEN BBSType = 6
          IF INSTR(FileName$, "PCBOARD") THEN BBSType = 7
          IF INSTR(FileName$, "DOBBS.BAT") THEN BBSType = 8
        END IF
               
        SELECT CASE BBSType

        CASE IS = 1
        ' **************************************************************************
        ' QuickBBS, Remote Access, SuperBBS, RBBS  (DORINFO#.DEF)  Where # = 1,2,3..
        ' **************************************************************************

                OPEN FileName$ FOR INPUT SHARED AS #1

                  LINE INPUT #1, BBS$
                  LINE INPUT #1, No$
                  LINE INPUT #1, No$
                  LINE INPUT #1, Com$: Com$ = RIGHT$(Com$, 1)
                  LINE INPUT #1, Baud$
                  LINE INPUT #1, No$
                  LINE INPUT #1, UserFirst$
                  LINE INPUT #1, UserLast$
                    FullName$ = UserFirst$ + " " + UserLast$
                  LINE INPUT #1, No$
                  LINE INPUT #1, AnsiFlag$
                  LINE INPUT #1, Security$
                  LINE INPUT #1, TimeRemaining$

                CLOSE #1: Ok = 1

        CASE IS = 2
        ' **************************************************************************
        ' Door type for Telegard, Force!, New PcBoard, Gap   (DOOR.SYS)
        ' **************************************************************************

                OPEN FileName$ FOR INPUT SHARED AS #1

                 LINE INPUT #1, Com$: Com$ = MID$(Com$, 4, 1)
                 LINE INPUT #1, Baud$: Baud$ = Baud$ + " Baud"
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, FullName$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, Security$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, TimeRemaining$
                 LINE INPUT #1, AnsiFlag$
                   IF AnsiFlag$ = "GR" OR AnsiFlag$ = "RIP" THEN AnsiFlag$ = "1" ELSE AnsiFlag$ = ""
                CLOSE #1: Ok = 1

        CASE IS = 3
        ' **************************************************************************
        ' Door type for Phoenix BBS   (INFO.BBS)
        ' **************************************************************************

                OPEN FileName$ FOR INPUT SHARED AS #1
                 LINE INPUT #1, FullName$
                 LINE INPUT #1, Baud$
                 LINE INPUT #1, Com$
                 LINE INPUT #1, Security$
                 LINE INPUT #1, Local$
                   IF Local$ = "TRUE" THEN Com$ = "0"
                 LINE INPUT #1, No$
                 LINE INPUT #1, TimeRemaining$
                 LINE INPUT #1, AnsiFlag$
                   IF AnsiFlag$ = "TRUE" THEN AnsiFlag$ = "1" ELSE AnsiFlag$ = ""
                 LINE INPUT #1, No$

                CLOSE #1: Ok = 1

        CASE IS = 4
        ' **************************************************************************
        ' For WildCat BBS, Genesis, Force!   (CALLINFO.BBS)
        ' **************************************************************************

                OPEN FileName$ FOR INPUT SHARED AS #1
                 LINE INPUT #1, FullName$
                 LINE INPUT #1, Baud$
                 Baud$ = Num2Str$(VAL(Baud$))
                 SELECT CASE Baud$
                        CASE IS = "1": Baud$ = "300 Baud"
                        CASE IS = "2": Baud$ = "1200 Baud"
                        CASE IS = "3": Baud$ = "9600 Baud"  ' It's not an error
                        CASE IS = "4": Baud$ = "2400 Baud"  ' They're NOT inverted!
                 END SELECT

                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, TimeRemaining$
                 LINE INPUT #1, AnsiFlag$
                  IF AnsiFlag$ = "MONO" THEN AnsiFlag$ = "" ELSE AnsiFlag$ = "1"
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, Local$
                 LINE INPUT #1, Com$: Com$ = RIGHT$(Com$, 1)

                         IF Local$ = "LOCAL" THEN Com$ = "0"

                CLOSE #1: Ok = 1

        CASE IS = 5
        ' **************************************************************************
        ' For Spitfire   (SFDOOR.DAT)
        ' **************************************************************************

                OPEN FileName$ FOR INPUT SHARED AS #1

                 LINE INPUT #1, No$
                 LINE INPUT #1, FullName$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, Baud$: Baud$ = Baud$ + " Baud"
                 LINE INPUT #1, Com$
                 LINE INPUT #1, TimeRemaining$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, AnsiFlag$
                   IF AnsiFlag$ = "TRUE" THEN AnsiFlag$ = "1" ELSE AnsiFlag$ = ""
                 LINE INPUT #1, No$

                CLOSE #1: Ok = 1

        CASE IS = 6
        ' **************************************************************************
        ' WWIV BBS SYSTEM   (CHAIN.TXT)
        ' **************************************************************************

                OPEN FileName$ FOR INPUT SHARED AS #1

                 LINE INPUT #1, No$
                 LINE INPUT #1, Alias$
                 LINE INPUT #1, FullName$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, Security$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, AnsiFlag$
                 LINE INPUT #1, Remote$          ' If Local then Remote$ = "1"
                 LINE INPUT #1, TimeRemaining$
                    TimeRemaining$ = STR$(VAL(TimeRemaining$) \ 60)
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, Baud$
                 LINE INPUT #1, Com$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
                 LINE INPUT #1, No$
               CLOSE #1: Ok = 1

        CASE IS = 7
        ' **************************************************************************
        ' PcBoard V14   (PCBOARD.SYS)
        ' **************************************************************************

                OPEN FileName$ FOR INPUT SHARED AS #1

                Lin$ = INPUT$(127, #1)
                AnsiFlag$ = MID$(Lin$, 12, 1)
                IF AnsiFlag$ = "Y" THEN AnsiFlag$ = "1" ELSE AnsiFlag$ = ""
                Baud$ = RTRIM$(MID$(Lin$, 19, 5))
                FullName$ = RTRIM$(MID$(Lin$, 85, 25))
                TimeRemaining$ = Num2Str$(ASC(MID$(Lin$, 110, 2)))
                Com$ = MID$(Lin$, 126, 1)

                CLOSE #1: Ok = 1

        CASE IS = 8
        ' **************************************************************************
        ' FrontDoor (DOBBS.BAT)
        '
        ' FrontDoor is is not a BBS software, it is a mailer
        ' You could use this file to load a door before the BBS actually start
        ' **************************************************************************

                OPEN FileName$ FOR INPUT SHARED AS #1

                DIM Item$(3)
                LINE INPUT #1, Lin$
                NbItem = 3
                Parser Lin$, Item$(), NbItem, " "
                Baud$ = Item$(2)
                Com$ = Item$(3)
                FullName$ = "Unknown"
                Location$ = ""
                AnsiFlag$ = "1"
                TimeRemaining$ = "180"
                Security$ = "32768"
                CLOSE #1: Ok = 1

        END SELECT

        IF BBSType = 0 OR Ok = 0 THEN
           CLS
           PRINT
           PRINT "ERROR: "; FileName$; " not found or BBS type not recognized."
           END
        END IF

END IF


