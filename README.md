### React / Node / GKE Example

This is an example project to show how to have a React frontend with a Node / Express backend, using Github actions to deploy to GKE.

TypeScript is used across the project.

React was created using `create-react-app`. 

Dependencies might be outdated- it may be better to create the pieces from scratch and just use this as an example.

#### Running Locally

`npm install` in both client and server folders.

`npm run start` in both folders will run each and watch for changes.

#### Docker

Docker compose makes it easier to test the Docker container locally:
`docker-compose up -d --build`

#### Github Actions

The deployment.yaml file in .github/workflows will run when the develop branch has any changes (such as a PR being merged). 
It also can be run manually in the actions page.

#### Github Secrets

The following need to be added to the Github secrets in the repo for automatic deployment.
Add them to the Environment secrets for `production`. If you are using a different environment, you will need to update the deployment.yaml file to reflect that.

`GKE_PROJECT` - GKE project ID

`GKE_ZONE` - GKE Zone, IE: us-central1-c

`GKE_CLUSTER_NAME` - Cluster that will be deployed to

`GKE_SERVICE_ACCOUNT` - Service account that is used to authenticate the Github actions

`GKE_WORKLOAD_IDENTITY_PROVIDER` - Full identifier of Workload Identity Provider. 
In Workload Identity Federation, you can find this in the IAM Principal field. Format is follows:
`projects/123456789/locations/global/workloadIdentityPools/my-pool/providers/my-provider`

Extra resources:
https://github.com/google-github-actions/auth