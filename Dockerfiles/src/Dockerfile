FROM tomcat

ADD ./server.xml /usr/local/tomcat/conf/server.xml
ADD ./encryption.key /usr/local/encryption.key
ADD ./applicationContext.properties /tmp/applicationContext.properties

ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.3.0/wait /wait
RUN chmod 777 /wait

EXPOSE 8080

CMD cp -f /tmp/applicationContext.properties /usr/local/tomcat/webapps/src/WEB-INF/classes/applicationContext.properties &&  /wait && catalina.sh run