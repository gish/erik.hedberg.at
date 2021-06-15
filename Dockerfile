FROM ubuntu:21.10

RUN apt-get update
RUN apt-get install -y \
    curl\
    cpio\
    pandoc

CMD ./build.sh
