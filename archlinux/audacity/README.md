## Audacity 

Tested ok in a Arch host:

    docker build -t arch/audacity:v1 <Dockerfile-Dir>

    docker run --rm -d --name audacity \
        -u $UID:$GID \
        -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
        -v /dev/snd:/dev/snd \
        -e DISPLAY="unix$DISPLAY" \
        -e PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native \
        -v ${XDG_RUNTIME_DIR}/pulse/native:${XDG_RUNTIME_DIR}/pulse/native \
        --group-add=audio \
        -v /dev/shm:/dev/shm \
        --cap-add=SYS_ADMIN \
        arch/audacity:v1 \
        audacity

<!--- EOF -->
