#!/bin/bash

echo "Deleteing the kafka namespaces, and therefore all objects within (pods, services etc)"

kubectl delete ns kafka; kubectl delete ns test-kafka; kubectl delete pv --all;

sleep 3

[ -z "$1" ] && echo "First argument should be the the environment type to build" && exit 1

if [[ $1 != "dev" ]] && [[ $1 != 'prod' ]]; then
    echo "If you want to continue rebuilding the kafka environment please supply either dev or prod as the first argument" && exit 1
fi

~/k8s-kafka-single-node/build-kafka.sh $1