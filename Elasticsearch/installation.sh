#!/bin/bash

echo "Helm installation of elasticsearch and kibana"

helm upgrade --install elasticsearch . -f agrid-dev-internal-values.yaml --namespace alpha-logging --create-namespace  --set elasticsearch.enabled=true --render-subchart-notes

sleep 30

kubectl get pods -n alpha-logging

helm upgrade --install obs-kibana . -f agrid-dev-internal-values.yaml --namespace alpha-logging --create-namespace  --set kibana.enabled=true --render-subchart-notes

sleep 30

kubectl get pods -n alpha-logging
