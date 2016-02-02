# shibboleth-jre7
Shibboleth Docker
docker run -ti --rm=true -p 8080:8080 -p 8443:8443 activedg/shibboleth-idp:3.2.1
docker build --rm=true -t activedg/shibboleth-idp:3.2.1 .


https://www.switch.ch/aai/guides/idp/installation/
docker run --rm --name=shibbolethdb -v /home/anoel/projects/docker/shibboleth/dbfiles:/docker-entrypoint-initdb.d --net=identity_net -p 3307:3306 -e MYSQL_ROOT_PASSWORD=password mysql/mysql-server
