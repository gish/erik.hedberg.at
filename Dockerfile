FROM ubuntu:21.10

RUN apt-get update
RUN apt-get install -y \
    curl\
    cpio\
    pandoc

COPY bin/ssg6 /usr/local/bin/ssg6
RUN chmod +x /usr/local/bin/ssg6

CMD ./build.sh
