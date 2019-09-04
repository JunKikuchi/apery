FROM gcc:latest

COPY . /usr/src/apery
WORKDIR /usr/src/apery/src
RUN sed -i -e '/^CFLAGS/a CFLAGS  += -static' -e 's/^LDFLAGS.*$/LDFLAGS  = -Wl,--whole-archive -lpthread -Wl,--no-whole-archive/' ./Makefile \
  && make all \
  && cp apery ../bin

WORKDIR /usr/src
RUN curl -L -O https://github.com/HiraokaTakuya/apery/releases/download/WCSC28/apery_wcsc28.zip \
  && unzip apery_wcsc28.zip \
  && rm apery_wcsc28.zip \
  && mkdir -p /usr/src/apery/bin/book/20180505 \
  && cp apery_wcsc28/bin/book/20180505/book.bin /usr/src/apery/bin/book/20180505
RUN curl -L -O https://bitbucket.org/hiraoka64/apery-evaluation-binaries-2019-06-17/get/c587e811c227.zip \
  && unzip c587e811c227.zip \
  && rm c587e811c227.zip \
  && mkdir -p /usr/src/apery/bin/eval/20190617 \
  && cp hiraoka64-apery-evaluation-binaries-2019-06-17-c587e811c227/*.bin /usr/src/apery/bin/eval/20190617

FROM alpine:latest
COPY --from=0 /usr/src/apery/bin /usr/local/apery/bin
WORKDIR /usr/local/apery/bin
ENTRYPOINT ["./apery"]
