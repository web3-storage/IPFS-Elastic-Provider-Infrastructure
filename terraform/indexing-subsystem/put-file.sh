# This is a testing script for uploading a car file to API Gateway through CURL
# Replace host (okhpnoo7vb.execute-api.us-east-2.amazonaws.com/v1/) with AWS API Gateway provided URL
curl -v -X PUT https://okhpnoo7vb.execute-api.us-east-2.amazonaws.com/v1/carfile.car --upload-file carfile.car