# AWS IoT policy samples
## How to attach iot policy to certificate with AWS CLI
### 1. Create iot policy at local environment
Example: fullAccessPolicy.json

```.json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "iot:*",
      "Resource": "*"
    }
  ]
}
```

### 2. Create iot policy
```
$ aws iot create-policy --policy-name fullAccess --policy-document file://fullAccessPolicy.json
{
    "policyName": "fullAccess",
    "policyArn": "arn:aws:iot:<Region>:<AccountID>:policy/fullAccess",
    "policyDocument": "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Effect\": \"Allow\",\n      \"Action\": \"iot:*\",\n      \"Resource\": \"*\"\n    }\n  ]\n}\n",
    "policyVersionId": "1"
}
```

### 3. Attach the policy to your certificate
Check ARN of pricipal

```
$ aws iot describe-certificate --certificate-id xxxxxxxxxxxxxxxxxxxxxxx | jq '.certificateDescription.certificateArn'
"arn:aws:iot:<Region>:<AccountID>:cert/xxxxxxxxxxxxxxxxxxxxxxx"
```

Attach the policy

```
$ aws  iot attach-principal-policy --principal "arn:aws:iot:<Region>:<AccountID>:cert/xxxxxxxxxxxxxxxxxxxxxxx" --policy-name "fullAccess"
```

Check attachment of policy

```
$ aws iot list-principal-policies --principal "arn:aws:iot:<Region>:<AccountID>:cert/xxxxxxxxxxxxxxxxxxxxxxx"
{
    "policies": [
        {
            "policyName": "fullAccess",
            "policyArn": "arn:aws:iot:<Region>:<AccountID>:policy/fullAccess"
        }
    ]
}
```
