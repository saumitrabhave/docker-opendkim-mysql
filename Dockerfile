FROM alpine:3.8
COPY packages /opt/data
RUN apk add --update alpine-sdk libmilter-dev ldns-dev libevent-dev lua5.1-dev mariadb-dev readline-dev ncurses-dev curl-dev jansson-dev db-dev && \
cd /opt/data  && \
tar -xvf opendbx-1.4.6.tar.gz  && \ 
cd opendbx-1.4.6/  && \
CPPFLAGS="-I/usr/include/mysql" ./configure --with-backends="mysql"  && \
make install  && \
cd /opt/data  && \
tar -xvf opendkim-2.10.3.tar.gz  && \
cd opendkim-2.10.3  && \
./configure --with-db --with-ldns --with-libcurl --with-libevent --with-libjansson --with-lua --with-milter --with-odbx --with-openssl --with-sql-backend --enable-filter --enable-poll --enable-query_cache  && \
make  && \
make install  && \
apk del alpine-sdk