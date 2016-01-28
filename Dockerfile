FROM tomcat:8.0.30-jre7
MAINTAINER "Amir Noel <amir@rimaleon.com>"

ENV IDP_SRC_DIR /usr/local/src/shibboleth-idp
ENV IDP_HOME /opt/shibboleth-idp

VOLUME ["$CATALINA_HOME/conf", "$IDP_HOME/conf"]

ADD tomcat-users.xml $CATALINA_HOME/conf/
ADD server.xml $CATALINA_HOME/conf/


ENV PATH $IDP_HOME/bin:$PATH
RUN mkdir -p "$IDP_SRC_DIR"
WORKDIR $IDP_SRC_DIR

RUN gpg --keyserver pool.sks-keyservers.net --recv-keys \
	DCAA15007BED9DE690CD9523378B845402277962 \
	272F5F0684CEA946E7967774A57B56F347905D15 \
	BBB1206FF0B91726AC0ECCDAA0B3CB09D2B37353 \
	3547A8A635FCFF630BDD72F457C5CCD598A1618C \
	F4FCEFBF07F9E397A9345B9D4D37705B61CB0B3F \
	5E6D6EAE16C3DA75450B219C9A804E97D7079C77 \
	796D70C89BBF8D958925F2ED277EC86A07CEEB8B \
	6519B5DB7C1C8340A954ED0073C937457D0A1B3D \
	71397D89D2F6CB065BDB2B96B150CCDE8DDA2C7D

ENV TOMCAT_KEY_ALIAS tomcat
ENV IDP_KEY_ALIAS idp
ENV IDP_VERSION 3.2.1
ENV IDP_TGZ_URL https://shibboleth.net/downloads/identity-provider/$IDP_VERSION/shibboleth-identity-provider-$IDP_VERSION.tar.gz

ADD install.properties "/tmp/install.properties"

# see https://wiki.shibboleth.net/confluence/display/SHIB2/IdPApacheTomcatPrepare
ADD idp.xml $CATALINA_HOME/conf/Catalina/localhost/idp.xml
ADD keystore.jks $CATALINA_HOME/conf/keystore.jks

# https://shibboleth.net/downloads/PGP_KEYS
RUN set -x \
	&& curl -fSL  "$IDP_TGZ_URL" -o shibboleth.tar.gz \
	&& curl -fSL  "$IDP_TGZ_URL.asc" -o shibboleth.tar.gz.asc \
	&& gpg --verify shibboleth.tar.gz.asc \
	&& tar -xvf shibboleth.tar.gz --strip-components=1 \
	&& bin/install.sh -Didp.target.dir=$IDP_HOME -Didp.property.file=/tmp/install.properties \
	&& rm shibboleth.tar.gz* \
	&& rm -rf IDP_SRC_DIR

        
EXPOSE 8080
EXPOSE 8443
CMD ["catalina.sh", "run"]
