# Shell scripts for AWS
This is sample shell scripts for processing output and data in AWS.

## addTagToObj.sh
This script for S3 objects.

```
$ ./addTagToObj.sh
sampleObject-a.txt
{
    "TagSet": [
        {
            "Key": "dataFormat",
            "Value": "text"
        }
    ]
}
sampleObject-b.txt
{
    "TagSet": [
        {
            "Key": "dataFormat",
            "Value": "text"
        }
    ]
}
sampleObject-c.txt
{
    "TagSet": [
        {
            "Key": "dataFormat",
            "Value": "text"
        }
    ]
}
```

## diffSecG.sh
This script shows all security groups you created.

## deleteManifest.sh
This script deletes `xxxx-Manifest.json` in your S3 bucket. This is needed for processing CUR (Cost and Usage Report)

## describeRole.sh
This script shows the attached IAM role for your owned EC2 and Lambda.

Following contents are output in `roleProfile.txt`(output file).

```
*********EC2*********

=========ap-northeast-2=========

=========ap-northeast-1=========
{
  "InstanceId": "i-xxxxxxxxxxxxxxxxx",
  "IAMRole": "arn:aws:iam::012345678910:instance-profile/sampleRole"
}
{
  "InstanceId": "i-xxxxxxxxxxxxxxxxx",
  "IAMRole": "arn:aws:iam::012345678910:instance-profile/kinesisRole"
}
```
