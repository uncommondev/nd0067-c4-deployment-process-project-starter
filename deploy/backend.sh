#!/bin/bash
echo "Backend Deployment Activated"
cd ../udagram-api
eb init -r eu-west-2 udagram-api
eb deploy development