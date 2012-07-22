' Easy-Door V2.63 Configurable Parameters
' ---------------------------------------
'
' See EasyDoor.DOC for more information
'
DIM Para$(1 TO 37), NPara(1 TO 20)

lf$ = CHR$(13) + CHR$(10)
FullName$ = Cap$(FullName$)
Para$(1) = AnsiReset$ + CHR$(12) + lf$ + lf$ + Bright$ + "Sysop Chat Mode Entered..."
Para$(2) = "þ ESC to End Chat Mode" + lf$
Para$(3) = lf$ + "Hello " + FullName$ + ", this is the Sysop." + lf$
Para$(4) = Cyan$
Para$(5) = Magenta$
Para$(6) = Green$ + lf$ + lf$ + "Sysop Chat Mode Ended." + lf$
Para$(7) = Red$ + lf$ + lf$ + "**** Warning - User inactivity timeout in 30 seconds."
Para$(8) = Red$ + lf$ + "**** User inactivity timeout, Hanging Up..." + AnsiReset$
Para$(9) = "ERROR: "
Para$(10) = ""
Para$(11) = ""
Para$(12) = "aefefP" ' Pause key
Para$(13) = "asefsdS" ' Stop key
Para$(14) = " Hanging Up..."
Para$(15) = "No Carrier, Communication Lost."
Para$(16) = lf$ + lf$ + "Data file not found." + lf$
Para$(17) = "  Returning to BBS..."
Para$(18) = "Exceeded  "
Para$(19) = Red$ + lf$ + lf$ + "**** Time Limit Exceeded. Call Back Tomorrow ****" + lf$ + lf$
Para$(20) = Bright$ + Green$ + "More " + Yellow$ + "Y" + Green$ + "/" + Yellow$ + "n" + Green$ + "? "
Para$(21) = "Y" ' key for more
Para$(22) = "N"  'key for more
Para$(23) = AnsiReset$ + STRING$(12, 8)
Para$(24) = " Realm of Oblivion v1.0, (c) 1995, Jim Slattery                                  "
Para$(25) = " Paused   "  ' When PauseClock
Para$(26) = lf$ + Red$ + "The Sysop has shelled to DOS..."
Para$(27) = AnsiReset$ + "Sysop DOS Shell Function:" + lf$ + lf$ + "Type EXIT to return to door"
Para$(28) = Bright$ + Green$ + lf$ + "The Sysop has Returned from DOS, Thanks for Waiting!"
Para$(29) = Red$ + lf$ + "**** Warning: Less than 2 minutes remaining this call." + lf$
Para$(30) = FullName$
Para$(31) = Location$
Para$(32) = BAUD$
Para$(33) = Com$              ' COMx
Para$(34) = AnsiFlag$         ' ANSI
Para$(35) = TimeRemaining$    ' Time left by User when entering Door
Para$(36) = "Local Mode"      ' Message when in Local Mode
Para$(37) = " min. "          ' Message after time display

NPara(1) = 55   ' Delay to lower DTR when Hanging UP (18th/sec)
NPara(2) = 15   ' Pause delay when 'P' hit (sec)
NPara(3) = 120  ' User Inactivity Timeout in sec.
NPara(4) = 18   ' Delay after a No Carrier (18th/sec)
NPara(5) = 72   ' Delay when DATA FILE NOT FOUND (18th/sec)
NPara(6) = 23   ' Nb of line wanted on screen (leave space for status bar)
NPara(7) = 1    ' Carrier Detect On/Off
FG = 11: BG = 1 ' Foreground and Background Color for status bar
NPara(8) = FG + 16 * BG   ' Status Bar Color (combined color number)
NPara(9) = 1    ' Enable Time Counter
NPara(10) = 0   ' Used internally by Time Counter
NPara(11) = 5   ' Row where to put cursor when shelling to DOS
NPara(12) = 1   ' Enable ALT-X or ALT-R to EXIT DOOR
NPara(13) = 120 ' Enable warning before daily timeout ( >0 = ON) (sec)
NPara(14) = 1   ' Enable keys to change time
NPara(15) = 0   ' Used internally by Inactivity checker
NPara(16) = 0   ' Turn off ALT-C, 0=Not Turned OFF, 1=Turned OFF
NPara(17) = 1   ' Enable Status Bar
NPara(18) = 42  ' Column where # of BAUD/LOCALLY is printed on status bar
NPara(19) = 1   ' Enable Avatar/0+ emulation
IF NovellDetect% = 1 THEN
   NPara(20) = 0   ' Disable multitasker awarness under a Novell network
ELSE
   NPara(20) = 1   ' Otherwise, enable multitasker awarness
END IF


' Add graphic mode info to status bar

SELECT CASE Para$(34)
    CASE IS = "0": Graph$ = "(ASCII)"
    CASE IS = "1": Graph$ = " (ANSI)"
    CASE IS >= "2": Graph$ = "  (AVT)"
END SELECT
MID$(Para$(24), 66) = Graph$

' Add multi-tasker info to status bar

SELECT CASE TaskerDetect%
   CASE IS = 1: Tasker$ = " (WIN)"
   CASE IS = 2: Tasker$ = "  (DV)"
   CASE IS = 3: Tasker$ = "(DDOS)"
   CASE IS = 4: Tasker$ = " (PCM)"
   CASE IS = 5: Tasker$ = "(OS/2)"
   CASE ELSE: Tasker$ = " (DOS)"
END SELECT
MID$(Para$(24), 74) = Tasker$

