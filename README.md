# Docker image containing common cloud tools
This image's entrypoint is meant for running shell commands in docker containers only once and restart the container later with the same volume as to continue work.  Ideally used for any kind of initialisation. Could be overriden as needed.

CLI Tools included:
- docker
- docker-compose
- kubectl
- helm
- k3d
- kind

## Usage: directly via docker
```
docker run xertz/cloud-tools "echo hello" "echo world"
```

## Usage: via docker-compose
```
version: "3"

services:
  init:
    image: xertz/cloud-tools
    command:
      - echo hello
      - echo world
```
