# tac_plus-ng-docker
Docker Implementation of tac_plus-ng by MarcJHuber  https://github.com/MarcJHuber/event-driven-servers

# Overview
The overall goal of this repo is to provide the build environment for tac_plus-ng and then complile the current source code of the MarcJHuber repo noted above. After the compile is completed, a fresh container is built with only the required packages for the compiled binaries, =without all the extra packages required for the actual build/compile process. 

I based this on the Alpine image due to it's small footprint. At the time of this writing, the functional container with the compiled binaries is only around 50 MB in size. 

# Requirements
tac_plus-ng.cfg is required in your /config/ directory as this is what is called upon during container launch. 

# Building fresh image
1. Clone Repo into build directory
2. Issue `docker build -t strikerx22/tac_plus-ng-pro-bono -f Dockerfile .`

# Environmental Variables
No variables at this time

# Volumes
| Path in Container| Usage                                                         |
| ---------------- | ------------------------------------------------------------- |
| /config          |  Root folder that contains tac_plus-ng.cfg Configuration File |
| /logs            | Optional: I recommend this for simple single directory to store TACACS logs. Must be referenced in your .cfg |

# Usage
docker run \
-v /host-dir:/config \
-v /host-log-dir:/logs \
-p 49:49 \
--name:tac_plus-ng \ 
strikerx22
