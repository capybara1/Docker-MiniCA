# MiniCA

[![](https://images.microbadger.com/badges/version/capybara1/minica.svg)](https://microbadger.com/images/capybara1/minica "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/license/capybara1/minica.svg)](https://microbadger.com/images/capybara1/minica "Get your own license badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/capybara1/minica.svg)](https://microbadger.com/images/capybara1/minica "Get your own image badge on microbadger.com")

## Motivation

A docker image that provides [MiniCA](https://github.com/jsha/minica)

## Usage

### Command Line

Create executable file `/usr/local/bin/minca`

```sh
#!/bin/sh

set -eu

docker run --rm -v "$PWD:/output" capybara1/minica "$@"
```

## Features Added

The docker image provides additional features
in comparison with [MiniCA](https://github.com/jsha/minica):

| Version | Feature                                                               |
|---------|-----------------------------------------------------------------------|
| 1.1     | Added a `-force` parameter which allows replacement of existing files |
| 1.2     | Creates a `combined.pem` files containing certificate and key         |
