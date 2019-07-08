FROM python:3-alpine
LABEL mantainer "Ilya Glotov <ilya@ilyaglotov.com>"

RUN apk --no-cache add git \
  && git clone --depth=1 --branch=master https://github.com/MISP/PyMISPWarningLists.git mwls \
  && cd mwls \
  && git submodule update --init --recursive \
  && pip install pipenv \
  && pipenv install -d . \
  && adduser -D app

COPY search.py /mwls/search.py

USER app

VOLUME /data/iocs.txt

WORKDIR /mwls

ENTRYPOINT ["./search.py"]
