FROM tomcat

ADD ./server.xml /usr/local/tomcat/conf/server.xml
ADD ./context.xml /usr/local/tomcat/conf/context.xml
ADD ./web.xml /tmp/web.xml

ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.3.0/wait /wait
RUN chmod 777 /wait

EXPOSE 8080

CMD cp -f /tmp/web.xml /usr/local/tomcat/webapps/sm/WEB-INF/web.xml &&  /wait && catalina.sh run