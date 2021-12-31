#!/bin/bash
echo "Frontend Deployment Activated"
aws s3 cp --recursive ../udagram-frontend/build s3://udagram-ta-udacity/