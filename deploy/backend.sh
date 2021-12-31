#!/bin/bash
echo "Backend Deployment Activated"
cd ../udagram-api/www
eb init
eb deploy Archive.zip -e development