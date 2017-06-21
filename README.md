# LPP custom teamcity image

This image is derived from our [base image](https://hub.docker.com/r/jeandet/teamcity-docker-minimal-agent/). It is based on Fedora and OpenJDK.
It has been designed to work either as standalone docker agent or with [TeamcityDockerCloudPlugin](https://github.com/JeanRev/TeamcityDockerCloudPlugin).

You can pull the ready-to-use image from the Docker Hub repository
                                     
`docker pull jeandet/teamcity-docker-complete-agent`

You can also make your own image derived from this one with more tools, to do so just make an new Dokerfile and base your image on this one. You might also expose some agent parameters for automatic job dispatching based on build requierements.

** Sample Dockerfile with gcc added**

```Dockerfile
FROM jeandet/teamcity-docker-minimal-agent
LABEL maintainer "Alexis Jeandet <alexis.jeandet@member.fsf.org>"

RUN dnf install -y gcc

RUN echo "system.has_gcc=true" >> /opt/buildagent/conf/buildAgent.dist.properties 

CMD ["/run-services.sh"]
```

To start the container manually just remember to set TC server URL var:

```
docker run -it -e SERVER_URL="<url to TeamCity server>"  \ 
    -v <path to agent config folder>:/data/teamcity_agent/conf  \
    jeandet/teamcity-docker-complete-agent
```
