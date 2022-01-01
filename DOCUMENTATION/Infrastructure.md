# Infrastructure Documentation

# RDS

![Database Setup](/SCREENSHOTS/RDS.png)

The RDS setup is very straightforward but there are a couple of things to watch out for:

 - When clicking `Create Database`, the best aproach is `Standard Create` as there are only a couple of options to modify which can't be achieved in `Easy Create`
 - Select `PostgreSQL` and version `12.8-R1` (at this time of writing)
 - Select the `Free Tier` option
 - Set the DB Instance Identifier to `udagram`
 - Leave the username as `postgress` and set a strong and secure password
 - to keep costs low, in `Availabilty & Durability` select `Do not create a standby instance`
 - In `Connectivity` set `Public access` to `Yes` 
 - In `Additional configuration` set the initial database name to `udagram`
 - (OPTIONAL) To keep costs down, disable the automatic backups
 - Now wait a few minutes for the DB instance to come online

# S3

## Webhosting Bucket

![S3 Web Bucket](/SCREENSHOTS/S3_WEB.png)

To help speed up the deployment, here are some commands you can use (or optionally put in a script) to help speed up the deployment of your S3 bucket:

1. `aws s3api create-bucket --bucket your-unique-bucket-name --region eu-west-2 --create-bucket-configuration LocationConstraint=eu-west-2` FYI: Your bucket will need a globally unique name
2. `aws s3 website s3://your-unique-bucket-name/ --index-document index.html` --> This step will configure the webhosting for you
3. In the S3 Console, you'll need to paste in this ACL under `Permissions` > `Bucket Policy`:

    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "PublicReadGetObject",
                "Effect": "Allow",
                "Principal": "*",
                "Action": [
                    "s3:GetObject",
                    "s3:PutObject"
                ],
                "Resource": "arn:aws:s3:::your-unique-bucket-name/*"
            }
        ]
    }
4. Lastly, the CORS policy under `Permissions` > `Cross-origin resource sharing (CORS)`:
    [
        {
            "AllowedHeaders": [
                "*"
            ],
            "AllowedMethods": [
                "GET",
                "POST",
                "PUT",
                "HEAD",
                "DELETE"
            ],
            "AllowedOrigins": [
                "*"
            ],
            "ExposeHeaders": []
        }
    ]

## Media Bucket

For this step, you can create it via the S3 console. This bucket is a standard bucket that doens't require webhosting nor does it require public access. Again, note that you will require a globally unique name for this bucket:

![S3 Media Bucket](/SCREENSHOTS/S3_MEDIA.png)

The last important step is to add the CORS policy under `Permissions` > `Cross-origin resource sharing (CORS)`:
    [
        {
            "AllowedHeaders": [
                "*"
            ],
            "AllowedMethods": [
                "GET",
                "POST",
                "PUT",
                "HEAD",
                "DELETE"
            ],
            "AllowedOrigins": [
                "*"
            ],
            "ExposeHeaders": []
        }
    ]


# Elastic Beanstalk (EB)

1. Inside the `udagram-api` folder, run `eb init`. 
2. Set your default region
3. For Node, we are using version 12 for this project
4. Once the configuration is complete we want to add this section to the `config.yml` in `.elasticbeanstalk`
    deploy:
      artifact:  www/Archive.zip
5. Next up, we need to create an environment for us to work with, use the command `eb create *env_name*` 
6. Everything is nearly setup but the last bit is configuring the environment variables in Elastic Beanstalk. Go to `Elastic Beanstalk` in the console > Select the environment > Go to `Configuration` > In the `Software` catagory, select `Edit` > Enter you environment variables in `Environment Properties`:

![EB Environment Variables](/SCREENSHOTS/EB_ENV.png)

If it has all been configured correctly, your Elastic Beanstalk console should look like this:

![EB Console](/SCREENSHOTS/EB_HEALTH.png)
