FROM ubuntu

ENV JAVA_VERSION 1.7.0_72
ENV ZULU_BUILD 7.7.0.1
ENV ZULU_BUILD_DATE 2014-10-8.4
ENV ZULU_FULL_NAME zulu${JAVA_VERSION}-${ZULU_BUILD}-x86lx64

RUN  apt-get update && \
 apt-get install -y postgresql-9.3 curl unzip

RUN \
 (curl -e http://www.azulsystems.com/products/zulu/downloads\#Linux -o /tmp/jdk.zip http://cdn.azulsystems.com/zulu/${ZULU_BUILD_DATE}-bin/${ZULU_FULL_NAME}.zip &&\
    unzip -q /tmp/jdk.zip -d /opt &&\
    rm /tmp/jdk.zip) && \
 rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/lib/jvm && \
    ln -s /opt/${ZULU_FULL_NAME}  /usr/lib/jvm/default-java && \
    ln -s /usr/lib/jvm/default-java/bin/java /usr/bin/java

ENV JAVA_HOME /usr/lib/jvm/default-java
ENV PATH ${PATH}:${JAVA_HOME}/bin

#ant
RUN \
    curl -o /tmp/ant.tar.gz http://archive.apache.org/dist/ant/binaries/apache-ant-1.9.4-bin.tar.gz && \
    cd /tmp && \
    tar xvzf ant.tar.gz && \
    mv apache-ant-1.9.4 /usr/local && \
    ln -s /usr/local/apache-ant-1.9.4 /usr/local/ant && \
    ln -s /usr/local/ant/bin/ant /usr/local/bin/ant && \
    rm /tmp/ant.tar.gz
