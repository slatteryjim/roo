DEFINT A-Z
DECLARE SUB Endscreen ()
DECLARE SUB Dailies ()
DECLARE SUB Fadin (stri AS STRING, col1$, col2$, col3$)
DECLARE SUB Stats ()
DECLARE SUB SearchForMail ()
DECLARE SUB MMenu (head$, comm$)
DECLARE SUB Fade (Text$)
DECLARE SUB CheckStats ()
DECLARE SUB SaveStats ()
DECLARE SUB SearchForName (nayme$)
DECLARE SUB Colorize (Text$)
DECLARE SUB Pauze ()
DECLARE SUB DailyM ()
DECLARE SUB Rankings ()
DECLARE SUB Sort ()

DIM SHARED cord(19, 23) AS SINGLE, place(25) AS STRING * 10, colo(25) AS INTEGER
COMMON SHARED cord() AS SINGLE, place() AS STRING * 10, recip$, from$, Message$, heading$, name$, hit%, odate$, yelln, fl   AS SINGLE
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

CONST TRUE = 1
CONST FALSE = 0

DEFSNG A-Z
SUB Armor
SendCLS

Amenu:

MMenu "Armor Shop", "BSLVR"
q$ = ModemInputChar$
Linefeed 1
q$ = UCASE$(q$)
IF q$ = "B" THEN GOTO buya
IF q$ = "S" THEN GOTO Sella
IF q$ = "L" THEN GOTO Alist
IF q$ = "V" THEN Stats
IF q$ = "?" THEN SendFile "Ashop.ans", 1
IF q$ = "R" THEN EXIT SUB

GOTO Amenu:

buya:
IF alev > 0 THEN Colorize "`8You've already got `%ARMOR`8!": Linefeed 1: Pauze: GOTO Amenu
SendCR "What Armor Level would you like to Purchase?"
SmartColor 8, 0
ModemInput "> ", l$, 7, 0, 2: Linefeed 1
l = INT(VAL(l$))
IF l > 10 OR l < 1 THEN Colorize "`4Uh-huh...": Linefeed 1: Pauze: GOTO Amenu
SELECT CASE l
CASE 1
        price = 150
CASE 2
        price = 300
CASE 3
        price = 600
CASE 4
        price = 1500
CASE 5
        price = 2500
CASE 6
        price = 5000
CASE 7
        price = 10000
CASE 8
        price = 20000
CASE 9
        price = 30000
CASE 10
        price = 70000
CASE ELSE
        Colorize "`4Uh-huh..."
        Linefeed 1
        Pauze
        GOTO Amenu
END SELECT
IF price > mhand THEN
        Colorize "`8You don't have enuf `%$$`8!..."
        Linefeed 1
        Pauze
        GOTO Amenu
END IF
Fade "I'll sell you my `%" + A$ + " level" + STR$(l) + "`8 for`%" + STR$(price) + " `7(y/N)"
q$ = ModemInputChar$
Linefeed 1
q$ = UCASE$(q$)
IF q$ = "Y" THEN
        dstr = dstr + (l * 8)
boughta:
        alev = l
        mhand = mhand - price
        Colorize "`0YOU GOT iT!"
        Linefeed 1
        Pauze
END IF
GOTO Amenu

Sella:
SELECT CASE alev
CASE 0
        Colorize "`4Uh-huh..."
        Linefeed 1
        Pauze
        GOTO Amenu
CASE 1
        price = 75
CASE 2
        price = 150
CASE 3
        price = 300
CASE 4
        price = 750
CASE 5
        price = 1250
CASE 6
        price = 2500
CASE 7
        price = 5000
CASE 8
        price = 10000
CASE 9
        price = 15000
CASE 10
        price = 35000
END SELECT

Fade "I'll buy your `%" + A$ + " level" + STR$(alev) + "`8 for`%$" + STR$(price) + " `7(y/N)"
q$ = ModemInputChar$
Linefeed 1
q$ = UCASE$(q$)
IF q$ = "Y" THEN
        mhand = mhand + price
        dstr = dstr - INT(alev * 8)
        alev = 0
END IF
GOTO Amenu


Alist:
SendFile "Aprice.ans", 1
AnsiLocate 4, 0
Send Center$(A$ + " LEV" + STR$(alev))
AnsiLocate 20, 0
Pauze
GOTO Amenu


END SUB

SUB Bank

SendCLS

selec:
mhand = INT(mhand)
mbank = INT(mbank)
CheckStats
Linefeed 1
SmartColor 8, 0
Send "Money in hand:"
SmartColor 15, 0
SendCR STR$(mhand)
SmartColor 8, 0
Send "Money in account:"
SmartColor 15, 0
SendCR STR$(mbank)
SmartColor 7, 0
MMenu "Bank", "DWR"
q$ = ModemInputChar$
q$ = UCASE$(q$)
SmartColor 7, 0
SendCR q$
IF q$ = "D" THEN GOTO deposit
IF q$ = "W" THEN GOTO withdraw
IF q$ = "R" THEN GOTO cancel
IF q$ = "?" THEN SendFile "bank.ans", 1
GOTO selec

deposit:
        SendCLS
SmartColor 15, 0
SendCR SPACE$(5) + "Bank"

       
        SmartColor 7, 0
        SendCR "How much would you like to deposit?"
        SmartColor 7, 0
        Send SPACE$(5) + "(": SmartColor 15, 0: Send "A": SmartColor 7, 0: Send ")": SmartColor 8, 0: SendCR "ll of it"
        Linefeed 1
SmartColor 8, 0
Send "Money in hand:"
SmartColor 15, 0
SendCR STR$(mhand)
SmartColor 8, 0
Send "Money in account:"
SmartColor 15, 0
SendCR STR$(mbank)
      
        SmartColor 15, 0
        ModemInput "$ ", amt$, 7, 0, 9
        IF amt$ = "A" OR amt$ = "a" THEN mbank = mbank + mhand: mhand = 0
        amt = VAL(amt$)
        IF amt > mhand THEN SmartColor 15, 0: Send "You don't have that much money": Pauze: GOTO selec
        mhand = mhand - amt
        mbank = mbank + amt
        GOTO selec
withdraw:
      
        SendCLS
SmartColor 15, 0
SendCR SPACE$(5) + "Bank"

        SmartColor 7, 0
        SendCR "How much would you like to withdraw?"
        SmartColor 7, 0
        Send SPACE$(5) + "(": SmartColor 15, 0: Send "A": SmartColor 7, 0: Send ")": SmartColor 8, 0: SendCR "ll of it"
        Linefeed 1
SmartColor 8, 0
Send "Money in hand:"
SmartColor 15, 0
SendCR STR$(mhand)
SmartColor 8, 0
Send "Money in account:"
SmartColor 15, 0
SendCR STR$(mbank)
      
        SmartColor 15, 0
        ModemInput "$ ", amt$, 7, 0, 9
        
        IF amt$ = "A" OR amt$ = "a" THEN mhand = mhand + mbank: mbank = 0
        amt = VAL(amt$)
        IF amt > mbank THEN SmartColor 15, 0: SendCR "You don't have that much money in your account": Pauze: GOTO selec
        mhand = mhand + amt
        mbank = mbank - amt
        GOTO selec

       

cancel:
Linefeed 1
CheckStats

END SUB

DEFINT A-Z
SUB CheckStats
SearchForMail
IF mbank > 400000000 THEN mbank = 200000000
IF mbank < 1 THEN mbank = 0
IF mhand > 400000000 THEN mhand = 200000000
IF mhand < 1 THEN mhand = 0
IF xp > 100000000 THEN xp = 20000000
IF xp < 1 THEN xp = 0
IF maxhp > 9999 THEN maxhp = 9999
IF hp > 9999 THEN hp = 9999
IF hp < 1 THEN hp = 0
IF moves < 1 THEN moves = 0
IF moves > 9999 THEN moves = 500
IF alev > 10 THEN alev = 10
IF wlev > 10 THEN wlev = 10
IF alev < 0 THEN alev = 0
IF wlev < 0 THEN wlev = 0
END SUB

DEFSNG A-Z
SUB Colorize (Text$)
v = 1
WHILE v < LEN(Text$) + 1
s = 0
IF MID$(Text$, v, 1) = "`" THEN
        s = 1
        mi$ = MID$(Text$, v + 1, 1)
        IF mi$ = "1" THEN SmartColor 1, 0: v = v + 1
        IF mi$ = "2" THEN SmartColor 2, 0: v = v + 1
        IF mi$ = "3" THEN SmartColor 3, 0: v = v + 1
        IF mi$ = "4" THEN SmartColor 4, 0: v = v + 1
        IF mi$ = "5" THEN SmartColor 5, 0: v = v + 1
        IF mi$ = "6" THEN SmartColor 6, 0: v = v + 1
        IF mi$ = "7" THEN SmartColor 7, 0: v = v + 1
        IF mi$ = "8" THEN SmartColor 8, 0: v = v + 1
        IF mi$ = "9" THEN SmartColor 9, 0: v = v + 1
        IF mi$ = "0" THEN SmartColor 10, 0: v = v + 1
        IF mi$ = "!" THEN SmartColor 11, 0: v = v + 1
        IF mi$ = "@" THEN SmartColor 12, 0: v = v + 1
        IF mi$ = "#" THEN SmartColor 13, 0: v = v + 1
        IF mi$ = "$" THEN SmartColor 14, 0: v = v + 1
        IF mi$ = "%" THEN SmartColor 15, 0: v = v + 1
        IF mi$ = "`" THEN Send "`": v = v + 1
        IF mi$ = "P" THEN Pauze: v = v + 1
END IF
IF s = 1 THEN GOTO nu
Send MID$(Text$, v, 1)
nu:
v = v + 1
WEND
END SUB

SUB ColorTest
SendCLS
FOR i = 1 TO 15
        COLOR i, 0
PRINT STR$(i)
NEXT

END SUB

SUB Dailies
'Dailies
'  Players daily settings

fl = 1
ded = FALSE
fights = 15
pfights = 3
moves = 100

END SUB

SUB DailyM
'Daily Maintenance
RANDOMIZE RND
'Erase yesterday's news file
CLOSE
OPEN "news.dat" FOR OUTPUT AS #1
CLOSE

OPEN "talk.dat" FOR INPUT AS #1
WHILE NOT EOF(1)
        INPUT #1, nam$, words$
WEND
CLOSE
       
        OPEN "talk.dat" FOR INPUT AS #1
        OPEN "talks.dat" FOR OUTPUT AS #2
                INPUT #1, nam$, words$
        FOR b = 1 TO 12
                WHILE NOT EOF(1)
                        INPUT #1, nam$, words$
                        WRITE #2, nam$, words$
                WEND
        NEXT
        d% = INT(RND * 12)
        IF d% = 1 THEN
                words$ = "You smell, `$" + nam$ + "`%!!!"
                nam$ = "Rana"
        END IF
        IF d% = 2 THEN
                words$ = "Hold it in next time will ya, `$" + nam$ + "`%?"
                nam$ = "Bartend"
        END IF
        IF d% = 3 THEN
                words$ = "Come here, `$" + nam$ + "`%, I've got a secret to tell you..."
                nam$ = "Barmaid"
        END IF
        IF d% = 4 THEN
                words$ = "You're the biggest wimp I know, `$" + nam$ + "`%!"
                nam$ = "Haron"
        END IF
        IF d% = 5 THEN
                words$ = "Have another drink, `$" + nam$ + "`%?"
                nam$ = "Bartend"
        END IF
        IF d% = 6 THEN
                words$ = "Well said, `$" + nam$ + "`%!"
                nam$ = "Rana"
        END IF
        IF d% = 7 THEN
                words$ = "I agree, `$" + nam$ + "`%."
                nam$ = "Chaui"
        END IF
        IF d% = 8 THEN
                words$ = "`@Beware, " + nam$ + "..."
                nam$ = "Hooded Warrior"
        END IF
        IF d% = 9 THEN
                words$ = "I don't see why everyone's hot for the barmaid..."
                nam$ = "Old Man"
        END IF
        IF d% = 10 THEN
                words$ = "`$" + nam$ + "`%, you wanna fight me? Huh?!"
                nam$ = "Rand"
        END IF
        WRITE #2, nam$, words$
        CLOSE
        KILL "talk.dat"
        NAME "talks.dat" AS "talk.dat"

END SUB

SUB Date

CheckStats
SmartColor 7, 0
IF olddate$ = DATE$ THEN
        Text$ = "BACK FeR MORE, EH?"
        Fade Text$
        Linefeed 1
        GOTO done
END IF
IF odate$ <> DATE$ THEN DailyM

'Reset player fights etc.
Dailies

'Find out how many days been gone
y = VAL(RIGHT$(DATE$, 4))
m = VAL(LEFT$(DATE$, 2))
d = VAL(MID$(DATE$, 4, 2))

oyear = VAL(RIGHT$(olddate$, 4))
om = VAL(LEFT$(olddate$, 2))
od = VAL(MID$(olddate$, 4, 2))

SELECT CASE m
        CASE 1
                ytd = 0
        CASE 2
                ytd = 31
        CASE 3
                ytd = 59
        CASE 4
                ytd = 90
        CASE 5
                ytd = 120
        CASE 6
                ytd = 151
        CASE 7
                ytd = 181
        CASE 8
                ytd = 212
        CASE 9
                ytd = 243
        CASE 10
                ytd = 273
        CASE 11
                ytd = 304
        CASE 12
                ytd = 334
END SELECT
SELECT CASE om
        CASE 1
                oytd = 0
        CASE 2
                oytd = 31
        CASE 3
                oytd = 59
        CASE 4
                oytd = 90
        CASE 5
                oytd = 120
        CASE 6
                oytd = 151
        CASE 7
                oytd = 181
        CASE 8
                oytd = 212
        CASE 9
                oytd = 243
        CASE 10
                oytd = 273
        CASE 11
                oytd = 304
        CASE 12
                oytd = 334
END SELECT
               
dtd = ytd + d
odtd = oytd + od
days = dtd - odtd  'dtd=total days absent
'Add interest to bank account and add experience points
'
FOR i = 1 TO days
        mbank = level + mbank
        xp = level + xp
        CheckStats
NEXT
days% = days
IF days% < 0 THEN days% = -days%
SmartColor 8, 0
Send "You haven't entered the realm in ": SmartColor 15, 0: Send Num2Str(days%): SmartColor 8, 0: SendCR " days!"
SendCR "Your stats have been raised for each day missed."

done:
Pauze
CheckStats
END SUB

DEFINT A-Z
SUB Fade (Text$)
T$ = Text$
SELECT CASE LEN(Text$)
        CASE IS <= 9
                wi$ = LEFT$(Text$, 1)
                lg$ = MID$(Text$, 2, 2)
                g$ = RIGHT$(Text$, (LEN(Text$) - 3))
                T$ = "`%" + wi$ + "`7" + lg$ + "`8" + g$
        CASE IS > 9
                wi$ = LEFT$(Text$, 2)
                lg$ = MID$(Text$, 3, 3)
                g$ = RIGHT$(Text$, (LEN(Text$) - 5))
                T$ = "`%" + wi$ + "`7" + lg$ + "`8" + g$
END SELECT
Colorize T$

END SUB

DEFSNG A-Z
SUB Fadin (stri AS STRING, col1$, col2$, col3$)
SmartColor 3, 0
strin$ = stri + "            "
FOR l = 1 TO LEN(strin$) + 3
        IF l = 1 THEN
                ll$ = "": lt$ = "": lw$ = "": m$ = "": rt$ = ""
                rw$ = LEFT$(strin$, 1)
                GOTO cont
        END IF
        IF l = 2 THEN
                ll$ = "": lt$ = "": lw$ = "": m$ = "": rt$ = ""
                rw$ = LEFT$(strin$, 2)
                SendLeft 1
                GOTO cont
        END IF
        IF l = 3 THEN
                ll$ = "": lt$ = "": lw$ = "": m$ = ""
                rt$ = LEFT$(strin$, 1)
                rw$ = MID$(strin$, l - 1, 2)
                SendLeft 2
                GOTO cont
        END IF
        IF l = 4 THEN
                ll$ = "": lt$ = "": lw$ = ""
                m$ = LEFT$(strin$, 1)
                rt$ = MID$(strin$, l - 2, 1)
                rw$ = MID$(strin$, l - 1, 2)
                SendLeft 3
                GOTO cont
        END IF
        IF l = 5 THEN
                ll$ = "": lt$ = ""
                lw$ = LEFT$(strin$, 1)
                m$ = MID$(strin$, l - 3, 1)
                rt$ = MID$(strin$, l - 2, 1)
                rw$ = MID$(strin$, l - 1, 2)
                SendLeft 4
                GOTO cont
        END IF
        IF l = 6 THEN
                ll$ = ""
                lt$ = LEFT$(strin$, 1)
                lw$ = MID$(strin$, l - 4, 1)
                m$ = MID$(strin$, l - 3, 1)
                rt$ = MID$(strin$, l - 2, 1)
                rw$ = MID$(strin$, l - 1, 2)
                SendLeft 5
                GOTO cont
        END IF
        IF l = 7 THEN
                ll$ = ""
                lt$ = LEFT$(strin$, 2)
                lw$ = MID$(strin$, l - 4, 1)
                m$ = MID$(strin$, l - 3, 1)
                rt$ = MID$(strin$, l - 2, 1)
                rw$ = MID$(strin$, l - 1, 2)
                SendLeft 6
                GOTO cont
        END IF
        IF l = 8 THEN
                ll$ = ""
                lt$ = LEFT$(strin$, 3)
                lw$ = MID$(strin$, l - 4, 1)
                m$ = MID$(strin$, l - 3, 1)
                rt$ = MID$(strin$, l - 2, 1)
                rw$ = MID$(strin$, l - 1, 2)
                SendLeft 7
                GOTO cont
        END IF
        IF l = 9 THEN
                ll$ = LEFT$(strin$, 1)
                lt$ = MID$(strin$, l - 7, 3)
                lw$ = MID$(strin$, l - 4, 1)
                m$ = MID$(strin$, l - 3, 1)
                rt$ = MID$(strin$, l - 2, 1)
                rw$ = MID$(strin$, l - 1, 2)
                SendLeft 8
                GOTO cont
        END IF
        ll$ = MID$(strin$, l - 8, 1)
        lt$ = MID$(strin$, l - 7, 3)
        lw$ = MID$(strin$, l - 4, 1)
        m$ = MID$(strin$, l - 3, 1)
        rt$ = MID$(strin$, l - 2, 1)
        rw$ = MID$(strin$, l - 1, 2)
        SendLeft 8
cont:
        Pause 1
        Colorize "`8" + ll$
        Colorize col1$ + lt$
        Colorize col2$ + lw$
        Colorize col3$ + m$
        Colorize col2$ + rt$
        Colorize col1$ + rw$
NEXT


END SUB

SUB HitAmt (ap AS SINGLE, exper AS LONG, odp AS SINGLE, oexper AS LONG)
'HitAmt
' Determine amount of damage invoked

ex = exper
oex = oexper
A = ap
od = odp

DO
his% = INT(RND * A)
block% = INT(RND * od)
hit% = INT(his% - block%)
IF hit% < 1 THEN hit% = 0
LOOP UNTIL hit% > A / 2 AND hit% < A * 2




END SUB

SUB Instructions
SendCLS
OPEN "instruc.dat" FOR INPUT AS #1
DO
        Linefeed 1
        LINE INPUT #1, Text$
        IF RTRIM$(LEFT$(Text$, 4)) = "****" THEN EXIT DO
        Colorize Text$
LOOP
CLOSE

END SUB

SUB MMenu (head$, comm$)
Linefeed 1
Colorize "`%Ú`7Ä[": Fade "Commands": Colorize " `7í "
FOR A = 1 TO (LEN(comm$))
        Colorize "`8" + MID$(comm$, A, 1)
        IF A <> LEN(comm$) THEN Colorize "`4ú" ELSE Colorize "`7]"
               
NEXT A
Linefeed 1
Colorize "`%À`7Ä[": Fade head$: Colorize "`7]`8? "

END SUB

SUB Pauze
'Pauze
' Prints "úÄ´ Pause ÃÄú" on the screen and waits for a key press
T:
Colorize "`9Ä`%´`1pause`%Ã`9Ä"
SendLeft 2
topp:
GOSUB one
GOSUB two
GOSUB three
GOSUB four
GOSUB five
GOSUB four
GOSUB three
GOSUB two
GOTO topp
GOTO d:
one:
IF GetChar$ = "" THEN : SendLeft 5: Pause 1: Colorize "`9p`1ause" ELSE GOTO d
IF GetChar$ = "" THEN : SendLeft 5: Pause 2: Colorize "`9P`1ause" ELSE GOTO d
IF GetChar$ = "" THEN : SendLeft 5: Pause 2: Colorize "`9p`1ause" ELSE GOTO d
RETURN

two:
IF GetChar$ = "" THEN : SendLeft 5: Pause 1: Colorize "`1p`9a`1use" ELSE GOTO d
IF GetChar$ = "" THEN : SendLeft 5: Pause 2: Colorize "`1p`9A`1use" ELSE GOTO d
IF GetChar$ = "" THEN : SendLeft 5: Pause 2: Colorize "`1p`9a`1use" ELSE GOTO d
RETURN

three:
IF GetChar$ = "" THEN : SendLeft 5: Pause 1: Colorize "`1pa`9u`1se" ELSE GOTO d
IF GetChar$ = "" THEN : SendLeft 5: Pause 2: Colorize "`1pa`9U`1se" ELSE GOTO d
IF GetChar$ = "" THEN : SendLeft 5: Pause 2: Colorize "`1pa`9u`1se" ELSE GOTO d
RETURN

four:
IF GetChar$ = "" THEN : SendLeft 5: Pause 1: Colorize "`1pau`9s`1e" ELSE GOTO d
IF GetChar$ = "" THEN : SendLeft 5: Pause 2: Colorize "`1pau`9S`1e" ELSE GOTO d
IF GetChar$ = "" THEN : SendLeft 5: Pause 2: Colorize "`1pau`9s`1e" ELSE GOTO d
RETURN

five:
IF GetChar$ = "" THEN : SendLeft 5: Pause 1: Colorize "`1paus`9e" ELSE GOTO d
IF GetChar$ = "" THEN : SendLeft 5: Pause 2: Colorize "`1paus`9E" ELSE GOTO d
IF GetChar$ = "" THEN : SendLeft 5: Pause 2: Colorize "`1paus`9e" ELSE GOTO d
RETURN

d:
Send SPACE$(9)
BackSpace 20
END SUB

SUB Quit
xp = INT(xp)

IF ded = TRUE THEN GOTO quitgame

SendCLS
Colorize "`4Do you `@REALLY `4want to halt this day's adventures? `7(y/N)"
q$ = ModemInputChar$
Linefeed 1
q$ = UCASE$(q$)
IF q$ = "Y" THEN GOTO quitgame ELSE GOTO nope

quitgame:
SmartColor 8, 0
SendCR "Saving..."
olddate$ = DATE$
hp = maxhp
odate$ = DATE$
CLOSE
CheckStats
SaveStats

Pauze
Endscreen

nope:
Pauze

END SUB

DEFINT A-Z
SUB Rankings
i = 0
'Rankings:
'  Print user rankings after using
'  the sort sub to sort the players
'  based on their experience
'Write stats to file
SaveStats

'Sort the players
Sort
'Find how many players are in the game
i = 0
SendCLS
SendFile "Rank.ans", 0
l = 5
i = 0
FOR f = 1 TO nplayers - 1
        IF LTRIM$(RTRIM$(onam(f))) = LTRIM$(RTRIM$(nm$)) THEN si = f: EXIT FOR
NEXT f

FOR i = 1 TO nplayers - 1
        IF l = 15 THEN
                AnsiLocate 20, 0
                Pauze
                l = 5
                AnsiLocate 5, 0
                FOR Z = 0 TO 9
                        AnsiLocate 5 + Z, 18
                       Send SPACE$(45)
                NEXT Z
        END IF
        SmartColor 15, 0
        AnsiLocate l, 19: Send RTRIM$(LTRIM$(STR$(i)))
        SmartColor 7, 0
        AnsiLocate l, 23: Send STR$(o.level(i))
        AnsiLocate l, 30
        IF si = i THEN
                SmartColor 15, 1
                Send onam(i)
        ELSE
                SmartColor 8, 0
                Fade onam(i)
        END IF
        SmartColor 7, 0
        AnsiLocate l, 45: Send STR$(o.xp(i))
        IF o.ded(i) = TRUE THEN
                SmartColor 8, 0
                AnsiLocate l, 58: SendCR "Dead "
                ELSEIF o.ded(i) = FALSE THEN
                SmartColor 15, 0
                AnsiLocate l, 58: SendCR "Alive"
        END IF
        l = l + 1
nexts:
NEXT

ERASE onam, o.xp, o.level, o.ded
AnsiLocate 20, 0
Pauze
      

END SUB

DEFSNG A-Z
SUB Reroll (BF AS SINGLE)

IF BF = TRUE THEN GOTO fo
alia:
CLOSE
SmartColor 8, 0
Fade "WHAT'S YeR `%HANDLE,`8 DUDe?": Linefeed 1
ModemInput "> ", nm$, 7, 0, 15
nm$ = Cap$(nm$)
IF nm$ = "" THEN GOTO alia
IF LEN(nm$) > 15 THEN
        SmartColor 15, 0
        Fade "2 LONG. TRI UGiN"
        Linefeed 1
        Pauze
        GOTO alia
END IF
OPEN "players.dat" FOR INPUT AS #1
IF NOT EOF(1) THEN INPUT #1, odate$
DO WHILE NOT EOF(1)
        INPUT #1, onm$, ornm$, oxp, oastr, odstr, omaxhp, ohp, ocharm, omhand, ombank, ow$, wlev, oa$, alev, olevel, oolddate$, ofights, opfights, oded, orow, ocol, owarpc, omoves
        IF UCASE$(onm$) = UCASE$(nm$) THEN
                SmartColor 15, 0
                SendCR "Somebody else has that name!"
                GOTO alia
        END IF
nexs:
LOOP

CLOSE
SmartColor 15, 0
Fadin UCASE$(nm$) + " BE THOU TRUe NAME?", "`3", "`!", "`%": Linefeed 1: SmartColor 7, 0: SendCR " (y/N)"
q$ = ModemInputChar$
q$ = UCASE$(q$)
IF q$ = "Y" THEN GOTO fo
GOTO alia

fo:
Fade "AND WHADDA WANT FOR A WEAPON?": Linefeed 1
ModemInput "> ", w$, 7, 0, 15
IF w$ = "" THEN w$ = "Sword"
Fade "AND FoR ARMOR?": Linefeed 1
ModemInput "> ", A$, 7, 0, 15: Linefeed 1
IF A$ = "" THEN A$ = "Shield"
Fade "THANKS!"
Linefeed 1
Pauze

xp = 0
astr = 10
dstr = 8
maxhp = 20
hp = 20
charm = 10
mhand = 50
mbank = 50
wlev = 0
alev = 0
level = 1
olddate$ = DATE$
fights = 15
pfights = 3
ded = FALSE
row = 7
coll = 9
warpc = FALSE
moves = 100

END SUB

SUB SearchForMail
'SearchForMail
'  Searches for mail for the specified person
redsome = FALSE
OPEN "mail.dat" FOR INPUT AS #1
DO WHILE NOT EOF(1)
        INPUT #1, recip$, from$, Message$, heading$
        IF recip$ = nm$ THEN GOSUB readmail
LOOP
CLOSE

GOTO nopemail

readmail:
redsome = TRUE
Linefeed 2
SmartColor 11, 0
Colorize heading$
Linefeed 1
SmartColor 8, 0
Colorize Message$
Linefeed 1
Pauze
recp$ = recip$
frm$ = from$
msg$ = Message$
hding$ = heading$
CLOSE
OPEN "mail.dat" FOR INPUT AS #1
OPEN "mail1.dat" FOR OUTPUT AS #2
WHILE NOT EOF(1)
        INPUT #1, recip$, from$, Message$, heading$
        IF recip$ <> recp$ AND frm$ <> from$ AND msg$ <> Message$ AND hding$ <> heading$ THEN WRITE #2, recip$, from$, Message$, heading$
WEND
CLOSE
KILL "mail.dat"
NAME "mail1.dat" AS "mail.dat"
OPEN "mail.dat" FOR INPUT AS #1
RETURN

nopemail:
CLOSE
END SUB

SUB SearchForName (nayme$)
nob = FALSE
nayme$ = UCASE$(nayme$)
OPEN "players.dat" FOR INPUT AS #1
IF NOT EOF(1) THEN INPUT #1, odate$
DO WHILE NOT EOF(1)
        INPUT #1, onm$, ornm$, oxp, oastr, odstr, omaxhp, ohp, ocharm, omhand, ombank, ow$, owlev, oa$, oalev, olevel, oolddate$, ofights, opfights, oded, orow, ocol, owarpc, omoves
        IF nayme$ = LEFT$(UCASE$(onm$), LEN(nayme$)) THEN GOSUB check
LOOP
CLOSE
SmartColor 7, 0
SendCR "I've never heard of that guy."
nob = TRUE
Pauze
EXIT SUB
check:
SmartColor 8, 0
        Colorize "`1Are you talking about `7" + onm$ + "`1? `7(y/N)"
        q$ = ModemInputChar$
        Linefeed 1
        q$ = UCASE$(q$)
        IF q$ = "Y" THEN
                nayme$ = onm$
                CLOSE
                EXIT SUB
        ELSE
                RETURN
        END IF
END SUB

SUB Sort
'Sort
'  Order the players from greatest to least experience
'Reset array
ERASE onam, o.xp, o.level, o.ded

nplayers = 0
i = 0
'Find how many players are in the game
cntr = 1
OPEN "players.dat" FOR INPUT AS #1
IF NOT EOF(1) THEN INPUT #1, odate$
DO WHILE NOT EOF(1)
        INPUT #1, onam(cntr), ornm$, o.xp(cntr), oastr, odstr, omaxhp, ohp, ocharm, omhand, ombank, ow$, owlev, oa$, oalev, o.level(cntr), oolddate$, ofights, opfights, o.ded(cntr), orow, ocol, owarpc, omoves
        cntr = cntr + 1
LOOP
CLOSE
      
'Sort the players
nplayers = cntr
s = 1
WHILE s = 1
        s = 0
        FOR i = 1 TO (nplayers + 1)
                IF o.xp(i) < o.xp(i + 1) THEN
                        s = 1
                        SWAP onam(i), onam(i + 1)
                        SWAP o.xp(i), o.xp(i + 1)
                        SWAP o.level(i), o.level(i + 1)
                        SWAP o.ded(i), o.ded(i + 1)
                END IF
        NEXT i
WEND



f:

END SUB

SUB Weapon

SendCLS

Wmenu:

MMenu "Weapon Shop", "BSLVR"
q$ = ModemInputChar$
Linefeed 1
q$ = UCASE$(q$)
IF q$ = "B" THEN GOTO buyw
IF q$ = "S" THEN GOTO Sellw
IF q$ = "L" THEN GOTO Wlist
IF q$ = "V" THEN Stats
IF q$ = "?" THEN SendFile "Wshop.ans", 1
IF q$ = "R" THEN EXIT SUB

GOTO Wmenu:

buyw:
IF wlev > 0 THEN Colorize "`8You've already got a `%WEAPON`8!": Linefeed 1: Pauze: GOTO Wmenu
SendCR "What Weapon Level would you like to Purchase?"
SmartColor 8, 0
ModemInput "> ", l$, 7, 0, 2: Linefeed 1
l = INT(VAL(l$))
IF l > 10 OR l < 1 THEN Colorize "`4Uh-huh...": Linefeed 1: Pauze: GOTO Wmenu
SELECT CASE l
CASE 1
        price = 150
CASE 2
        price = 300
CASE 3
        price = 600
CASE 4
        price = 1500
CASE 5
        price = 2500
CASE 6
        price = 5000
CASE 7
        price = 10000
CASE 8
        price = 20000
CASE 9
        price = 30000
CASE 10
        price = 70000
CASE ELSE
        Colorize "`4Uh-huh..."
        Linefeed 1
        Pauze
        GOTO Wmenu
END SELECT
IF price > mhand THEN
        Colorize "`8You don't have enuf `%$$`8!..."
        Linefeed 1
        Pauze
        GOTO Wmenu
END IF
Fade "I'll sell you my `%" + w$ + " level" + STR$(l) + "`8 for`%" + STR$(price) + " `7(y/N)"
q$ = ModemInputChar$
Linefeed 1
q$ = UCASE$(q$)
IF q$ = "Y" THEN
        astr = astr + (l * 10)
boughtw:
        wlev = l
        mhand = mhand - price
        Colorize "`0YOU GOT iT!"
        Linefeed 1
        Pauze
END IF
GOTO Wmenu

Sellw:

SELECT CASE wlev
CASE 0
        Colorize "`4Uh-huh..."
        Linefeed 1
        Pauze
        GOTO Wmenu
CASE 1
        price = 75
CASE 2
        price = 150
CASE 3
        price = 300
CASE 4
        price = 750
CASE 5
        price = 1250
CASE 6
        price = 2500
CASE 7
        price = 5000
CASE 8
        price = 10000
CASE 9
        price = 15000
CASE 10
        price = 35000
END SELECT

Fade "I'll buy your `%" + w$ + " level" + STR$(wlev) + "`8 for`%$" + STR$(price) + " `7(y/N)"
q$ = ModemInputChar$
Linefeed 1
q$ = UCASE$(q$)
IF q$ = "Y" THEN
        mhand = mhand + price
        astr = astr - wlev * 10
        wlev = 0
END IF
GOTO Wmenu


Wlist:
SendFile "Wprice.ans", 1
AnsiLocate 4, 0
Send Center$(w$ + " LEV" + STR$(wlev))
AnsiLocate 20, 0
Pauze
GOTO Wmenu


END SUB

SUB WriteMail
SendCLS
SmartColor 15, 0
SendCR SPACE$(5) + "Write Mail"

Linefeed 1
SmartColor 8, 0
SendCR "Who would you like to write to? (FULL OR PARTIAL NAME)"

SmartColor 7, 0: Send SPACE$(5) + "(": SmartColor 15, 0: Send "Q": SmartColor 7, 0: Send ")": SmartColor 8, 0: SendCR "uit "
SmartColor 8, 0
Linefeed 1
ModemInput "> ", recp$, 7, 0, 20
IF recp$ = "" THEN GOTO notthere
IF recp$ = "Q" OR recp$ = "q" THEN GOTO notthere

SearchForName recp$
IF nob = TRUE THEN GOTO notthere

foundit:
SmartColor 8, 0
SendCR "Enter short message."
SmartColor 8, 0
ModemInput "> ", mesage$, 7, 0, 75
 IF LEN(mesage$) > 75 THEN SmartColor 15, 0: SendCR "The mail carrier is bored and walks away.": GOTO foundit
frm$ = nm$

from$ = frm$
Message$ = mesage$
recip$ = recp$
heading$ = nm$ + " sent you this:"
OPEN "mail.dat" FOR APPEND AS #1
        WRITE #1, recip$, from$, Message$, heading$
CLOSE
SmartColor 15, 0
SendCR "The mail carrier hurries to send your letter!"
notthere:
Pauze
END SUB

