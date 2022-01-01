#!/bin/bash
echo "Frontend Deployment Activated"
aws s3 cp --recursive ../udagram-frontend/www s3://udagram-ta-udacity/