resource "aws_lambda_function" "poc" {
  filename         = "helloworldapp.zip"
  function_name    = "HelloWorldAliasPOC"
  handler          = "index.HelloWorld"
  runtime          = "nodejs6.10"
  memory_size      = 128
  timeout          = 10
  publish          = true
  description      = "Hello World Test"
  role             = "arn:aws:iam::118000709326:role/full-catLambda-role"
  source_code_hash = "${base64sha256(file("helloworldapp.zip"))}"
}

resource "aws_lambda_alias" "poc_alias" {
  name             = "stable"
  description      = "Stable Alias"
  function_name    = "${aws_lambda_function.poc.arn}"
  function_version = "${aws_lambda_function.poc.version}"
}
