# Udagram

## Application Link

[Link to the application](http://udagram-ta-udacity.s3-website.eu-west-2.amazonaws.com/home)

## High-Level Overview

![Architecture Diagram](/DIAGRAMS/HIGH_LEVEL.png)

This fullstack application leverages S3, Elastic Beanstalk and RDS. 

The overview of how it works is the following:

1. The user connects to the Frontend which is hosted in an S3 Bucket. The frontend consists of an Angular application using the Ionic framework.
2. The frontend connects to an Express API in the backend which is hosted on an EC2 instance, provisioned by Elastic Beanstalk.
3. The backend server is connected to a PostgreSQL database hosted on RDS.
4. The images uploaded by the user are hosted in a separate media bucket 

## Pipeline

There is a CI/CD pipeline in place hosted on Circle CI. Full instructions on the pipeline steps can be found in the `DOCUMENTATION` folder.

![Pipeline](/DIAGRAMS/PIPELINE.png)

## Infrastructure Setup

All steps on how to provision and setup the infrastructure have been detailed with photos and step-by-step instructions in the `DOCUMENTATION` folder.