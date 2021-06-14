FROM ubuntu:21.10

RUN apt-get update
RUN apt-get install -y \
    curl\
    cpio\
    perl\
    libdigest-md5-file-perl

WORKDIR /usr/bin
RUN curl -s https://rgz.ee/bin/ssg6 > ssg6
RUN curl -s https://rgz.ee/bin/Markdown.pl > Markdown.pl && chmod +x ssg6 Markdown.pl

CMD ./build.sh