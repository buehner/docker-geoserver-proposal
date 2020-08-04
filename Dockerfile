ARG IMAGE_VERSION=9.0.37-jdk8-openjdk-slim

FROM tomcat:$IMAGE_VERSION

ARG GS_VERSION=2.17.2

WORKDIR /tmp

# install fonts, gdal and openssl
# also clear the initial webapps
RUN apt update && \
    apt install -y curl openssl zip gdal-bin fonts-cantarell lmodern \
    ttf-aenigma ttf-georgewilliams ttf-bitstream-vera ttf-sjfonts tv-fonts && \
    rm -rf $CATALINA_HOME/webapps/*

# install geoserver
RUN curl -jkSL -o /tmp/geoserver.zip http://downloads.sourceforge.net/project/geoserver/GeoServer/${GS_VERSION}/geoserver-${GS_VERSION}-war.zip
RUN unzip geoserver.zip geoserver.war -d $CATALINA_HOME/webapps
RUN mkdir -p $CATALINA_HOME/webapps/geoserver
RUN unzip -q $CATALINA_HOME/webapps/geoserver.war -d $CATALINA_HOME/webapps/geoserver
RUN rm $CATALINA_HOME/webapps/geoserver.war

