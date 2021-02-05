####Installing software ####
yum install epel-release -y 
yum install java -y  
yum install sudo which -y

####Installing  PG##########
yum install https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm -y
yum install postgresql11 -y; yum install postgresql11-server -y; yum install postgresql11-contrib.x86_64 -y
/usr/pgsql-11/bin/postgresql-11-setup initdb
systemctl enable postgresql-11
systemctl start postgresql-11 && systemctl status postgresql-11.service
yum install edb-edbr* -y
############################

### Now modify the postgresql.conf file
echo "wal_level = logical" >> /var/lib/pgsql/11/data/postgresql.conf
echo "listen_addresses = '*'" >> /var/lib/pgsql/11/data/postgresql.conf
echo "max_wal_senders = 20" >> /var/lib/pgsql/11/data/postgresql.conf
echo "max_replication_slots = 20" >> /var/lib/pgsql/11/data/postgresql.conf
echo "track_commit_timestamp = on" >> /var/lib/pgsql/11/data/postgresql.conf


###Changing pg_hba.conf file ...
sed -i '74,$s/ident/trust/' /var/lib/pgsql/11/data/pg_hba.conf
sed -i '74,$s/peer/trust/' /var/lib/pgsql/11/data/pg_hba.conf

### Modifying for all machine access in pg_hba.conf...
echo "host    all             all             0.0.0.0/0            trust" >> /var/lib/pgsql/11/data/pg_hba.conf
systemctl restart postgresql-11.service
