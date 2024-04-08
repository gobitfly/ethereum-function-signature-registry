# Ethereum Function Signature Database

This project is meant to be a resource for mapping the 4-byte function
selectors used by the EVM back to a list of known canonical function signatures
that will generate those 4-byte selectors.

The project currently consists of two primary components:

1. Current website located at [https://www.4byte.directory/](https://www.4byte.directory/).
2. An Ethereum smart contract that houses the signature data. (This portion is
   a work in progress and is not yet live).


## Running the tests

> Note: This project is only supported under Python3.  If it works in Python2.x that is purely coincidental.

First install the relevant system dependencies.

* OSX: `brew install pkg-config libffi autoconf automake libtool openssl postgres`
* Linux: `sudo apt-get install libssl-dev postgresql postgresql-contrib`

There are two primary test suites located under the [`./tests/`](./tests/)
directory.

* [`./tests/web/`](./tests/web/): contains all of the tests for the website.
* [`./tests/contracts/`](./tests/contracts/): contains all of the tests for the
  smart contracts.

First you will need to install the requirements.

```bash
$ pip install -r requirements.txt -r requirements-dev.txt
```

To run the full test suite:

```bash
$ tox
```

To run the individual tests suites.

```bash
$ py.test tests/web
$ py.test tests/contracts
```

## Serve the site on a development machine

To serve the site on a development machine, bypassing several security measures, run:

```bash
python manage.py runserver --settings func_sig_registry.settings_dev
```

## Usage via docker compose

Install docker compose (tested with v2.25.0)

Then run `docker compose up`. This will start the server in development mode which you can view at http://localhost:8000/.
