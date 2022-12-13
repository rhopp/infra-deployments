#!/bin/bash


timeout --foreground 60s bash  <<- EOF
while [[ "$(oc get deployment/registration-service -n toolchain-host-operator -o jsonpath='{.status.conditions[?(@.type=="Available")].status}')" != "True" ]]; do 
	echo "Waiting for registration-service to be available again"
	sleep 2
done
EOF
if [ $? -ne 0 ]; then
	echo "Timed out waiting for registration-service to be available"
	exit 1
fi