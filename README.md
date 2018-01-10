# AWIS request
Creates an IAM access key with access to the alexa top site stuff

## Deployment
You should use the nubisproject/nubis-deploy docker container to deploy this

```
IMAGE_VERSION=$(curl -k -s -S "https://registry.hub.docker.com/v1/repositories/nubisproject/nubis-builder/tags" | jq --raw-output '.[]["name"]' | sort --field-separator=. --numeric-sort --reverse | grep -m 1 "^v")
docker pull nubisproject/nubis-deploy:${IMAGE_VERSION}

ACCOUNT='<account-to-build-in>'
aws-vault exec ${ACCOUNT} -- docker run --interactive --tty --env-file ~/.docker.env -v $PWD:/nubis/data nubisproject/nubis-deploy:${IMAGE_VERSION} apply
```
