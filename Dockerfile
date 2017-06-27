FROM ubuntu:16.04

RUN apt update && apt install imagemagick bash parallel inotify-tools -yq &&\
      apt clean &&\
      rm -rf /var/lib/apt/lists/*
# silence parallel warning to cite (credited in the README)
RUN mkdir -p $HOME/.parallel && touch $HOME/.parallel/will-cite
COPY ./textcleaner /usr/local/bin
COPY ./ct2p /usr/local/bin/
RUN mkdir -p /ct2p/incoming \
      mkdir -p /ct2p/processed
VOLUME /ct2p
ENTRYPOINT ["ct2p"]
