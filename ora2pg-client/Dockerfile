FROM ubuntu:latest

MAINTAINER Adrian Riobo Lorenzo: adrian.riobo.lorenzo@gmail.com

COPY oracle/* /tmp/

COPY scripts/chkconfig /sbin/chkconfig

RUN apt-get update && apt-get install -y unzip alien libaio1 unixodbc wget perl-modules-5.22 make libdbi-perl bzip2 libstdc++5 bc &&\
    chmod 755 /sbin/chkconfig

ENV ORACLE_CLIENT_VERSION 11.2.0

RUN cd /tmp &&\
    unzip oracle-xe-11.2.0-1.0.x86_64.rpm.zip &&\
    cd Disk1 &&\
    alien --scripts -d oracle-xe-$ORACLE_CLIENT_VERSION-1.0.x86_64.rpm

RUN cd /tmp/Disk1 &&\
    dpkg -i oracle-xe_$ORACLE_CLIENT_VERSION-2_amd64.deb

ENV ORACLE_HOME=/u01/app/oracle/product/$ORACLE_CLIENT_VERSION/xe 
ENV ORACLE_SID=XE 
ENV NLS_LANG=$ORACLE_HOME/bin/nls_lang.sh 
ENV ORACLE_BASE=/u01/app/oracleexport 
ENV LD_LIBRARY_PATH=$ORACLE_HOME/lib 
ENV PATH=$ORACLE_HOME/bin:$PATH


ENV ORA2PG_VERSION 17.4

RUN wget https://sourceforge.net/projects/ora2pg/files/$ORA2PG_VERSION/ora2pg-$ORA2PG_VERSION.tar.bz2/download -O /tmp/ora2pg-$ORA2PG_VERSION.tar.bz2 &&\
    cd /tmp &&\
    tar jxf ora2pg-$ORA2PG_VERSION.tar.bz2 &&\
    cd ora2pg-$ORA2PG_VERSION &&\
    perl Makefile.PL &&\
    make && make install &&\
    cd /etc/ora2pg &&\
    cp ora2pg.conf.dist ora2pg.conf

ENV DBD_ORACLE_VERSION 1.74
    
RUN wget http://search.cpan.org/CPAN/authors/id/P/PY/PYTHIAN/DBD-Oracle-$DBD_ORACLE_VERSION.tar.gz -O /tmp/DBD-Oracle-$DBD_ORACLE_VERSION.tar.gz &&\
    cd /tmp &&\
    tar -xzvf DBD-Oracle-$DBD_ORACLE_VERSION.tar.gz &&\
    cd DBD-Oracle-$DBD_ORACLE_VERSION &&\
    perl Makefile.PL &&\
    make && make install

RUN rm -r /tmp/*

COPY configuration/ora2pg.conf /etc/ora2pg/ora2pg.conf

#ADD IMPORT INTO PG

#ENV DBD_PG_VERSION 3.5.3

#RUN wget http://search.cpan.org/CPAN/authors/id/T/TU/TURNSTEP/DBD-Pg-$DBD_PG_VERSION.tar.gz -O /tmp/DBD-Pg-$DBD_PG_VERSION.tar.gz &&\
#    cd /tmp &&\
#    tar -xzvf $DBD-Pg-DBD_PG_VERSION.tar.gz &&\
#    cd DBD-Pg-$DBD_PG_VERSION &&\
#    perl Makefile.PL &&\
#    make && make install
    
COPY run.sh /usr/local/bin/run.sh

ENTRYPOINT ["run.sh"]
