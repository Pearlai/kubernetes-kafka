#!/bin/bash

echo "Deleteing the kafka namespaces, and therefore all objects within (pods, services etc)"

kubectl delete ns kafka; kubectl delete ns test-kafka; kubectl delete pv --all;

sleep 3

[ -z "$1" ] && echo "First argument should be the the environment type to build. Exiting." && exit 1

if [[ $1 != "dev" ]] && [[ $1 != 'prod' ]]; then
    echo "To continue rebuilding the kafka environment please supply either dev or prod as the first argument. Exiting." && exit 1
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

$DIR/build-kafka.sh $1