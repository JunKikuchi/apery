FROM gcc:latest
COPY . /usr/src/apery
WORKDIR /usr/src/apery/src
RUN sed -i -e '/^CFLAGS/a CFLAGS  += -static' -e 's/^LDFLAGS.*$/LDFLAGS  = -Wl,--whole-archive -lpthread -Wl,--no-whole-archive/' ./Makefile
RUN make all
