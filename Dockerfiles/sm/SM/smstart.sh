### Create logs folder
[ ! -d "${SM_INSTALL_DIR}/logs" ] && mkdir "${SM_INSTALL_DIR}/logs"
touch ${SM_INSTALL_DIR}/logs/install.log

### Verify DB Connection
${SM_INSTALL_DIR}/RUN/sm -sqlverifyconnection
[ $? -ne 0 ] && echo "DB Connection failed! Check the DB container is running!" && exit 1

### CHeck if data is already loaded
output=`sqlplus -s ${DB_USER}/${DB_PASSWORD}@SMDB <<EOF
SELECT COUNT(*) FROM DBDICTM1;
quit
EOF`
rc=`echo $output|grep -c ERROR`

### Load data if DB is empty
[ $rc -ne 0 ] && ${SM_INSTALL_DIR}/RUN/sm -system_load -system_directory:${SM_INSTALL_DIR}/data -log:${SM_INSTALL_DIR}/logs/install.log

### Apply SM Patch
if [ ${APPLY_SM_PATCH} = "true" ]; then
${SM_INSTALL_DIR}/RUN/sm -shutipc -log:${SM_INSTALL_DIR}/logs/install.log
/tmp/smpatch/PatchSetup.sh <<EOF
${SM_INSTALL_DIR}
/tmp/smbkp
EOF
rm -rf /tmp/smbkp && rm -rf /tmp/smpatch
${SM_INSTALL_DIR}/RUN/sm -unlockdatabase -log:${SM_INSTALL_DIR}/logs/install.log
fi

### Start SM Server
${SM_INSTALL_DIR}/RUN/smstart
cd ${SM_INSTALL_DIR}
echo "Service Manager Started!"