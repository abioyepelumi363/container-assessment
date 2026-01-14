#!/bin/bash
echo "Deleting Kubernetes Resources..."
kubectl delete namespace muchtodo-ns
echo "Cleanup Complete!"