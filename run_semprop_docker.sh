#!/bin/bash

set -x

docker run --rm -i -v `pwd`:/code_readonly/ -w /code_readonly/ --entrypoint=/bin/bash --env="PYTHONPATH=/code/" matchmaker2021sigmod/sempropenv -c "./entrypoint.sh \"$1\""
