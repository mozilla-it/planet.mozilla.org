Planet
------

[![Netlify Status](https://api.netlify.com/api/v1/badges/87a58017-ee6f-43b5-bd0b-898bcd5642dd/deploy-status)](https://app.netlify.com/projects/planet-mozilla-it/deploys)

Planet is a flexible feed aggregator. It downloads news feeds published by
web sites and aggregates their content together into a single combined feed,
latest news first.  This version of Planet is named Venus as it is the
second major version.  The first version is still in wide use and is
also actively being maintained.

It uses Mark Pilgrim's Universal Feed Parser to read from CDF, RDF, RSS and
Atom feeds; Leonard Richardson's Beautiful Soup to correct markup issues;
and either Tomas Styblo's templating engine or Daniel Viellard's implementation
of XSLT to output static files in any format you can dream up.

To get started, check out the documentation in the docs directory.

------

The Dockerfile file in this repository is for local testing as this application is in python 2.7

Venus is a static file generator, what is pushed on the web are the static files from the `output` folder.

Generating the site locally
```bash
# Build the image
docker build --no-cache -t planet-mozilla .
# Get into the container
docker run --rm -it -v "$PWD":/app planet-mozilla
# Generate the static site
python planet.py configs/mozilla.ini
exit
```