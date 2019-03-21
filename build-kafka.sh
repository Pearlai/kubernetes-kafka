#!/bin/bash

SLEEP=10

[ -z "$1" ] && echo "First argument should be the the environment type to build" && exit 1

if [[ $1 != "dev" ]] && [[ $1 != 'prod' ]]; then
    echo "Please supply either dev or prod as the first argument" && exit 1
fi

function getTimer {
    TIME=`date +%s`
    START=`date -d @$TIME +%T`
    TIME=$((TIME+10))
    END=`date -d @$TIME +%T`
    echo "#### Sleeping for $SLEEP seconds"
    echo "#### $START - $END"
    sleep $SLEEP
}

echo "## Applying namespaces"
kubectl apply -f 00-namespace.yml; kubectl apply -f 01-test-namespace.yml;
echo "## Applying Zookeeper ${$1}"
kubectl apply -f zookeeper/$1
SLEEP=30
getTimer
echo "## Applying Kafka ${$1}"
kubectl apply -f kafka/$1
SLEEP=20
getTimer
echo "## Applying Avro ${$1}"
kubectl apply -f avro-tools/$1
SLEEP=5
getTimer
echo "## Applying Ubuntu Curl ${$1}"
kubectl apply -f utils-pod/ubuntu.yaml