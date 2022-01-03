# Pipeline Documentation

## Circle CI

The pipeline has been deployed via Circle CI. The purpose of the pipeline is to automate all the manual steps required when building the Udagram application.

![Pipeline Image](/SCREENSHOTS/PIPELINE.png)

Above is a screenshot showing the pipeline

## Pipeline Steps

The pipeline consists of several steps which ultimately lead to the application being fully deployed on AWS:

1. "Spin up environment" and "Preparing environment variables": these two steps are automatically handled for us by Circle CI. They prepare the Docker image that will be executing our pipeline steps. To keep compliant, the pipeline uses environment variables to secure sensitive information such as AWS keys
2. Checkout code: checks out the application code from GitHub
3. Install AWS CLI: Uses an "Orb" by Circle CI which sets up an AWS CLI which we will be using later in the pipeline
4. Configure AWS Access Key ID: Sets up the AWS CLI with the Access and Secret key provided by the environment variables
5. Setting Up Elastic Beanstalk CLI: Configures the EB CLI for us which we will use to deploy the backend API
6. Install Node.js: Installs Node.js for us to run the commands from the parent package.json file
7. Install Google Chrome: To run the frontend unit tests, Chrome is required
8. Set Environment Variables: Sets the environment variables for Elastic Beanstalk by pulling the values from the environment variables set in Circle CI
9. Install node modules (API): this step runs "npm i" in the udagram-api folder to download and install all the required packages
10. Build API: Once the packages have been installed, the API is then built
11. Deploy API: If the build is successful then the next step in the pipeline is to deploy it to Elastic Beanstalk (making good use of the EB CLI we configured earlier)
12. Install node modules (Frontend): Downloads and installs the required packages for the frontend application
13. Test Frontend: Runs the unit tests configured for the frontend
14. Build Frontend: If the unit tests are successful then the front is built
15. Deploy Frontend: If the build was successful, then deploy the frontend to S3 (with the AWS CLI we installed earlier)

Here is a diagram of how the pipeline works:

![Pipeline Diagram](/SCREENSHOTS/Pipeline_Diagram.png)

## Configuration

The pipeline by default will trigger with each commit on the `main` branch. 

If you need to alter it or add additional branches, you can add them in the `workflows` configuration in `config.yml`

    workflows:
      udagram-workflow:
        jobs:
          - udagram:
              filters:
                branches:
                  only:
                    - main

The pipeline file itself can be edited in either the browser or VS Code. The file is in `.circleci` and the file is `config.yml`

## Environment Variables

 - AWS_ACCESS_KEY_ID: Programmatic access key (can be generated via IAM)
 - AWS_DEFAULT_REGION: Default region in AWS, for this project it is set to "eu-west-2"
 - AWS_SECRET_ACCESS_KEY: Programmatic secret key (can be generated via IAM)
 - CHROME_BIN: Path to Chrome. This may or may not be required. During the pipeline steps, there was an issue with the path not being made available the fix is to provide the path as an environment variable
 - POSTGRES_USERNAME: PostgreSQL username
 - POSTGRES_PASSWORD: Password to connect to PostgreSQL 
 - POSTGRES_DB: Name of the database set up in PostgreSQL 
 - POSTGRES_HOST: Endpoint for the RDS instance of PostgreSQL
 - AWS_REGION: Region for EB to use, default set to: eu-west-2 
 - DB_PORT: Port for PostgreSQL
 - PORT: The port the application uses and EB will use to configure the proxy 
 - URL: URL for the application
 - JWT_SECRET: String used by JWT 
 - AWS_BUCKET: Name of the media bucket for Udagram to store the images
 - AWS_ACCESS_KEY: AWS Access key (can be the same or a different set for the application to use)
 - AWS_SECRET: AWS Secret key (can be the same or a different set for the application to use)