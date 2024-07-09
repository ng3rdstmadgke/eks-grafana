#!/bin/bash
# ポートは ローカル:リモート
kubectl port-forward svc/grafana -n grafana-prd 8888:80