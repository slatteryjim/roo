DEFINT A-Z
DECLARE SUB Fadin (stri AS STRING, col1$, col2$, col3$)
DECLARE SUB Cobbler ()
DECLARE SUB Stable ()
DECLARE SUB MMenu (head$, comm$)
DECLARE SUB Fade (Text$)
DECLARE SUB Instructions ()
DECLARE SUB CheckStats ()
DECLARE SUB SaveStats ()
DECLARE SUB SaveOPStats ()
DECLARE SUB Rankings ()
DECLARE SUB Colorize (Text$)
DECLARE SUB Stats ()
DECLARE SUB SearchForName (nayme$)
DECLARE SUB Warp ()
DECLARE SUB Cotage ()
DECLARE SUB Dailies ()
DECLARE SUB FightPlayer ()
DECLARE SUB Yell ()
DECLARE SUB DailyM ()
DECLARE SUB News ()
DECLARE SUB Hunt ()
DECLARE SUB Healer ()

DECLARE SUB WriteMail ()
DECLARE SUB ReadMapFile ()
DECLARE SUB IntroScreen ()
DECLARE SUB Locatun ()
DECLARE SUB Command ()
DECLARE SUB Endscreen ()
DECLARE SUB Prnmap ()
DECLARE SUB Detrplace ()
DECLARE SUB Pauze ()
DECLARE SUB Menu ()
DECLARE SUB HitAmt (ap AS SINGLE, exper AS LONG, odp AS SINGLE, oexper AS LONG)
DECLARE SUB NameSearch ()
DECLARE SUB Quit ()
DECLARE SUB Date ()
DECLARE SUB Reroll (BF AS SINGLE)
DECLARE SUB SearchForMail ()
DECLARE SUB ReadMailFile ()
DECLARE SUB ReadEnemyFile ()

'SUBs for places to stop at
'
DECLARE SUB Tavern ()
DECLARE SUB Weapon ()
DECLARE SUB Armor ()
DECLARE SUB Bank ()
DECLARE SUB Castle ()
DECLARE SUB Cave ()
DECLARE SUB Stophere ()
DECLARE SUB Forest ()


DIM SHARED cord(19, 23) AS SINGLE, place(25)  AS STRING * 10, colo(25) AS INTEGER
COMMON SHARED cord() AS SINGLE, place() AS STRING * 10, recip$, from$, Message$, heading$, name$, hit%, odate$, yelln, fl AS SINGLE
'Player's variables
COMMON SHARED onm$, ornm$, oxp  AS LONG, oastr AS SINGLE, odstr AS SINGLE, omaxhp AS SINGLE, ohp AS SINGLE, ocharm AS SINGLE, omhand AS LONG, ombank AS LONG, ow$, owlev AS SINGLE, oa$, oalev AS SINGLE, olevel AS SINGLE, oolddate$, ofights AS SINGLE _
, opfights AS SINGLE, oded AS SINGLE, orow AS SINGLE, ocol AS SINGLE, owarpc, omoves
COMMON SHARED nob AS SINGLE
DIM SHARED onam(200) AS STRING * 15
DIM SHARED o.xp(200) AS LONG
DIM SHARED o.level(200) AS SINGLE
DIM SHARED o.ded(200) AS SINGLE
COMMON SHARED i AS SINGLE, nplayers AS SINGLE, hitpt AS STRING * 15, hits AS STRING * 70, redsome AS SINGLE
COMMON SHARED onam() AS STRING * 15
COMMON SHARED o.xp() AS LONG
COMMON SHARED o.level() AS SINGLE
COMMON SHARED o.ded() AS SINGLE
COMMON SHARED nm$, rnm$, xp AS LONG, astr AS SINGLE, dstr AS SINGLE, maxhp AS SINGLE, hp AS SINGLE, charm AS SINGLE, mhand AS LONG, mbank AS LONG, w$, wlev AS SINGLE, A$, alev AS SINGLE, level AS SINGLE, olddate$, fights AS SINGLE, pfights AS SINGLE _
, ded AS SINGLE, row AS SINGLE, coll AS SINGLE, warpc AS SINGLE, moves AS SINGLE

'Enemies variables
DIM SHARED enm$(10, 12), eas(10, 12) AS SINGLE, edp(10, 12) AS SINGLE, e.xp(10, 12) AS LONG, ehp(10, 12) AS SINGLE, gxp(10, 12) AS LONG, gm(10, 12) AS LONG
COMMON SHARED enm$(), eas() AS SINGLE, edp() AS SINGLE, e.xp() AS LONG, e.xp AS LONG, ehp() AS SINGLE, gxp() AS LONG, gm() AS LONG
COMMON SHARED s, ymhand AS LONG, ymbank AS LONG, yexp AS LONG, move AS STRING * 4
COMMON SHARED cntr AS SINGLE
COMMON SHARED FullName$


' $INCLUDE: 'EasyDoor.BI'
' $INCLUDE: 'AutoBBS.BI'
' $INCLUDE: 'EasyPara.BI'

Init Para$(), NPara(), 1, 2, 0  ' Beginners: use those default parameters
LOCATE , , 1                    ' Make the cursor visible
SendCLS                         ' Clear the screen

ChangePara 24, " Realm of Oblivion v1.0, Jim Slattery (c) 1995                                  "
StatusBar 1
'Create a random number sequence
RANDOMIZE TIMER

CONST TRUE = 1
CONST FALSE = 0
redsome = FALSE
fl = 1

SendCLS
SmartColor 7, 0
Send "ENTERING THE REALM."

'ReadMapFile into memory
ReadMapFile
Send "."

'Read Enemies stats into memory
ReadEnemyFile

'Print IntroScreen
IntroScreen

'Test for color graphics:
IF AnsiFlag$ = "" THEN
        SendCLS
        Linefeed 10
        SendCR Center$("You MUST have color graphics to play this game!")
        SendCR Center$("Sorry!")
        Pauze
        ReturnBBS
END IF
'Search for name
NameSearch

'Search for mail
SearchForMail

'View Stats
Stats

'View User ranking's list
Rankings

'Print daily news
News
SendCLS

IF ded = TRUE THEN
        Linefeed 10
        Fadin "You've already died today........", "`4", "`@", "`%"
        Linefeed 2
        Fadin "You can't continue your quest until tomorrow.....", "`4", "`@", "`%"
        Linefeed 1
        Pauze
        Quit
END IF

'Start game
'
SendCLS
SendFile "menu.ans", 1
DO
        Prnmap
        Locatun
        Command

LOOP      '*** CONTINUOUS LOOP **

DEFSNG A-Z
SUB Castle
SmartColor 15, 0
SendCR "Whoaaaa!!! This is the big, bad castle!!"

END SUB

SUB Cave
SmartColor 6, 0
SendCR "Good, you found a cave!"

END SUB

DEFINT A-Z
SUB Cobbler
SendCR "Shoe Cobbler"
END SUB

DEFSNG A-Z
SUB Command
        AnsiLocate 23, 1
        SmartColor 0, 0
        way$ = ModemInputChar$
        way$ = UCASE$(way$)
        IF way$ = "Q" THEN Quit: SendCLS: SendFile "menu.ans", 1
        IF way$ = "S" THEN Stophere: SendCLS: SendFile "menu.ans", 1
        IF way$ = "V" THEN Stats: SendCLS: SendFile "menu.ans", 1
        IF way$ = "E" THEN WriteMail: SendCLS: SendFile "menu.ans", 1
        IF way$ = "D" THEN News: SendCLS: SendFile "menu.ans", 1
        IF way$ = "U" THEN Rankings: SendCLS: SendFile "menu.ans", 1
        IF way$ = "Y" THEN Yell: SendCLS: SendFile "menu.ans", 1
        IF way$ = "F" THEN FightPlayer: SendCLS: SendFile "menu.ans", 1
        IF way$ = "H" THEN Healer: SendCLS: SendFile "menu.ans", 1
        IF way$ = "R" THEN SearchForMail: SendCLS: SendFile "menu.ans", 1
        IF way$ = "W" THEN Warp: SendCLS: SendFile "menu.ans", 1
        IF way$ = "T" THEN Instructions: SendCLS: SendFile "menu.ans", 1
        IF way$ = "?" THEN SendFile "commands.ans", 1: wait$ = ModemInputChar$:  SendFile "menu.ans", 1
        way = VAL(way$)

' *** HORIZONTAL AND VERTICAL ***
'
IF moves > 0 THEN
        m = moves
        IF way = 8 AND cord(row - 1, coll) > 5 AND (level + 80) > cord(row - 1, coll) THEN row = row - 1: m = m - 1
        IF way = 4 AND cord(row, coll - 1) > 5 AND (level + 80) > cord(row, coll - 1) THEN coll = coll - 1: m = m - 1
        IF way = 2 AND cord(row + 1, coll) > 5 AND (level + 80) > cord(row + 1, coll) THEN row = row + 1: m = m - 1
        IF way = 6 AND cord(row, coll + 1) > 5 AND (level + 80) > cord(row, coll + 1) THEN coll = coll + 1: m = m - 1

        ' *** DIAGONALS ***
        '
        IF way = 7 AND cord(row - 1, coll - 1) > 5 AND (level + 80) > cord(row - 1, coll - 1) THEN row = row - 1: coll = coll - 1: m = m - 1
        IF way = 9 AND cord(row - 1, coll + 1) > 5 AND (level + 80) > cord(row - 1, coll - 1) THEN row = row - 1: coll = coll + 1: m = m - 1
        IF way = 1 AND cord(row + 1, coll - 1) > 5 AND (level + 80) > cord(row + 1, coll - 1) THEN row = row + 1: coll = coll - 1: m = m - 1
        IF way = 3 AND cord(row + 1, coll + 1) > 5 AND (level + 80) > cord(row + 1, coll + 1) THEN row = row + 1: coll = coll + 1: m = m - 1
        moves = m
        CheckStats
        IF redsome = TRUE THEN SendFile "menu.ans", 1: redsome = FALSE
END IF
END SUB

SUB Cotage
SendCLS
SmartColor 7, 0
SendCR "An old fortune teller lives here..."

END SUB

SUB Detrplace

FOR A = 1 TO 25
'1st row
IF A = 1 THEN c = cord(row - 2, coll - 2)
IF A = 2 THEN c = cord(row - 2, coll - 1)
IF A = 3 THEN c = cord(row - 2, coll)
IF A = 4 THEN c = cord(row - 2, coll + 1)
IF A = 5 THEN c = cord(row - 2, coll + 2)

'2nd row
IF A = 6 THEN c = cord(row - 1, coll - 2)
IF A = 7 THEN c = cord(row - 1, coll - 1)
IF A = 8 THEN c = cord(row - 1, coll)
IF A = 9 THEN c = cord(row - 1, coll + 1)
IF A = 10 THEN c = cord(row - 1, coll + 2)

'3rd row
IF A = 11 THEN c = cord(row, coll - 2)
IF A = 12 THEN c = cord(row, coll - 1)
IF A = 13 THEN c = cord(row, coll)
IF A = 14 THEN c = cord(row, coll + 1)
IF A = 15 THEN c = cord(row, coll + 2)

'4th row
IF A = 16 THEN c = cord(row + 1, coll - 2)
IF A = 17 THEN c = cord(row + 1, coll - 1)
IF A = 18 THEN c = cord(row + 1, coll)
IF A = 19 THEN c = cord(row + 1, coll + 1)
IF A = 20 THEN c = cord(row + 1, coll + 2)

'5th row
IF A = 21 THEN c = cord(row + 2, coll - 2)
IF A = 22 THEN c = cord(row + 2, coll - 1)
IF A = 23 THEN c = cord(row + 2, coll)
IF A = 24 THEN c = cord(row + 2, coll + 1)
IF A = 25 THEN c = cord(row + 2, coll + 2)

GOTO U
lake:
        colo(A) = 1
        place(A) = "Lake      "
        GOTO det
river:
        colo(A) = 9
        place(A) = "River     "
        GOTO det
wall:
        colo(A) = 8
        place(A) = "CstlWall  "
        GOTO det
fence:
        colo(A) = 12
        place(A) = "Fence     "
        GOTO det
thorns:
        colo(A) = 4
        place(A) = "Thorns    "
        GOTO det
path:
        colo(A) = 11
        place(A) = "Path      "
        GOTO det
grass:
        colo(A) = 10
        place(A) = "Grass     "
        GOTO det
gate:
        colo(A) = 12
        place(A) = "Lev" + STR$(c - 79) + " Gate"
        GOTO det
dirt:
        colo(A) = 3
        place(A) = "Dirt      "
        GOTO det
bridge:
        colo(A) = 12
        place(A) = "Bridge    "
        GOTO det
Forest:
        colo(A) = 2
        place(A) = "Forest    "
        GOTO det
Tavern:
        colo(A) = 14
        place(A) = "Tavern    "
        GOTO det
cob:
        colo(A) = 14
        place(A) = "Cobbler   "
        GOTO det
weapons:
        colo(A) = 14
        place(A) = "Lucas'Wpns"
        GOTO det
Armor:
        colo(A) = 14
        place(A) = "ArmorShop "
        GOTO det
Castle:
        colo(A) = 7
        place(A) = "CASTLE    "
        GOTO det
Cave:
        colo(A) = 8
        place(A) = "Cave      "
        GOTO det
Bank:
        colo(A) = 5
        place(A) = "Bank      "
        GOTO det
fountain:
        colo(A) = 13
        place(A) = "MagicFntn "
        GOTO det
MShop:
        colo(A) = 13
        place(A) = "MagicShop "
        GOTO det
Hill:
        colo(A) = 12
        place(A) = "Hill      "
        GOTO det
Cottage:
        colo(A) = 6
        place(A) = "Cottage   "
        GOTO det
PetShop:
        colo(A) = 6
        place(A) = "Stable    "
        GOTO det

GOTO det
U:
        IF c = 1 THEN GOTO lake
        IF c = 2 THEN GOTO river
        IF c = 3 THEN GOTO wall
        IF c = 4 THEN GOTO fence
        IF c = 5 THEN GOTO thorns
        IF c = 6 THEN GOTO path
        IF c = 7 THEN GOTO grass
        IF c = 8 THEN GOTO dirt
        IF c = 9 THEN GOTO thorns
        IF c = 10 THEN GOTO bridge
        IF c = 11 THEN GOTO Forest
        IF c = 12 THEN GOTO Tavern
        IF c = 13 THEN GOTO cob
        IF c = 14 THEN GOTO weapons
        IF c = 15 THEN GOTO Armor
        IF c = 17 THEN GOTO Cave
        IF c = 18 THEN GOTO Bank
        IF c = 19 THEN GOTO fountain
        IF c = 20 THEN GOTO MShop
        IF c = 21 THEN GOTO Hill
        IF c = 22 THEN GOTO Cottage
        IF c = 23 THEN GOTO PetShop

        IF c > 59 AND c < 71 THEN GOTO Castle
       
        IF c > 79 AND c < 91 THEN GOTO gate
      

det:

NEXT A

END SUB

SUB Endscreen
SendCLS
AnsiLocate 12, 1
SmartColor 15, 0
SendCR Center$("-[                        ]-")
SmartColor 8, 0
AnsiLocate 12, 1
SendCR Center$("Farewell Adventurer...")
Linefeed 10
Pauze
END

END SUB

SUB FightPlayer
CheckStats
top:
SendCLS
SendFile "Fplayer.ans", 1
AnsiLocate 5, 0
IF pfights < 1 THEN
        SmartColor 8, 0
        Linefeed 2
        Send "You are too tired to fight..."
        Linefeed 2
        Pauze
        GOTO le
END IF
SendCR "Players at this location:"
Linefeed 1
s = 0
OPEN "players.dat" FOR INPUT AS #1
IF NOT EOF(1) THEN INPUT #1, odate$
DO WHILE NOT EOF(1)
        INPUT #1, onm$, ornm$, oxp, oastr, odstr, omaxhp, ohp, ocharm, omhand, ombank, ow$, owlev, oa$, oalev, olevel, oolddate$, ofights, opfights, oded, orow, ocol, warpc, moves

'Search for players at the same location
        IF orow = row THEN
                IF ocol = coll THEN
                        IF onm$ = nm$ THEN GOTO n
                        IF onm$ = "" THEN GOTO n
                        s = s + 1
                        IF s = 20 THEN Pauze
                        SmartColor 15, 0
                        SendCR SPACE$(5) + onm$
                END IF
        END IF
n:
LOOP
CLOSE
IF s = 0 THEN
        Colorize "`%NONE!"
        Linefeed 5
        Pauze
        IF (RND > .7) THEN
                Colorize "     `8You look around and see that yer all alone...": Linefeed 1
                Pauze
                Colorize "     `8It seems like a good time to practice your `@BALLET`8!!": Linefeed 2
                Pauze
                Colorize "`8YOU WHiRL AND TWiRL `@JOYOUSLY `8FOR HOURS...": Linefeed 1
                Pauze
                Linefeed 1
                Colorize "`1YOU GAiN `%1 `1EXPERiENCE!": Linefeed 1
        END IF
        GOTO le
END IF
Linefeed 1
Colorize "`1[`9F`1]ind Healer [`9H`1]unt [`9R`1]eturn`9.`1.`8.? "
q$ = ModemInputChar$
Linefeed 1
q$ = UCASE$(q$)
IF q$ = "F" THEN Healer: GOTO top
IF q$ = "H" THEN GOTO hu
IF q$ = "R" THEN GOTO le
GOTO top
hu:
SmartColor 7, 0
SendCR "Who would you like to hunt for (FULL OR PARTIAL NAME)? "
SmartColor 8, 0
ModemInput "> ", q$, 7, 0, 20
IF q$ = "" THEN Linefeed 1: SendCR "There's no such person!": Pauze: GOTO top
SearchForName q$
        IF nob = TRUE THEN Pauze: GOTO top
        IF q$ = nm$ THEN Linefeed 1: SendCR "You don't feel like committing suicide today": Pauze: GOTO top
IF orow <> row OR ocol <> coll THEN Linefeed 1: SendCR "That guy's not here!": Pauze: GOTO top
IF orow = row AND ocol = coll THEN
        IF oded = TRUE THEN Linefeed 1: SendCR "This guy's already dead!": Pauze: GOTO top
        SmartColor 8, 0
        Linefeed 1
        SendCR "You find " + onm$ + "!"
        Send "Are you sure you want to fight him?": SmartColor 7, 0: SendCR "(y/n)"
q$ = ModemInputChar$
q$ = UCASE$(q$)
IF q$ = "Y" THEN
enm$ = onm$
e.xp = oxp
ehp = omaxhp
eas = oastr
edp = odstr
gxp = INT(oxp / 2)
gm = INT(omhand)
SendFile "fight.ans", 1
si:
'Send Player's hitpoints
        SmartColor 8, 0
        AnsiLocate 5, 20
        hitpt = STR$(hp)
        Send hitpt

'Send Monster's hitpoints
        SmartColor 8, 0
        AnsiLocate 5, 56
        hitpt = STR$(ehp)
        Send hitpt

AnsiLocate 16, 0
q$ = ModemInputChar$
q$ = UCASE$(q$)
IF q$ = "F" THEN GOTO le
IF q$ = "S" OR q$ = CHR$(13) THEN GOTO strikes
GOTO strikes
GOTO si:

strikes:

'Determine amount of hitpoints deducted from enemy
HitAmt astr, xp, edp, e.xp
IF hit% < 1 THEN hit% = 0: hits = "`8You MISSED `%" + enm$ + " COMPLETELY!!"

'deduct hitpoints
ehp = ehp - hit%
hits = "`8You hit " + enm$ + " for `%" + Num2Str$(hit%)
SmartColor 7, 0
AnsiLocate 9, 11
Colorize hits


'Check to see if enemy is dead
IF ehp < 1 THEN GOTO hesdeadjims

'Determine amount of hitpoints deducted from player
HitAmt eas, e.xp, dstr, xp
IF hit% < 1 THEN hit% = 0: hits = "`%" + enm$ + "`8MISSED you COMPLETELY!!"
hits$ = enm$ + "`8 hits you for `%" + Num2Str$(hit%)
hp = hp - hit%
SmartColor 7, 0
AnsiLocate 10, 11
Colorize hits

'Check to see if player is dead
IF hp < 1 THEN GOTO imdeadjims


       
GOTO si

hesdeadjims:
       
        IF gxp < 1 THEN gxp = 1
        xp = (xp + gxp)
        mhand = INT(mhand + gm)
        omhand = 0
        oxp = INT(oxp * .9)
        oded = TRUE
        pfights = pfights - 1
        CheckStats
AnsiLocate 9, 11
Send SPACE$(70)
AnsiLocate 9, 11
Colorize "`7You've killed `%" + enm$ + "`7!!"
AnsiLocate 10, 11
Send SPACE$(70)
AnsiLocate 10, 11
Colorize "`7You find`% $" + LTRIM$(RTRIM$(STR$(gm))) + "`7 and you gain `%" + LTRIM$(RTRIM$(STR$(gxp))) + "`7 experience  "
AnsiLocate 17, 0
Pauze

'save other player's stats
'
SaveOPStats

'News entry
'
        n$ = "`@" + onm$
        T$ = " `4was killed by "
        na$ = "`@" + nm$
        'Write murder announcement
        OPEN "news.dat" FOR APPEND AS #1
                WRITE #1, n$, T$, na$
        CLOSE
        'Write mail to announce death to victim
'
spot:
heading$ = "`%You have been attacked!"
from$ = ""
recip$ = onm$
Message$ = "`@" + nm$ + "`4 has attacked you and KILLED you!"
OPEN "mail.dat" FOR APPEND AS #1
FOR i = 1 TO 50
        WRITE #1, recip$, from$, Message$, heading$
        NEXT
CLOSE


        GOTO top
imdeadjims:
        oxp = INT(oxp + (xp / 2))
        IF oxp < 1 THEN oxp = 1
        omhand = INT(omhand + mhand)
        xp = xp * .9
        mhand = 0
CheckStats
AnsiLocate 9, 11
Send SPACE$(70)
AnsiLocate 9, 11
Colorize "`4You've been killed by `@" + enm$ + "!!"
AnsiLocate 10, 11
Send SPACE$(70)
AnsiLocate 10, 11
Colorize "`4You may continue your adventures tomorrow..."
AnsiLocate 17, 0
Pauze

'Save other player's stats
SaveOPStats

        'News entry
        n$ = "`@" + nm$
        T$ = " `4was killed in self defense by "
        na$ = "`@" + enm$

        'printdeath announcement to daily news file
        OPEN "News.dat" FOR APPEND AS #1
                WRITE #1, n$, T$, na$
        CLOSE
'Write mail to person who killed in self defense
'
spots:
heading$ = "`%You have been attacked!"
from$ = ""
recip$ = onm$
Message$ = "`@" + nm$ + "`4 has attacked you and YOU killed HIM instead!"
OPEN "mail.dat" FOR APPEND AS #1
        WRITE #1, recip$, from$, Message$, heading$
CLOSE

        ded = TRUE
        Quit
        END IF
      
END IF
GOTO top
le:
Pauze
END SUB

SUB Forest

SendCLS

men:
Linefeed 1
SmartColor 7, 0
MMenu "Forest", "FHWR"
q$ = ModemInputChar$
Linefeed 1
q$ = UCASE$(q$)
IF q$ = "F" THEN Healer: GOTO men
IF q$ = "H" THEN Hunt: GOTO men
IF q$ = "R" THEN GOTO bak
IF q$ = "W" THEN GOTO wander
IF q$ = "V" THEN Stats
IF q$ = "?" THEN SendFile "forest.ans", 1
GOTO men
wander:
        Linefeed 2
        Fade "YOU CAN'T FiND ANiTHiNG!!": Linefeed 1
        fights = fights - 1
        Pauze
GOTO men

bak:
Linefeed 1
END SUB

SUB Healer
SendCLS

CheckStats
cost = INT(level * 1.5)

m:
Linefeed 1
SmartColor 8, 0
Send "Hitpoints:": SmartColor 15, 0: Send STR$(hp): SmartColor 7, 0: Send " /": SmartColor 15, 0: SendCR STR$(maxhp)
SmartColor 8, 0
Send "Money:": SmartColor 15, 0: SendCR " $" + STR$(mhand)
me:
MMenu "Healer", "HSR"
q$ = ModemInputChar$
Linefeed 1
q$ = UCASE$(q$)
IF q$ = "H" THEN GOTO full
IF q$ = "S" THEN GOTO cer
IF q$ = "R" THEN GOTO retu
IF q$ = "?" THEN SendFile "Heal.ans", 1: Linefeed 1: GOTO m
GOTO me:
full:
WHILE hp < maxhp AND mhand > cost - 1
        mhand = mhand - cost
        hp = hp + 1
        healed = healed + 1
WEND
Linefeed 1
Fade "THe HeALeR HeALS`%" + STR$(healed) + " `8HiTPOiNTS": Linefeed 1
GOTO retu

cer:
Linefeed 1
SmartColor 7, 0
Fade "HOW MANi HiTPOiNTS SHaLL i HeAL?": Linefeed 1
H = hp
mh = maxhp
m = mhand

WHILE H < mh + 1 AND m > cost - 1
        m = m - cost
        H = H + 1
        max = max + 1
WEND
max = max - 1
IF max < 1 THEN max = 0
SendCR "(MAX:" + STR$(max) + ")"
SmartColor 8, 0
ModemInput "# ", healed$, 7, 0, 4
healed = VAL(healed$)

IF healed > max THEN Fade "THAT MANi HiTPOiNTS WiLL DESTROY YOU!": Linefeed 1: GOTO retu
heal = 0
WHILE heal < healed
        mhand = mhand - cost
        hp = hp + 1
        heal = heal + 1
WEND
Linefeed 1
SmartColor 8, 0
Fade "THe HeALeR HeALS`%" + STR$(healed) + " `8HiTPOiNTS": Linefeed 1

GOTO retu

retu:
Linefeed 1
Pauze
END SUB

SUB Hunt
CheckStats
'Check to see if player has enough fights left
IF fights < 1 THEN SmartColor 8, 0: Linefeed 2: SendCR "You are too tired to fight...": Linefeed 1: Pauze: GOTO ret
l = level
en% = INT(RND(1) * 12) + 1
en = en%
enm$ = enm$(l, en)
e.xp = e.xp(l, en)
ehp = ehp(l, en)
eas = eas(l, en)
edp = edp(l, en)
gxp = gxp(l, en)
gm = gm(l, en)
fights = fights - 1
SendFile "fight.ans", 1
AnsiLocate 9, 11
SmartColor 15, 0
Send "You have encountered: " + enm$
s:

'Send Player's hitpoints
        SmartColor 8, 0
        AnsiLocate 5, 13
        hitpt = STR$(hp)
        Send hitpt

'Send Monster's hitpoints
        SmartColor 8, 0
        AnsiLocate 5, 53
        hitpt = STR$(ehp)
        Send hitpt

AnsiLocate 16, 0
q$ = ModemInputChar$
q$ = UCASE$(q$)
IF q$ = "F" THEN GOTO ret
IF q$ = "S" OR q$ = CHR$(13) THEN GOTO strike
GOTO s:

strike:

'Determine amount of hitpoints deducted from enemy
HitAmt astr, xp, edp, e.xp
IF hit% < 1 THEN hit% = 0: hits = "`8You MiSSED `%" + enm$ + "`8 COMPLETELY!!"

'deduct hitpoints
ehp = ehp - hit%
hits = "`8You hit`7 " + enm$ + "`8 for `%" + Num2Str$(hit%)
SmartColor 7, 0
AnsiLocate 9, 11
Colorize hits


'Check to see if enemy is dead
IF ehp < 1 THEN GOTO hesdeadjim

gethit:
'Determine amount of hitpoints deducted from player
HitAmt eas, e.xp, dstr, xp
IF hit% < 1 THEN hit% = 0: hits = "`%" + enm$ + "`8MISSED you COMPLETELY!!"
hits$ = "`7" + enm$ + "`8 hits you for `%" + Num2Str$(hit%)
hp = hp - hit%
SmartColor 7, 0
AnsiLocate 10, 11
Colorize hits

'Check to see if player is dead
IF hp < 1 THEN GOTO imdeadjim
GOTO s

hesdeadjim:
xp = xp + gxp
mhand = mhand + gm
CheckStats
AnsiLocate 9, 11
Send SPACE$(70)
AnsiLocate 9, 11
Colorize "`7You've killed`% " + enm$ + "`7!!"
AnsiLocate 10, 11
Send SPACE$(70)
AnsiLocate 10, 11
Colorize "`7You find `%$" + LTRIM$(RTRIM$(STR$(gm))) + "`7 and you gain`% " + LTRIM$(RTRIM$(STR$(gxp))) + "`7 experience  "
AnsiLocate 17, 0
Pauze
GOTO ret

imdeadjim:
xp = xp - (xp / 10)
mhand = 0
CheckStats
AnsiLocate 9, 11
Send SPACE$(70)
AnsiLocate 9, 11
Colorize "`4You've been killed by`@ " + enm$ + "`4!!"
AnsiLocate 10, 11
Send SPACE$(70)
AnsiLocate 10, 11
Colorize "`4You may continue your adventures tomorrow..."
AnsiLocate 17, 0
Pauze
'News entry
n$ = "`@" + nm$
T$ = " `4was killed by "
na$ = "`@" + enm$

'Write death announcement to daily news file
OPEN "News.dat" FOR APPEND AS #1
        WRITE #1, n$, T$, na$
CLOSE
ded = TRUE
Quit
ret:
CheckStats
END SUB

SUB IntroScreen
Num% = INT(RND * 6) + 1
filenm$ = "open" + Num2Str$(Num%) + ".ans"
SendFile filenm$, 1
AnsiLocate 24, 0
Pauze
END SUB

SUB Locatun
        AnsiLocate 20, 17
        SmartColor 15, 0: Send STR$(row): SmartColor 1, 0: Send " BY": SmartColor 15, 0: Send STR$(coll) + "  "
        AnsiLocate 20, 56
        move = RTRIM$(LTRIM$(STR$(moves)))
        SmartColor 15, 0: Send move
END SUB

SUB NameSearch
'NameSearch:
'search for name and stats
SendCLS

ded = FALSE
SendCLS
inptname:
        IF FullName$ = "" THEN GOTO getnm
        IF FullName$ <> "Unknown" THEN
                name$ = FullName$
                GOTO F:
        END IF
s = 0
getnm:
        IF s = 5 THEN ReturnBBS
        AnsiLocate 7, 1
        Text$ = "SiNE iN!!"
        Fade Text$
        Linefeed 1
        SmartColor 8, 0
        ModemInput "> ", name$, 7, 0, 20
        IF name$ = "" THEN s = s + 1: GOTO inptname
name$ = UCASE$(name$)
ChangePara 30, Cap$(name$)
StatusBar 1
F:
s = 0
OPEN "players.dat" FOR INPUT AS #1
IF NOT EOF(1) THEN INPUT #1, odate$
DO WHILE NOT EOF(1)
        INPUT #1, nm$, rnm$, xp, astr, dstr, maxhp, hp, charm, mhand, mbank, w$, wlev, A$, alev, level, olddate$, fights, pfights, ded, row, coll, warpc, moves
        IF UCASE$(rnm$) = UCASE$(name$) THEN GOTO found
LOOP
CLOSE
GOTO new:

found:
CLOSE
Date
hp = maxhp
SmartColor 9, 0
Linefeed 1
Fadin "SALUTATiONS, " + UCASE$(nm$) + "!", "`4", "`@", "`%": Linefeed 1
Pauze

GOTO finished

new:
locatedblank:
CLOSE
SmartColor 7, 0
Fade "HeY YeR NeW 'eRe!"
Linefeed 1
Fade "WOOd U LUV 2 JOiN THiS KeWL GAMe?": SmartColor 7, 0: SendCR " (Y/n)"
q$ = ModemInputChar$
q$ = UCASE$(q$)
IF q$ = "N" THEN
        Linefeed 1
        Fade "TOO BAD! YeR PLAYiNG AND THAT'S THAT!"
        Linefeed 1
        Pauze
END IF
rnm$ = UCASE$(name$)
SendCLS
Instructions
SendCLS
Reroll (FALSE)
'write new player announcement
        n$ = "`% ** " + nm$
        T$ = ""
        na$ = " `7registered as a `%NEW PLAYER`7! `%** "
        'Write murder announcement
        OPEN "news.dat" FOR APPEND AS #1
                WRITE #1, n$, T$, na$
        CLOSE

SaveStats

GOTO found

finished:
CheckStats
END SUB

SUB News
'Just in case the file hasn't been created yet
OPEN "news.dat" FOR APPEND AS #1
CLOSE

SendCLS
SendFile "news.ans", 1

OPEN "News.dat" FOR INPUT AS #1
l = 1
AnsiLocate 5, 0
WHILE NOT EOF(1)
        IF l = 11 THEN l = 1: Pauze
        Linefeed 1
        INPUT #1, n$, T$, na$
        SmartColor 15, 0
        te$ = "`1úúÄÄ`9ÄÄ`%´ `%" + n$ + "`9" + T$ + "`1" + na$ + " `%Ã`9ÄÄ`1ÄÄúú"
        begin = 40 - (LEN(te$) \ 2)
        FOR g = 1 TO LEN(te$)
                IF MID$(te$, g, 1) = "`" THEN begin = begin + 1
        NEXT g
        begin = begin - 2
        Send SPACE$(begin)
        Colorize te$
        Linefeed 1
        l = l + 1
WEND
Pauze
CLOSE

END SUB

SUB Prnmap
Detrplace

        AnsiLocate 4, 12
        SmartColor colo(1), 0
        Send place(1)
       
        AnsiLocate 4, 25
        SmartColor colo(2), 0
        Send place(2)
       
        AnsiLocate 4, 36
        SmartColor colo(3), 0
        Send place(3)
       
        AnsiLocate 4, 47
        SmartColor colo(4), 0
        Send place(4)
      
        AnsiLocate 4, 60
        SmartColor colo(5), 0
        Send place(5)
       
'Second Row ***
        AnsiLocate 7, 12
        SmartColor colo(6), 0
        Send place(6)
       
        AnsiLocate 7, 25
        SmartColor colo(7), 0
        Send place(7)
        

        AnsiLocate 7, 36
        SmartColor colo(8), 0
        Send place(8)
        

        AnsiLocate 7, 47
        SmartColor colo(9), 0
        Send place(9)
       
        AnsiLocate 7, 60
        SmartColor colo(10), 0
        Send place(10)

'Third Row ***
        AnsiLocate 10, 12
        SmartColor colo(11), 0
        Send place(11)
       

        AnsiLocate 10, 25
        SmartColor colo(12), 0
        Send place(12)
       

        AnsiLocate 10, 36
        SmartColor colo(13), 0
        Send place(13)
       
        AnsiLocate 10, 47
        SmartColor colo(14), 0
        Send place(14)
       
        AnsiLocate 10, 60
        SmartColor colo(15), 0
        Send place(15)
     
'Fourth Row***
        AnsiLocate 13, 12
        SmartColor colo(16), 0
        Send place(16)
       
        AnsiLocate 13, 25
        SmartColor colo(17), 0
        Send place(17)
       
        AnsiLocate 13, 36
        SmartColor colo(18), 0
        Send place(18)
      
        AnsiLocate 13, 47
        SmartColor colo(19), 0
        Send place(19)
      
        AnsiLocate 13, 60
        SmartColor colo(20), 0
        Send place(20)
     
'Fifth Row***
        AnsiLocate 16, 12
        SmartColor colo(21), 0
        Send place(21)
     
        AnsiLocate 16, 25
        SmartColor colo(22), 0
        Send place(22)
     
        AnsiLocate 16, 36
        SmartColor colo(23), 0
        Send place(23)
    
        AnsiLocate 16, 47
        SmartColor colo(24), 0
        Send place(24)
    
        AnsiLocate 16, 60
        SmartColor colo(25), 0
        Send place(25)
    
        

END SUB

SUB ReadEnemyFile
'REadEnemyFile
'  Read all of the enemies stats into memory
OPEN "enemies.dat" FOR APPEND AS #1
CLOSE

'Reading file
OPEN "enemies.dat" FOR INPUT AS #1
FOR c = 1 TO 12
        INPUT #1, enm$(1, c), eas(1, c), edp(1, c), e.xp(1, c), ehp(1, c), gxp(1, c), gm(1, c)
NEXT
CLOSE


END SUB

SUB ReadMapFile
'ReadMapFile:
'Input Coordinates From Map.

' *** READ MAP FILE ***
'
OPEN "map.dat" FOR INPUT AS #1
FOR row = 1 TO 19
        IF row = 20 \ 2 THEN Send "."
        FOR coll = 1 TO 23
                IF NOT EOF(1) THEN
                        INPUT #1, cord(row, coll)
                END IF
        NEXT coll
NEXT row
CLOSE #1


END SUB

DEFINT A-Z
SUB SaveOPStats
'Save Player's stats and OPponent's stats
olddate$ = DATE$
hp = maxhp
odate$ = DATE$

CheckStats

ynm$ = nm$
yrnm$ = rnm$
yxp = xp
yastr = astr
ydstr = dstr
ymaxhp = maxhp
yhp = hp
ycharm = charm
ymhand = mhand
ymbank = mbank
yw$ = w$
ya$ = A$
ylevel = level
yolddate$ = olddate$
yfights = fights
ypfights = pfights
yded = ded
yrow = row
ycoll = coll
ymoves = moves
ywarpc = warpc

CLOSE
nam$ = nm$
OPEN "players.dat" FOR INPUT AS #1
IF NOT EOF(1) THEN INPUT #1, odate$
OPEN "Players1.dat" FOR OUTPUT AS #2
WRITE #2, odate$
WRITE #2, onm$, ornm$, oxp, oastr, odstr, omaxhp, ohp, ocharm, omhand, ombank, ow$, owlev, oa$, oalev, olevel, oolddate$, ofights, opfights, oded, orow, ocol, warpc, moves
WRITE #2, nm$, rnm$, xp, astr, dstr, maxhp, hp, charm, mhand, mbank, w$, wlev, A$, alev, level, olddate$, fights, pfights, ded, row, coll, warpc, moves
DO WHILE NOT EOF(1)
        INPUT #1, nm$, rnm$, xp, astr, dstr, maxhp, hp, charm, mhand, mbank, w$, wlev, A$, alev, level, olddate$, fights, pfights, ded, row, coll, warpc, moves
        IF nm$ = nam$ THEN GOTO bissv
        IF nm$ = onm$ THEN GOTO bissv
        IF nm$ = "" THEN GOTO bissv
        WRITE #2, nm$, rnm$, xp, astr, dstr, maxhp, hp, charm, mhand, mbank, w$, wlev, A$, alev, level, olddate$, fights, pfights, ded, row, coll, warpc, moves

bissv:
LOOP
CLOSE
KILL "players.dat"
NAME "players1.dat" AS "players.dat"
nm$ = ynm$
rnm$ = yrnm$
xp = yxp
astr = yastr
dstr = ydstr
maxhp = ymaxhp
hp = yhp
charm = ycharm
mhand = ymhand
mbank = ymbank
w$ = yw$
wlev = ywlev
A$ = ya$
alev = yalev
level = ylevel
olddate$ = yolddate$
fights = yfights
pfights = ypfights
ded = yded
row = yrow
coll = ycoll
moves = ymoves
warpc = ywarpc

END SUB

SUB SaveStats
olddate$ = DATE$
hp = maxhp
odate$ = DATE$

CheckStats
SHARED yxp AS LONG, ymbank AS LONG, ymhand AS LONG

ynm$ = nm$
yrnm$ = rnm$
yxp = xp
yastr = astr
ydstr = dstr
ymaxhp = maxhp
yhp = hp
ycharm = charm
ymhand = mhand
ymbank = mbank
yw$ = w$
ya$ = A$
ylevel = level
yolddate$ = olddate$
yfights = fights
ypfights = pfights
yded = ded
yrow = row
ycoll = coll


CLOSE
nam$ = nm$
OPEN "players.dat" FOR INPUT AS #1
IF NOT EOF(1) THEN INPUT #1, odate$
OPEN "Players1.dat" FOR OUTPUT AS #2
WRITE #2, odate$
WRITE #2, nm$, rnm$, xp, astr, dstr, maxhp, hp, charm, mhand, mbank, w$, wlev, A$, alev, level, olddate$, fights, pfights, ded, row, coll, warpc, moves
DO WHILE NOT EOF(1)
        INPUT #1, nm$, rnm$, xp, astr, dstr, maxhp, hp, charm, mhand, mbank, w$, wlev, A$, alev, level, olddate$, fights, pfights, ded, row, coll, warpc, moves
        IF nm$ = nam$ THEN GOTO biss
        IF nm$ = "" THEN GOTO biss
        WRITE #2, nm$, rnm$, xp, astr, dstr, maxhp, hp, charm, mhand, mbank, w$, wlev, A$, alev, level, olddate$, fights, pfights, ded, row, coll, warpc, moves

biss:
LOOP
CLOSE
KILL "players.dat"
NAME "players1.dat" AS "players.dat"
nm$ = ynm$
rnm$ = yrnm$
xp = yxp
astr = yastr
dstr = ydstr
maxhp = ymaxhp
hp = yhp
charm = ycharm
mhand = ymhand
mbank = ymbank
w$ = yw$
A$ = ya$
level = ylevel
olddate$ = yolddate$
fights = yfights
pfights = ypfights
ded = yded
row = yrow
coll = ycoll

END SUB

DEFSNG A-Z
SUB Stable
SendCLS
SmartColor 6, 0
SendCR "The Stable is closed!!!"
END SUB

SUB Stats

SendCLS
SendFile "stats.ans", 1
SmartColor 8, 0
AnsiLocate 5, 26: Send " " + nm$
AnsiLocate 6, 26: Send STR$(xp)
AnsiLocate 7, 26: Send STR$(astr)
AnsiLocate 8, 26: Send STR$(dstr)
AnsiLocate 9, 26: Send STR$(hp) + " /" + STR$(maxhp)
AnsiLocate 10, 26: Send STR$(charm)
AnsiLocate 11, 26: Send STR$(mhand)
AnsiLocate 12, 26: Send STR$(mbank)
AnsiLocate 13, 26
IF wlev = 0 THEN Send " Fists" ELSE Send " #" + STR$(wlev) + " " + w$
AnsiLocate 14, 26
IF alev = 0 THEN Send " Skin" ELSE Send " #" + STR$(alev) + " " + A$
AnsiLocate 15, 26: Send STR$(level)
AnsiLocate 16, 26: Send STR$(fights)
AnsiLocate 17, 26: Send STR$(pfights)
AnsiLocate 18, 26: Send STR$(row) + " BY" + STR$(coll)
AnsiLocate 19, 26: Send STR$(moves)
AnsiLocate 22, 0
Pauze
END SUB

SUB Stophere
'Stophere
'  Tests to see if spot can be stopped at
'  and if it can it'll call the SUB
s = 0
SendCLS
A = cord(row, coll)

IF A = 11 THEN Forest: s = 1
IF A = 12 THEN Tavern: s = 1
IF A = 13 THEN Cobbler: s = 1
IF A = 14 THEN Weapon: s = 1
IF A = 15 THEN Armor: s = 1
IF A = 17 THEN Cave: s = 1
IF A = 18 THEN Bank: s = 1
IF A = 22 THEN Cotage: s = 1
IF A = 23 THEN Stable: s = 1

IF A > 59 AND A < 80 THEN Castle: s = 1

IF s = 1 THEN GOTO finis

noplace:
SmartColor 15, 0
SendCR "There's nothing to see here."

finis:
Pauze

END SUB

SUB Tavern
'# of times you can gamble
gam = 3
SendCLS

up:
Linefeed 1
SmartColor 8, 0
Send "Money in hand:"
SmartColor 15, 0
SendCR STR$(mhand)
SmartColor 7, 0
MMenu "Tavern", "OBTNGSR"
q$ = ModemInputChar$
q$ = UCASE$(q$)
Linefeed 1
IF q$ = "T" THEN GOTO talk
IF q$ = "N" THEN News: GOTO up
IF q$ = "G" THEN GOTO gamble
IF q$ = "S" THEN GOTO Spy
IF q$ = "O" THEN GOTO Order
IF q$ = "B" THEN GOTO Bulletin
IF q$ = "R" THEN GOTO back
IF q$ = "?" THEN SendFile "Bar.ans", 1: GOTO up
GOTO up

talk:
SendCLS
SmartColor 15, 0
SendCR SPACE$(5) + "Talk With Drunks"

speech:

'Just to make sure file is there
  OPEN "talk.dat" FOR APPEND AS #1
  CLOSE

OPEN "talk.dat" FOR INPUT AS #1
WHILE NOT EOF(1)
        INPUT #1, nam$, words$
        SmartColor 8, 0
        SendCR nam$ + ":"
        SmartColor 15, 0
        Send SPACE$(5) + CHR$(34): Colorize words$: SendCR CHR$(34)
WEND
CLOSE
Colorize "`8Say Something? `7(y/N)"
q$ = ModemInputChar$
Linefeed 1
q$ = UCASE$(q$)
IF q$ = "Y" THEN
        Linefeed 1
        SmartColor 8, 0
        ModemInput "You say: ", word$, 7, 0, 63
        IF LEN(word$) > 63 THEN
                SmartColor 8, 0
                SendCR "Nobody listens to you because you talk too long"
                Pauze
                GOTO up
        END IF
        OPEN "talk.dat" FOR INPUT AS #1
        OPEN "talks.dat" FOR OUTPUT AS #2
                INPUT #1, nam$, words$
        FOR b = 1 TO 12
                WHILE NOT EOF(1)
                        INPUT #1, nam$, words$
                        WRITE #2, nam$, words$
                WEND
        NEXT
        nam$ = nm$
        words$ = word$
        WRITE #2, nam$, words$
        CLOSE
        KILL "talk.dat"
        NAME "talks.dat" AS "talk.dat"
        SmartColor 7, 0
        SendCR "Everybody agrees with you!"
END IF

Pauze
GOTO up

gamble:
SendCLS
SmartColor 15, 0
SendCR SPACE$(5) + "Gamble"

Linefeed 1
IF gam < 1 THEN
        SmartColor 7, 0
        SendCR "Everybody's broke... Come back later."
        Pauze
        GOTO up
END IF

SmartColor 8, 0
SendCR "You come across an old man with a long beard who says,"
SmartColor 15, 0
SendCR "   " + CHR$(34) + "I'm thinking of a number between 1 and 100..."
SendCR "I'll give you five tries to guess the number." + CHR$(34)
Linefeed 1
Colorize "`8" + CHR$(34) + "Deal?" + CHR$(34) + "`7 (Y/n)"
q$ = ModemInputChar$
Linefeed 1
q$ = UCASE$(q$)
IF q$ = "N" THEN GOTO up
Ok:
SmartColor 7, 0
SendCR CHR$(34) + "How much yo' wanna bet you can do it?" + CHR$(34)
Send SPACE$(5) + "(": SmartColor 15, 0: Send "A": SmartColor 7, 0: Send ")": SmartColor 8, 0: SendCR "ll"
Linefeed 1
SmartColor 8, 0
Send "Money in hand:"
SmartColor 15, 0
SendCR STR$(mhand)
ModemInput "$ ", amt$, 7, 0, 6
IF amt$ = "Q" OR amt$ = "q" THEN Pauze: GOTO up
IF amt$ = "A" OR amt$ = "a" THEN amt$ = STR$(mhand)
amt = VAL(amt$)
IF amt = 0 THEN Pauze: GOTO up
IF amt > mhand THEN
        SmartColor 15, 0
        SendCR CHR$(34) + "You ain't got that much money sonny!" + CHR$(34)
        Pauze
        GOTO up
END IF
IF amt > 999999 THEN
        SmartColor 15, 0
        SendCR CHR$(34) + "Uh.. I don't have that much money.... Go run along you nit! Go on!" + CHR$(34)
        Pauze
        GOTO up
END IF
gam = gam - 1
Num% = INT(RND * 100) + 1
SmartColor 15, 0
SendCR CHR$(34) + "OK, I've got my number!" + CHR$(34)
FOR i = 1 TO 6
        SmartColor 8, 0
        ModemInput "Guess #" + STR$(i) + ">", g$, 7, 0, 2
        IF UCASE$(g$) = "FU" AND (i = 1) THEN GOTO win
        g = VAL(g$)
        IF g = Num% THEN
win:
                SmartColor 7, 0
                SendCR CHR$(34) + "THAT'S THE NUMBER!!" + CHR$(34)
                SmartColor 8, 0
                Send "He hands over your ": SmartColor 15, 0: SendCR "$" + STR$(amt)
                mhand = mhand + amt
                Pauze
                GOTO up
        END IF
        IF g > Num% THEN
                SmartColor 7, 0
                SendCR CHR$(34) + "Too High!" + CHR$(34)
        END IF
        IF g < Num% THEN
                SmartColor 7, 0
                SendCR CHR$(34) + "Too Low!" + CHR$(34)
        END IF
NEXT
SmartColor 15, 0
Linefeed 1
SendCR CHR$(34) + "My number was" + STR$(Num%) + ""
Send "I WIN!!" + CHR$(34)
SmartColor 8, 0
SendCR "The old man giggles as you grudgingly hand over your money.."
mhand = mhand - amt

Pauze
GOTO up

Spy:
co = INT(EXP(level * 3))
Linefeed 1
SmartColor 8, 0
SendCR "So you want to learn about one of your enemies do ya?"
Send "Well it doesn't come cheap! It'll cost ya ": SmartColor 15, 0: Send "$" + STR$(co)
SmartColor 8, 0
SendCR "... Deal?"
Colorize "`8" + CHR$(34) + "Deal?" + CHR$(34) + "`7 (Y/n)"
q$ = ModemInputChar$
Linefeed 1
q$ = UCASE$(q$)
IF q$ = "Y" THEN
        IF mhand < co THEN
                SmartColor 15, 0
                SendCR "Come back when you have the money!"
                GOTO back
        ELSE
peo:

                SmartColor 7, 0
                SendCR "Who would you like to know about?"
                SmartColor 8, 0
                ModemInput "> ", spied$, 7, 0, 20
                IF spied$ = "" THEN Pauze: GOTO up
                SearchForName spied$
                IF nob = TRUE THEN GOTO up
                SmartColor 8, 0
                SendCR "I'll show you " + onm$ + "'s stats...                               "
                Pauze
SendCLS
SendFile "stats.ans", 1
SmartColor 8, 0
AnsiLocate 5, 26: Send " " + onm$
AnsiLocate 6, 26: Send STR$(oxp)
AnsiLocate 7, 26: Send STR$(oastr)
AnsiLocate 8, 26: Send STR$(odstr)
AnsiLocate 9, 26: Send STR$(ohp) + " /" + STR$(omaxhp)
AnsiLocate 10, 26: Send STR$(ocharm)
AnsiLocate 11, 26: Send STR$(omhand)
AnsiLocate 12, 26: Send STR$(ombank)
AnsiLocate 13, 26
IF owlev = 0 THEN Send " Fists" ELSE Send " # " + STR$(owlev) + " " + ow$
AnsiLocate 14, 26
IF oalev = 0 THEN Send " Skin" ELSE Send " #" + STR$(oalev) + " " + oa$
AnsiLocate 15, 26: Send STR$(olevel)
AnsiLocate 16, 26: Send STR$(ofights)
AnsiLocate 17, 26: Send STR$(opfights)
AnsiLocate 18, 26: Send STR$(orow) + " BY" + STR$(ocol)
AnsiLocate 19, 26: Send STR$(omoves)
AnsiLocate 23, 0
Pauze
SmartColor 12, 0

SendCLS
Linefeed 2
SmartColor 8, 0
SendCR "Thanks for the money!"
mhand = INT(mhand - co)
Pauze
        END IF
END IF
GOTO up

Order:
        SendFile "drinks.ans", 1
        AnsiLocate 8, 48: Colorize "`5" + LTRIM$(RTRIM$(STR$(level * 100)))
        AnsiLocate 9, 48: Colorize "`2" + LTRIM$(RTRIM$(STR$(level * 200)))
        AnsiLocate 10, 48: Colorize "`1" + LTRIM$(RTRIM$(STR$(level * 700)))
        AnsiLocate 11, 48: Colorize "`8" + LTRIM$(RTRIM$(STR$(level * 1500)))
        AnsiLocate 16, 0
        Colorize "`1[`9#`1] [`9R`1]eturn`9.`1.`8.? "
        q$ = ModemInputChar$
        Linefeed 1
        q$ = UCASE$(q$)
        IF q$ = "R" THEN GOTO up
        q = VAL(q$)
        IF q = 1 THEN
                        cost = INT(level * 100)
                        IF mhand >= cost THEN
                                Colorize "`3You never felt more handsome.. tee-hee-hee!": Linefeed 1
                                charm = charm + (1 * level)
                                mhand = mhand - cost
                        ELSE
                                Colorize "`8You ain't got enuf `7$$$`8!!...": Linefeed 1
                        END IF
        END IF
        IF q = 2 THEN
                        cost = INT(level * 200)
                        IF mhand >= cost THEN
                                Colorize "`2AH... Suddenly you are SMARTER!": Linefeed 1
                                xp = INT(xp / 10) + xp
                                mhand = mhand - cost
                        ELSE
                                Colorize "`8You ain't got enuf `7$$$`8!!...": Linefeed 1
                        END IF
        END IF

        IF q = 3 THEN
                        cost = INT(level * 700)
                        IF mhand >= cost THEN
                                Colorize "`9Hiccup!.. you wander around town aimlessly using up your moves..!"
                                Linefeed 1
                                moves = moves - INT(moves / 5)
                                mhand = mhand - cost
                        ELSE
                                Colorize "`8You ain't got enuf `7$$$`8!!...": Linefeed 1
                        END IF
        END IF
        IF q = 4 THEN
                        cost = INT(level * 1500)
                        IF mhand >= cost THEN
                                Colorize "`4YOUR MOUTH IS ONE FiRE!!`8 "
                                Linefeed 1
                                SendCR "Flames from your mouth melt the Zima bottle into a strange looking mold.."
                                Colorize "You pocket it fast...": Linefeed 1
                                warpc = TRUE
                                mhand = mhand - cost
                        ELSE
                                Colorize "`8You ain't got enuf `7$$$`8!!..."
                                Linefeed 1
                        END IF
        END IF
        IF q = 5 THEN
        Colorize "`4RUM OF DEATH!?! `7(y/N)"
                q$ = ModemInputChar$
                Linefeed 1
                q$ = UCASE$(q$)
                IF q$ = "Y" THEN
                        Colorize "`4ARE YOU `@SURE `4 YOU WANT TO KiLL YOURSELF!? `7(y/N)"
                        die$ = ModemInputChar$
                        Linefeed 1
                        die$ = UCASE$(die$)
                        IF die$ = "Y" THEN
                                Colorize "`2Gulp.. Gulp.... `4AAAHHHHHHH!!!!!!! ": Linefeed 1
                                Pauze
                                Linefeed 1
                                Fadin "YOUR PLAYER HAS BEEN DELETED!.......", "`4", "`@", "`%": Linefeed 1
                                Pauze
                                SendCLS
                                nam$ = nm$
                                OPEN "players.dat" FOR INPUT AS #1
                                IF NOT EOF(1) THEN INPUT #1, odate$
                                OPEN "Players1.dat" FOR OUTPUT AS #2
                                WRITE #2, DATE$
                                DO WHILE NOT EOF(1)
                                        INPUT #1, nm$, rnm$, xp, astr, dstr, maxhp, hp, charm, mhand, mbank, w$, wlev, A$, alev, level, olddate$, fights, pfights, ded, row, coll, warpc, moves
                                        IF nm$ = nam$ THEN GOTO bisss
                                        IF nm$ = "" THEN GOTO bisss
                                        WRITE #2, nm$, rnm$, xp, astr, dstr, maxhp, hp, charm, mhand, mbank, w$, wlev, A$, alev, level, olddate$, fights, pfights, ded, row, coll, warpc, moves
bisss:
                                LOOP
                                CLOSE
                                KILL "players.dat"
                                NAME "players1.dat" AS "players.dat"
                                       
                                n$ = "`4" + nm$
                                T$ = "`@ KiLLED `4HIMSELF! "
                                na$ = yel$
                                OPEN "news.dat" FOR APPEND AS #1
                                        WRITE #1, n$, T$, na$
                                CLOSE
                                Endscreen
                        ELSE
                                GOTO up
                        END IF
                END IF
        END IF
        Pauze
        GOTO up

Bulletin:
reed:
Linefeed 2
OPEN "bul.dat" FOR APPEND AS #1
CLOSE
OPEN "bul.dat" FOR INPUT AS #1
        IF NOT EOF(1) THEN
                INPUT #1, naame$, tekst$
                Colorize "`%" + naame$ + " `1posted this:"
                Linefeed 1
                Colorize "`8> `7" + tekst$
        ELSE
                Colorize "`1NOTHiNG POSTED! WRiTE SOME!"
        END IF
CLOSE
Linefeed 1
Pauze
huh:
Linefeed 1
Colorize "`1[`9R`1]ead [`9W`1]rite [`9Q`1]uit`9.`1.`8.? "
q$ = ModemInputChar$
Linefeed 1
q$ = UCASE$(q$)
IF q$ = "R" THEN GOTO reed
IF q$ = "W" THEN
        Fade "WHADDYA WANNA WRiTE, WACKO?": Linefeed 1
        SmartColor 8, 0
        ModemInput "> ", tekst$, 7, 0, 65
        IF tekst$ = "" THEN
                Colorize "`4Yeah right.."
                Linefeed 1
                Pauze
                GOTO huh
        END IF
        OPEN "bul.dat" FOR OUTPUT AS #1
                WRITE #1, nm$, tekst$
        CLOSE
        Fade "Thankee!"
        Linefeed 1
        Pauze
        GOTO huh
END IF
IF q$ = "Q" THEN GOTO up
GOTO huh

back:
Linefeed 1
END SUB

DEFINT A-Z
SUB Warp
'Warp to a location on map
SendCLS
SmartColor 15, 0
Send SPACE$(5) + "Warp"

Linefeed 1
IF warpc = TRUE THEN
        SmartColor 8, 0
        SendCR SPACE$(5) + "You take your warp crystal out of your pocket"
        SendCR SPACE$(5) + "and hold it in your hand.. You can feel it's"
        SendCR SPACE$(5) + "power throbbing... "

ELSE
        SmartColor 8, 0
        SendCR SPACE$(5) + "Sorry, you don't have a warp crystal to use..."
        Pauze
        EXIT SUB
END IF
END SUB

DEFSNG A-Z
SUB Yell
SendCLS
SmartColor 15, 0
SendCR "Make Announcement"

Linefeed 1
IF yelln > 2 THEN
        SmartColor 7, 0
        SendCR "Your voice is to dry."
        GOTO don

END IF

SmartColor 7, 0
SendCR "What would you like to yell out?"
SmartColor 8, 0
SendCR "(It will appear on the Daily News)"
SmartColor 8, 0
ModemInput "> ", yel$, 7, 0, 65

IF yel$ = "" THEN
        SendCR "Okay, DON'T yell out something..."
        GOTO don
END IF

IF UCASE$(yel$) = "CALENDER" THEN Dailies: SendCR "Your Daily Priveleges are RESET.": GOTO don:
IF UCASE$(yel$) = "PALBY" THEN mbank = INT(mbank * 2): SendCR "You suddenly feel quite wealthy...": GOTO don
yel$ = "`@" + yel$

yelln = yelln + 1
n$ = nm$
T$ = " yelled out: "
na$ = yel$
OPEN "news.dat" FOR APPEND AS #1
WRITE #1, n$, T$, na$
CLOSE
Linefeed 1
SmartColor 8, 0
SendCR "Everyone hears you!"
don:
Pauze

END SUB

