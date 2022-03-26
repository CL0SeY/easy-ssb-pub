FROM node:stretch

RUN apt update
RUN apt upgrade -y

RUN apt install -y libleveldb-dev
RUN apt install -y curl libc6 libcurl3 zlib1g libtool autoconf

RUN mkdir -p /libsodium
RUN curl -L -o /tmp/libsodium.tar.gz https://github.com/jedisct1/libsodium/archive/refs/tags/1.0.18-RELEASE.tar.gz
RUN ls -l /tmp/ && cd /libsodium && tar zxvf /tmp/libsodium.tar.gz
RUN cd /libsodium/libsodium-1.0.18-RELEASE && ./configure && make && make check && make install

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json /usr/src/app/
RUN npm i --ignore-engines
COPY . /usr/src/app

EXPOSE 80
EXPOSE 8008
EXPOSE 8007

CMD npm start
