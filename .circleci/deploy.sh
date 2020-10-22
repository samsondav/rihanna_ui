#!/bin/bash
# This script is meant to be run from a Circle CI job to automatically build a new version of the Docker container and
# deploy it to the specified environment.

set -e

SERVICE_NAME="rihanna"
DOCKER_REGISTRY="004671295794.dkr.ecr.us-west-2.amazonaws.com"
DOCKER_IMAGE="${DOCKER_REGISTRY}/${SERVICE_NAME}"

if [[ "$CIRCLE_TAG" =~ ^release-.*$ ]]; then
  echo "Found release tag. Deploying to prod..."
  AWS_ACCOUNT_ID="872406820375"
  AWS_ENVIRONMENT="prod"

elif [[ "$CIRCLE_BRANCH" == "master" ]]; then
  echo "On master branch. Deploying to stage..."
  AWS_ACCOUNT_ID="501126772091"
  AWS_ENVIRONMENT="stage"

elif [[ "$CIRCLE_BRANCH" == "develop" ]]; then
  echo "On develop branch. Deploying to dev..."
  AWS_ACCOUNT_ID="392216643236"
  AWS_ENVIRONMENT="dev"

else
  echo "Did not find release tag or master/develop branch, so skipping deploy."
  exit 0
fi

IAM_ROLE_ARN="arn:aws:iam::$AWS_ACCOUNT_ID:role/allow-auto-deploy-from-other-accounts"
SERVICE_PATH="${AWS_ENVIRONMENT}/us-west-2/${AWS_ENVIRONMENT}/services/k8s-${SERVICE_NAME}"

aws ecr get-login-password --region "us-west-2" | docker login --username AWS --password-stdin https://$DOCKER_REGISTRY

git config --global push.default simple

build-docker-image \
  --docker-image-name "$DOCKER_IMAGE" \
  --docker-image-tag "$CIRCLE_SHA1" \
  --build-arg GITHUB_OAUTH_TOKEN="$GITHUB_OAUTH_TOKEN"

terraform-update-variable \
  --name "image_version" \
  --value "\"$CIRCLE_SHA1\"" \
  --vars-path "$SERVICE_PATH/terragrunt.hcl" \
  --git-url "git@github.com:BlinkerGit/infrastructure-live.git" \
  --git-checkout-path "/tmp/infrastructure-live" \
  --git-user-email "blinkerci@blinker.com" \
  --git-user-name "BlinkerCI"

terragrunt apply \
  --terragrunt-working-dir "/tmp/infrastructure-live/$SERVICE_PATH" \
  --terragrunt-iam-role "$IAM_ROLE_ARN" \
  -input=false \
  -auto-approve
