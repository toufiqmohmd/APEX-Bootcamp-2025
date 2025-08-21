The "Supporting Objects" folder contains 3 scripts for implementing "Custom Authentication" as part of this workshop.
To implement Custom AuthN you would need to execute the provided scripts in the following order ONLY:
1. Run the create tables script, which will create a table to hold user data for AuthN.
2. Run the Custom Authentication package script, which contains the entire logic to authenticate the user against the users present in Users table created in the previous step.
3. Run the Trigger script which takes care of hashing the password when a user is created and it will also be referring to the package created above.