#!/bin/bash

docker build . -f ./host_aben-ham_Dockerfile -t host_aben-ham
docker build . -f ./routeur_aben-ham_Dockerfile -t routeur_aben-ham