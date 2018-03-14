#!/bin/bash

#--- grab args
[[ $# -eq 0 ]] && {
    # TODO: print help.
    echo -e "\n [-] $0 needs arguments!\n";
    exit 1;
}
while [[ $# -gt 0 ]]; do
    local key="$1"
    case $key in
        -d)
        DockerfileDir="$2"
        shift; shift
        ;;
        *)
        echo -e "\n [-] ERROR, unknown argument: $2\n"
        exit 1
    esac
done

DockerDir="${DockerfileDir}/ubuntus/hegea"
if [[ ! -f "${DockerDir}/Dockerfile" ]]; then
    echo -e "\n [-] ERROR: ${DockerfileDir}/Dockerfile doesn't exist!\n"
    echo -e "\n [!] ${DockerfileDir} must be the root path of the Git repository.\n"
    exit 1
fi

# install base image
docker build \
    -t $HOSTNAME/auger:hegea \
    --build-arg http_proxy=${http_proxy} \
    --build-arg UID_HOST=$UID \
    --build-arg GID_HOST=$GID \
    ${DockerDir}

#EOF
