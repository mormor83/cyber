#!/bin/bash

FILES="/tmp"
for f in $FILES/*.zip
do
    echo $f
    curl -usuperman:P@ssw0rd123$ -T $f "http://localhost:8081/artifactory/store-artifacts/$f"
done

