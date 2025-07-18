#Requires AutoHotkey v2.0

; When this script is executed again, it will overwrite the previously loaded one
#SingleInstance Force

; === HOTSTRINGS ===
; Only expand hotstrings when providing the % char at the end
#Hotstring EndChars %
; Do not print the EndChar when expanding
#Hotstring O

::sgdu::
(
    Sehr geehrte Damen und Herren,

)

::hz::
(
    Hallo zusammen,

)

::mfg::
(
    Mit freundlichen Grüßen
    Malte Brunst
)

::lg::
(
    Liebe Grüße
    Malte
)

::vg::
(
    Viele Grüße
    Malte
)

::kr::
(
    Kind regards
    Malte
)

::vd::
(
    Vielen Dank!
)

::datetime::
{
    Send FormatTime(, "d.M.yyyy HH:mm:s")
}

::date::
{
    Send FormatTime(, "d.M.yyyy")
}

;==================================================
