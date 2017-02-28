![rethinkdb](https://raw.githubusercontent.com/indiedotkim/devstrap/master/logos/RethinkDB-logo-thinker.png)
## Alpine linux based RethinkDB Docker image
# What is RethinkDB?

RethinkDB is an open-source, distributed database built to store JSON documents and effortlessly scale to multiple machines. It's easy to set up and learn and features a simple but powerful query language that supports table joins, groupings, aggregations, and functions.

# How to use this image
Start an instance with data mounted in the working directory

The default CMD of the image is ``rethinkdb --bind all -d /data -n ${HOSTNAME} --server-tag ${RETHINKDB_TAGS:=default} -j ${RETHINKDB_CLUSTER_ADDR:=rethinkdb:29015} --join-delay $((RANDOM%50+9)) --cluster-reconnect-timeout 600``.

The RethinkDB daemon will bind to all network interfaces available to the container (by default, RethinkDB only accepts connections from localhost), will have the same name as the container (very useful for troubleshooting purposes and consistency), will try to join a cluster (after a random period of time to avoid thundering herd problems) based on the address given on the ``RETHINKDB_CLUSTER_ADDR`` environment variable and fail if it can't join after 10 minutes.
All the environment variables used in this container have sensible defaults, but you can override them with values that are right for your environment.

# To run, just use
docker run -d mterron/rethinkdb

Happy rethinking!
![thinker-whale](http://imgur.com/bJXuQB1.png)
