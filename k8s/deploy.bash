#!/bin/bash

for file in $( ls *.yaml ); do
    echo "Applying $file"
    microk8s.kubectl apply -f $file
done
