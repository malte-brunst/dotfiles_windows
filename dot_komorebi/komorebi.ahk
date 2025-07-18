#Requires AutoHotkey v2.0

#SingleInstance Force

Komorebic(cmd) {
    RunWait(format("komorebic.exe {}", cmd), , "Hide")
}

!q:: Komorebic("close")
!+-:: Komorebic("minimize")

; Focus windows
!h:: Komorebic("focus left")
!j:: Komorebic("focus down")
!k:: Komorebic("focus up")
!l:: Komorebic("focus right")

!+m:: Komorebic("cycle-focus previous")
!+,:: Komorebic("cycle-focus next")

; Move windows
!+h:: Komorebic("move left")
!+j:: Komorebic("move down")
!+k:: Komorebic("move up")
!+l:: Komorebic("move right")

; Stack windows
!Left:: Komorebic("stack left")
!Down:: Komorebic("stack down")
!Up:: Komorebic("stack up")
!Right:: Komorebic("stack right")
!;:: Komorebic("unstack")
!+Down:: Komorebic("unstack-all")
!+Up:: Komorebic("stack-all")
!m:: Komorebic("cycle-stack previous")
!,:: Komorebic("cycle-stack next")

; Resize
!=:: Komorebic("resize-axis horizontal increase")
!-:: Komorebic("resize-axis horizontal decrease")
!+=:: Komorebic("resize-axis vertical increase")
!+_:: Komorebic("resize-axis vertical decrease")

; Manipulate windows
!g:: Komorebic("toggle-monocle")
!+g:: Komorebic("toggle-float")

; Window manager options
!+r:: Komorebic("retile")
!p:: Komorebic("toggle-pause")

; Layouts
!x:: Komorebic("flip-layout horizontal")
!y:: Komorebic("flip-layout vertical")

; Workspaces
!a:: Komorebic("focus-workspace 0")
!s:: Komorebic("focus-workspace 1")
!d:: Komorebic("focus-workspace 2")
!f:: Komorebic("focus-workspace 3")

; Move windows across workspaces
!+a:: Komorebic("move-to-workspace 0")
!+s:: Komorebic("move-to-workspace 1")
!+d:: Komorebic("move-to-workspace 2")
!+f:: Komorebic("move-to-workspace 3")

; Windows
!+1:: Komorebic("focus-monitor-workspace 0")
!+2:: Komorebic("focus-monitor-workspace 1")
