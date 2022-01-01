# App Dependencies

The application consists of two parts: the API and Frontend

The API MUST be deployed before the Frontend.

The API Backend has a dependency on an RDS database. The database should be up before attempting to connect to it. 

The frontend can be deployed either before or after the backend but doing so after a successful deployment of the backend means the user won't run into errors nor will they need to refresh for the service to work as intenteded.

The Frontend has an Angular dev dependency which has been met in the `package.json` file.