docker build -t jeandet/teamcity-docker-complete-agent .
docker run -d=true -e SERVER_URL=https://hephaistos.lpp.polytechnique.fr/teamcity --name=teamcity-docker-complete-agent -it jeandet/teamcity-docker-complete-agent &
sleep 300
docker stop teamcity-docker-complete-agent
docker commit teamcity-docker-complete-agent jeandet/teamcity-docker-complete-agent
docker rm teamcity-docker-complete-agent
