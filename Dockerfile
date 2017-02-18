#
# ref: https://github.com/davidshen84/docker-scikit-learn
# ref: https://github.com/davidshen84/docker-jupyter

#FROM openkbs/jre-mvn-py3
FROM python:3.5
MAINTAINER DrSnowbird

RUN pip3 install --upgrade pyzmq --install-option="--zmq=bundled" && \
    pip3 install --upgrade jupyter

RUN apt-get update && apt-get install -y \
    build-essential \
    gfortran \
    libblas-dev \
    liblapack-dev \
    libxft-dev \
    && rm -rf /var/lib/apt/lists/*

# order matters
RUN pip3 install --upgrade \
    numpy \
    scipy \
    scikit-learn \
    matplotlib \
    pandas

# Add VOLUMEs to allow backup
#VOLUME /notebook
VOLUME  ["/notebook", "/data"]

WORKDIR /notebook

EXPOSE 8888

ENTRYPOINT jupyter notebook --ip=0.0.0.0 --no-browser
#ENTRYPOINT ["jupyter notebook", "--ip", "0.0.0.0", "--no-browser"]
