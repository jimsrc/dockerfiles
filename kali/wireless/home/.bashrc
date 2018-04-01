# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022
COL1="\e[0m\e[31m"    #color de las lineas && fecha/hora
COLUSER="\e[31;1m"  # 31;1 --> red
COLHOST="\e[31;1m"  # 35;1 --> purple
COLPATH="\e[34;1m"  # 36;1 --> cyan                                                                                                       
COLDEFAULT="\e[0m"  # 0 --> normal (blanco?) 
PS1="$COL1[\[$COLUSER\]\u\[$COL1\]@\[$COLHOST\]\h\[$COL1\]|\[$COL1\]"'$fill \D{%d/%m} \t'"\[$COL1\]: \[$COLPATH\]\w\[$COL1\]]\n\[$COLDEFAULT\]"


# You may uncomment the following lines if you want `ls' to be colorized:
# export LS_OPTIONS='--color=auto'
# eval "`dircolors`"
# alias ls='ls $LS_OPTIONS'
# alias ll='ls $LS_OPTIONS -l'
# alias l='ls $LS_OPTIONS -lA'
#
# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
