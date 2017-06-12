FROM alpine:3.6

RUN echo "Rethinkdb for Alpine Linux" &&\
	apk --no-cache add su-exec &&\
    apk --no-cache add --repository http://dl-3.alpinelinux.org/alpine/edge/testing rethinkdb &&\
	mkdir /data &&\
	chown daemon:daemon /data &&\
	apk info -v | sed "s/-r\d*$//g"|sed 's/\(.*\)-/\1 /' > /etc/manifest.txt

VOLUME ["/data"]

WORKDIR /data

ENTRYPOINT export RETHINKDB_CLUSTER_ADDR=$(nslookup ${RETHINKDB_SVC_NAME:=rethinkdb} 127.0.0.1 2>/dev/nul|awk '{print $3}'|egrep -v '(127.0.0.1|^$)'|sort|head -1);exec su-exec daemon:daemon rethinkdb --bind all -d /data -n ${HOSTNAME} --server-tag ${RETHINKDB_TAGS:=default} -j ${RETHINKDB_CLUSTER_ADDR:=rethinkdb:29015} --join-delay $((RANDOM%50+9)) --cluster-reconnect-timeout 600

#Ports:	process cluster webui
EXPOSE	28015 	29015 	8080
