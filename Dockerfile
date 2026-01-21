FROM python:2.7-slim

# ------------------------------------------------------------
# Fix EOL Debian buster APT sources
# ------------------------------------------------------------
RUN set -eux; \
  sed -i -e 's|deb.debian.org|archive.debian.org|g' \
         -e 's|security.debian.org|archive.debian.org|g' /etc/apt/sources.list; \
  printf 'Acquire::Check-Valid-Until "false";\n' > /etc/apt/apt.conf.d/99no-check-valid-until; \
  apt-get -o Acquire::Check-Valid-Until=false update

# ------------------------------------------------------------
# System + Python 2 bindings needed by Venus tests
# ------------------------------------------------------------
RUN apt-get install -y --no-install-recommends \
      build-essential \
      curl git ca-certificates \
      libxml2-dev libxslt1-dev libz-dev \
      libssl1.1 libffi-dev \
      xsltproc \
      python-libxml2 \
      python-librdf \
      # (these are usually pulled in, but installing explicitly avoids edge cases)
      librdf0 raptor2-utils librasqal3 \
  && rm -rf /var/lib/apt/lists/*

# ------------------------------------------------------------
# Make Debian "dist-packages" visible to /usr/local/bin/python
# ------------------------------------------------------------
ENV PYTHONPATH=/usr/lib/python2.7/dist-packages:/usr/lib/python2.7/site-packages

# ------------------------------------------------------------
# Bootstrap pip (last version supporting Python 2)
# ------------------------------------------------------------
RUN curl -sS https://bootstrap.pypa.io/pip/2.7/get-pip.py -o /tmp/get-pip.py \
  && python /tmp/get-pip.py \
  && pip install --no-cache-dir "pip==20.3.4" \
  && rm /tmp/get-pip.py

# ------------------------------------------------------------
# Python packages for optional Venus filters/tests
# ------------------------------------------------------------
RUN pip install --no-cache-dir \
      "Django<2" \
      "Genshi"

# ------------------------------------------------------------
# App setup
# ------------------------------------------------------------
WORKDIR /app
COPY . /app

# Install project requirements if present (best-effort)
RUN if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt || true; fi

CMD ["bash"]
