all: app

TARGET=month-sb-redirector

app:
	echo nothing to do

deploy: app
	sam package --template-file template.yml --s3-bucket nana-lambda --output-template-file packaged-template.yml
	sam deploy --template-file packaged-template.yml --region ap-northeast-1 --capabilities CAPABILITY_IAM --stack-name $(TARGET)
