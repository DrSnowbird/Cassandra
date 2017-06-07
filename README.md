# cassandra

[![](https://imagelayers.io/badge/openkbs/cassandra:latest.svg)](https://imagelayers.io/?images=openkbs/cassandra:latest 'Get your own badge on imagelayers.io')

##Components:
- ref: https://github.com/davidshen84/docker-cassandra-learn
- ref: https://github.com/davidshen84/docker-jupyter

## Pull the image from Docker Repository

```bash
docker pull openkbs/cassandra
```
## Login password (from jupyter screen)
Token authentication is enabled. You need to open the notebook server with its first-time login token in the URL, or enable a password in order to gain access. The command:
```
jupyter notebook list
```
will show you the URLs of running servers with their tokens, which you can copy and paste into your browser. For example:
```
Currently running servers:
http://localhost:8888/?token=c8de56fa... :: /Users/you/notebooks
```
Or you can paste just the token value into the password field on this page.

Cookies are required for authenticated access to notebooks.


## Connect to cassandra Docker
host/port=> 0.0.0.0:18888 
login/passwd=> (see above)

## Base the image to build add-on components

```Dockerfile
FROM openkbs/cassandra
```

## Run the image

Then, you're ready to run:
- make sure you create your work directory, e.g., ./data

```bash
mkdir ./data
docker run -d --name my-cassandra -p 18888:8888 openkbs/cassandra
```

## Build and Run your own image
Say, you will build the image "my/cassandra".

```bash
docker build -t my/cassandra .
```

To run your own image, say, with some-cassandra:

```bash
mkdir ./data
docker run -d --name some-cassandra -p 18888:88882 my/cassandra
```

## Shell into the Docker instance

```bash
docker exec -it some-cassandra /bin/bash
```


