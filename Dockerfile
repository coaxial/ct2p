FROM ubuntu:16.04

RUN apt update && apt install imagemagick bash parallel inotify-tools -yq
# silence parallel warning to cite (credited in the README)
RUN echo "will cite" | parallel --bibtex
COPY ./textcleaner /usr/local/bin
COPY ./ct2p /usr/local/bin/
RUN mkdir -p /ct2p/incoming \
      mkdir -p /ct2p/processed
VOLUME /ct2p
ENTRYPOINT ["ct2p"]
