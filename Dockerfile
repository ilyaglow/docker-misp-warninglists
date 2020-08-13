FROM python:3-slim
LABEL mantainer "Ilya Glotov <ilya@ilyaglotov.com>"

ENV POETRY_VIRTUALENVS_CREATE=false

RUN apt-get update \
  && apt-get install -y git \
  && git clone --depth=1 --branch=main https://github.com/MISP/PyMISPWarningLists.git mwls \
  && cd mwls \
  && git submodule update --init --recursive \
  && pip install poetry \
  && poetry install --no-dev \
  && useradd app \
  && apt-get purge -y git

USER app

COPY search.py /mwls/search.py

VOLUME /data/iocs.txt

WORKDIR /mwls

ENTRYPOINT ["./search.py"]
