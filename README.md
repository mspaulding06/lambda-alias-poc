# lambda-alias-poc

The purpose of this repository is to show a proof of concept that exhibits an issue with Terraform alias support for AWS Lambda.

In order to run the test, do the following:

1. Load your AWS credentials
1. Run 'make'

At this point you will see that the Lambda has been created and it should have a single published version.
If you then run 'make' again you will find that it will publish another version but this time the alias will not update.
If you run 'make' a third time a third version will be published and now the alias will update.
The output from Terraform will claim that is going to update the alias from the first version to the second version.

```
Terraform will perform the following actions:

  ~ aws_lambda_alias.poc_alias
      function_version: "1" => "2"
```

But when the change is actually applied it will skip the second version and apply the label to the latest (third) version.

```
aws_lambda_alias.poc_alias: Modifying... (ID: arn:aws:lambda:us-west-2:<ACCOUNT-ID>:function:HelloWorldAliasPOC:stable)
  function_version: "1" => "3"
```
