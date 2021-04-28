FROM rust:1.51.0

WORKDIR /app/

RUN apt-get update
RUN sh -c "echo 'deb http://deb.debian.org/debian buster-backports main contrib non-free' > /etc/apt/sources.list.d/buster-backports.list"
RUN apt update
RUN apt-get install wireguard vim net-tools software-properties-common -y

ADD ./Cargo* /app/

RUN cd /app/ && mkdir src

ADD ./src/ /app/src/
ADD ./ci/ /app/ci/
ADD ./benches/ /app/benches/

RUN ls src/
RUN ls src/crypto/
RUN ls src/ffi/
RUN ls src/noise/
RUN cargo build
ADD ./clean_and_run.sh /app/clean_and_run.sh
RUN chmod +x /app/clean_and_run.sh 


# docker build -t boringtundocker .
# docker run -it --cap-add=NET_ADMIN --net=host boringtundocker /bin/bash

