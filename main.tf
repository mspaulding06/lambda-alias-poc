resource "aws_lambda_function" "poc" {
  filename         = "helloworldapp.zip"
  function_name    = "HelloWorldAliasPOC"
  handler          = "index.HelloWorld"
  runtime          = "nodejs6.10"
  memory_size      = 128
  timeout          = 10
  publish          = true
  description      = "Hello World Test"
  role             = "${aws_iam_role.alias_poc_role.arn}"
  source_code_hash = "${base64sha256(file("helloworldapp.zip"))}"
}

resource "aws_lambda_alias" "poc_alias" {
  name             = "stable"
  description      = "Stable Alias"
  function_name    = "${aws_lambda_function.poc.arn}"
  function_version = "${aws_lambda_function.poc.version}"
}

resource "aws_iam_role" "alias_poc_role" {
  name = "alias_poc_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "alias_poc_role_attach" {
  role       = "${aws_iam_role.alias_poc_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
