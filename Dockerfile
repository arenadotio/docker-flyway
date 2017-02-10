#
# Flyway image with MsSQL Driver
#

FROM bandsintown/alpine:3.4

WORKDIR /flyway

ENV FLYWAY_VERSION=4.0.3 DOCKERIZE_VERSION=v0.2.0

# The MS link is obtained from the following page:
# https://msdn.microsoft.com/en-us/library/mt484311(v=sql.110).aspx
RUN apk-install openjdk8-jre \
  && wget https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/${FLYWAY_VERSION}/flyway-commandline-${FLYWAY_VERSION}.tar.gz \
  && tar -xzf flyway-commandline-${FLYWAY_VERSION}.tar.gz \
  && mv flyway-${FLYWAY_VERSION}/* . \
  && rm flyway-commandline-${FLYWAY_VERSION}.tar.gz \
  && ln -s /flyway/flyway /usr/local/bin/flyway \
  && wget https://download.microsoft.com/download/0/2/A/02AAE597-3865-456C-AE7F-613F99F850A8/enu/sqljdbc_6.0.8112.100_enu.tar.gz \
  && tar -xzf sqljdbc_6.0.8112.100_enu.tar.gz \
  && mv sqljdbc_6.0/enu/jre8/sqljdbc42.jar drivers \
  && wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && echo -ne "- with Flyway $FLYWAY_VERSION\n" >> /root/.built

CMD ["flyway", "--help"]
