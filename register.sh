#!/usr/bin/env bash

/usr/bin/subscription-manager identity > /dev/null
if [ $? -ne 0 ]; then
    /usr/bin/subscription-manager register --username $1 --password $2 --auto-attach 
fi;
