FROM ubuntu
LABEL project=Tomcat-Jenkins
MAINTAINER Harry
RUN apt-get update -y
RUN apt-get install default-jdk -y
RUN apt-get install wget -y
RUN TIMEZONE="America/Los_Angeles"    \
&& echo $TIMEZONE > /etc/timezone  \
&& echo $TIMEZONE > /etc/localtime
#RUN dpkg-reconfigure -f noninteractive tzdata
RUN apt-get install zip* -y
RUN ls -ltr

#WORKDIR /
RUN wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.31/bin/apache-tomcat-9.0.31.tar.gz
RUN tar -xvzf apache-tomcat-9.0.31.tar.gz
RUN ls -ltr
WORKDIR apache-tomcat-9.0.31/bin/webapps/
RUN ls -ltr
RUN wget http://updates.jenkins-ci.org/download/war/2.222/jenkins.war
RUN ls -ltr

#CMD ./configure --with-java=/usr/java
HEALTHCHECK     CMD --fail https:\\localhost:8080\ || exit 1
CMD ["sh", "/apache-tomcat-9.0.31/bin/catalina.sh", "run"]

