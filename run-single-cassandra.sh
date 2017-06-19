#!/bin/bash -x
docker run -d --name cass1 cassandra start
#docker run -d --name cass2 --link cass1:seed cassandra start seed
#docker run -d --name cass3 --link cass1:seed cassandra start seed
