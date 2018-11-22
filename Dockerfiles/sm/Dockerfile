FROM centos

ARG SM_INSTALL_DIR
ENV SM_INSTALL_DIR=${SM_INSTALL_DIR}

RUN yum install -y libaio.i686 glibc.i686 libgcc.i686

### Install Oracle Client
ADD ./oracle/oracle-instantclient*.rpm /tmp/
RUN yum -y localinstall /tmp/oracle* --nogpgcheck && \
     rm -rf /var/cache/yum && \
     rm -f /tmp/oracle-instantclient*.rpm
RUN mkdir /usr/lib/oracle/12.2/client/network/admin -p
COPY ./oracle/tnsnames.ora /usr/lib/oracle/12.2/client/network/admin/tnsnames.ora
COPY ./oracle/sqlnet.ora /usr/lib/oracle/12.2/client/network/admin/sqlnet.ora
ENV ORACLE_HOME=/usr/lib/oracle/12.2/client
ENV PATH=$PATH:$ORACLE_HOME/bin
ENV LD_LIBRARY_PATH=$ORACLE_HOME/lib
ENV TNS_ADMIN=$ORACLE_HOME/network/admin


### Install Oracle JRE
ADD ./jre/jre-*.rpm /tmp/
RUN yum install -y localinstall /tmp/jre-* --nogpgcheck && \
     rm -rf /var/cache/yum && \
     rm -f /tmp/jre-*.rpm
ENV JAVA_HOME=/usr/java/latest


### SM Server
RUN useradd sm
RUN echo "export ORACLE_HOME=/usr/lib/oracle/12.2/client" >>/home/sm/.bash_profile
RUN echo "export LD_LIBRARY_PATH=$ORACLE_HOME/lib" >>/home/sm/.bash_profile
RUN echo "export TNS_ADMIN=$ORACLE_HOME/network/admin" >>/home/sm/.bash_profile
RUN echo "export JAVA_HOME=/usr/java/latest" >>/home/sm/.bash_profile

ADD ./SM/setupLinux*.bin /tmp/setupLinux.bin
RUN /tmp/setupLinux.bin -i silent -DUSER_INSTALL_DIR=${SM_INSTALL_DIR} && \
     rm -f /tmp/setupLinux.bin
ADD ./SM/sm.ini ${SM_INSTALL_DIR}/RUN/sm.ini
ADD ./SM/LicFile.txt ${SM_INSTALL_DIR}/RUN/LicFile.txt
RUN chown -R sm ${SM_INSTALL_DIR}
RUN ${SM_INSTALL_DIR}/RUN/setupLinks.sh jre

## Apply SM Patch file
ADD ./SM/patch/HPSM*.tar /tmp/smpatch
RUN tar xf /tmp/smpatch/sm*.tar -C /tmp/smpatch
RUN chown -R sm /tmp/smpatch
RUN mkdir /tmp/smbkp && chmod 777 /tmp/smbkp && chown -R sm /tmp/smbkp

## Add the wait script to the image
ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.3.0/wait /wait
RUN chmod 777 /wait

ADD ./SM/smstart.sh /tmp/smstarttmp.sh
RUN  tr -d '\r' </tmp/smstarttmp.sh >/tmp/smstart.sh && \
	 rm -f /tmp/smstarttmp.sh
RUN chmod 777 /tmp/smstart.sh

USER sm
RUN mkdir ${SM_INSTALL_DIR}/Reports

EXPOSE 13080

CMD /wait && /tmp/smstart.sh && /bin/bash
#CMD /bin/bash