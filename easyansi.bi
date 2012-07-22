' EASYANSI.BI from Easy-Door V2.0. Included for backward compatibility only.

LF$ = CHR$(13) + CHR$(10)
IF AnsiFlag$ >= "1" THEN

        AnsiReset$ = "[0m"          ' Put all mode to off, reset
        Blink$ = "[5m"              ' Put in blinking mode
        Invert$ = "[7m"             ' Put in reverse video mode
        Bright$ = "[1m"             ' Put in high intensity mode (bright)
        Down$ = "[1B"               ' Cursor one line down
        Up$ = "[1A"                 ' Cursor one line up
        SavePos$ = "[s"             ' Save current cursor position
        RestorePos$ = "[u"          ' Restore cursor position
        EraseLine$ = "[K"           ' Erase current line

        Black$ = "[30m"             '
        Red$ = "[31m"               '
        Green$ = "[32m"             '
        Yellow$ = "[33m"            ' Foreground text color
        Blue$ = "[34m"              '
        Magenta$ = "[35m"           '
        Cyan$ = "[36m"              '
        White$ = "[37m"             '

        BlackBack$ = "[40m"         '
        RedBack$ = "[41m"           '
        GreenBack$ = "[42m"         '
        YellowBack$ = "[44m"        ' Background text color
        BlueBack$ = "[44m"          '
        MagentaBack$ = "[45m"       '
        CyanBack$ = "[46m"          '
        WhiteBack$ = "[47m"         '

END IF

