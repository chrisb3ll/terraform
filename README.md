# terraform
Example Infrastructure Provisioning


### You will need
 - [Terraform](https://www.terraform.io) (v0.6.12+)
 - [AWS Console Access](https://console.aws.amazon.com)

### Environment Variables
 - export AWS_ACCESS_KEY_ID="_yourAWSAccessKey_"
 - export AWS_SECRET_ACCESS_KEY="_yourAWSSecretKey_"
 - export AWS_DEFAULT_REGION="_yourAWSDefaultRegion_"

Environment variable management is personal preference.  
You could use [direnv](http://direnv.net/).

### Key pairs
Terraform cannot create new key pairs, only import existing.  
As a manual step either way, please create a key pair in the console.  
Default expected is `terraform_key`.

### Start
A simple bash wrapper `tf.sh` is available for use:

```
  usage: ./tf.sh [ -a value -e value -x 'value(s)' ]

     -a --> action: plan, push, apply
     -e --> environment: management, dev, test, prod etc.
     -x --> extra options: terraform args (optional)
```

### Roles
**shared:**  
  Re-usable configuration for creating similar environments (e.g. dev, tst, prd)
  Number of instances, IP address etc. defined in variable files

**envName:**  
  Specific configuration for non generic environment creation. (e.g. mgt)

### Recommendations
  - Create a VPC per environment or role (dev, tst, mgt etc.)
  - Use a minimum two availability zones per VPC
