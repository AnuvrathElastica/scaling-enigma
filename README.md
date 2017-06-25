# scaling-enigma
MGW and Docker Container colocated solution
Scripts and Solution to monitor mobile gateways co-located.

Status: 6/26/17
    websvr => Needs certification
    redis => Currently from open source needs to point to elastica/redis at somepoint
    monitor => Needs codereview and ut development is all done.
    healthcheck => Docker container health check needs to be implemented.

    The instance where the deployment is complete is on
    eoe-pdx-mobile-gateway-0d098679acbd10d4a

    cd scaling-enigma 
    sudo docker-compose ps
    sudo docker-compose stop 
    sudo docker-compose rm 
    sudo docker-compose up -d
    sudo docker-compose logs -f

    The Jenkins instance used was infra-build-ubuntu-08ce873608c37e41f



