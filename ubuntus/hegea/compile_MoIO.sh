#!/bin/bash

function recompile_code(){
    cd $HOME/CDAS/MoIO/v5r6/cmt    # source dir
    # repeat what's in my .bashrc
    . $HOME/root_auger/root/bin/thisroot.sh
    export CDASVERSION=$(basename $CDAS/version_cdas-*.tgz .tgz | sed -e 's/version_cdas-//' | sed -e 's/p[0-9]//')
    export CMTVERSION=$(basename $CDAS/CMT/*)
    export CMTROOT=$CDAS/CMT/$CMTVERSION
    export CMTINSTALLAREA=$CDAS/
    . ${CMTROOT}/mgr/setup.sh
    . $CDAS/Work/$CDASVERSION/cmt/cdas.sh
    export CMTPATH=$CDAS/:$CDAS/IoFd:$CMTPATH:$HOME

    # clean && compile
    echo -e "\n [*] make clean\n"
    make clean || return 1
    echo -e "\n [*] cmt config\n"
    cmt config || return 1
    echo -e "\n [*] make\n"
    make \
        || return 1 \
        && echo -e "\n [+] code to read monitoring data re-compiled OK! :D\n"
    cd -
}

recompile_code

#EOF
