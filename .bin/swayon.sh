#!/bin/sh

XDG_SESSION_TYPE=wayland
XDG_CURRENT_DESKTOP=sway
XDG_CURRENT_SESSION=sway
LIBSEAT_BACKEND=logind
QT_QPA_PLATFORM=wayland
WINIT_UNIX_BACKEND=x11

export XDG_SESSION_TYPE
export XDG_CURRENT_DESKTOP
export XDG_CURRENT_SESSION
export LIBSEAT_BACKEND
export QT_QPA_PLATFORM
export WINIT_UNIX_BACKEND

sleep 1;
exec sway
