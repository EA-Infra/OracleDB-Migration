#!/bin/bash
set -e

sudo -u oracle lsnrctl start
sudo -u oracle mkdir -p /u02/oradata

sudo -u oracle dbca -silent \
  -createDatabase \
  -templateName General_Purpose.dbc \
  -gdbname oratest1 \
  -sid oratest1 \
  -responseFile NO_VALUE \
  -characterSet AL32UTF8 \
  -sysPassword OraPasswd1 \
  -systemPassword OraPasswd1 \
  -createAsContainerDatabase false \
  -databaseType MULTIPURPOSE \
  -automaticMemoryManagement false \
  -storageType FS \
  -datafileDestination "/u02/oradata/" \
  -ignorePreReqs

echo "export ORACLE_SID=oratest1" | sudo tee -a ~oracle/.bashrc

cat << EOF | sudo tee /etc/init.d/dbora
#!/bin/sh
# chkconfig: 345 99 10
ORA_HOME=/u01/app/oracle/product/19.0.0/dbhome_1
ORA_OWNER=oracle

case "\$1" in
'start')
    su - \$ORA_OWNER -c "\$ORA_HOME/bin/dbstart \$ORA_HOME" &
    touch /var/lock/subsys/dbora
    ;;
'stop')
    su - \$ORA_OWNER -c "\$ORA_HOME/bin/dbshut \$ORA_HOME" &
    rm -f /var/lock/subsys/dbora
    ;;
esac
EOF

sudo chgrp dba /etc/init.d/dbora
sudo chmod 750 /etc/init.d/dbora

sudo ln -s /etc/init.d/dbora /etc/rc.d/rc0.d/K01dbora
sudo ln -s /etc/init.d/dbora /etc/rc.d/rc3.d/S99dbora
sudo ln -s /etc/init.d/dbora /etc/rc.d/rc5.d/S99dbora

sudo sed -i 's/:N/:Y/' /etc/oratab