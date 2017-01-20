#!/usr/bin/env bash

set -ex

export NAME='Gotpl'

bin/gotpl test/hello.tmpl > test/hello.out

cat test/hello.out | grep  'Hello Gotpl!'
