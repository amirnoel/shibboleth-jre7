# shibboleth-jre7
Shibboleth Docker
docker build --rm=true -t activedg/shibboleth-idp:3.2.1 .
docker network create --driver bridge identity_net
docker run --name=shibblethdata --net=identity_net -p 8080:8080 -p 8443:8443 activedg/shibboleth-idp:3.2.1 /bin/echo "Docker Data Volume"
docker run -d --name=shibbolethldap --net=identity_net -p 389:389 larrycai/openldap
docker run -ti --rm=true --volumes-from=shibbolethdata --net=identity_net -p 8080:8080 -p 8443:8443 activedg/shibboleth-idp:3.2.1

http://www.cybera.ca/news-and-events/tech-radar/getting-started-on-shibboleth/

https://www.switch.ch/aai/guides/idp/installation/
