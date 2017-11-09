export AWS_DEFAULT_REGION = us-west-2

all:
	@rm -f helloworldapp.zip
	@zip helloworldapp.zip helloworldapp/index.js
	terraform init
	terraform plan
	terraform apply
