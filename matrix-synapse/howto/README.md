# Matrix-Synapse
![Network Map of Matrix-Synapse behind Traefik](matrix-telegram-docker.svg)

Matrix synapse has to be started once with the "generate"-command. Run this from your /path/to/my/mydatafolder/matrix-synapse.

``
  docker run -it --rm \<br>
    -v $PWD/data:/data \<br>
    -e SYNAPSE_SERVER_NAME=your.domain.name \<br>
    -e SYNAPSE_REPORT_STATS=yes \<br>
    matrixdotorg/synapse:latest generate
``
