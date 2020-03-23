#### PACKER-BaseAMI

==========

Packer AMI builder - Builds basic AMIs for infrastructure and to be built on top of in other projects. OSs built are the latest Amazon Linux 2 and latest Ubuntu 18.04.

Can be expanded to include anything that you would want in your base AMI. To do this add steps in the *.json file's shell provisioner script.


# Instructions
Clone this project and make the following changes in each file. Create a new project in Gitlab and push this code to it. The CI/CD pipeline should take over for you and once you merge to master you will be able to apply. More step-by-steps follow.

### Environment Variables

You can add the AWS keys to the project Environment variables by going to `YourProject > Settings> CI/CD > Variables`. From here you will want to add the following for this project:
* `TF_VAR_AWS_ACCESS_KEY_ID`
* `TF_VAR_AWS_SECRET_ACCESS_KEY`
* `PACKER_VERSION` - Check here for latest Packer version: https://www.packer.io/downloads.html
Optionally if you decide to run the AMICopy script in the pipeline you will need to setup Env Vars for these also:
* `AWS_REGION`
* TF_VAR_ACCOUNT2_ACCOUNT_NUMBER
* TF_VAR_ACCOUNT3_ACCOUNT_NUMBER


### Files to Change
* `gitlab-ci.yml` - rename this file to `.gitlab-ci.yml` Also if you are running the optional AMICopy step you will need to uncomment it at the bottom of the build script and setup the env vars required (correcting the names)
* `base-ami-AMZN.json` - You will need to replace the ALL_CAPS_VARS on lines: 25 and 26 for the VPC and SUBNET IDs.
* `base-ami-UBUNTU.json` - You will need to replace the ALL_CAPS_VARS on lines: 25 and 26 for the VPC and SUBNET IDs.


### Local testing
* You will need to create a "bastion" instance in your AWS account that you can SSH to and then jump to the Packer Build instance.
* To test a packer template locally you can do: `packer build -var AWS_ACCESS_KEY_ID=<YOUR_AWS_KEY> -var AWS_SECRET_ACCESS_KEY=<YOUR AWS_SECRET_KEY> -debug baseAMI-UBUNTU.json`
* The debug in that line will cause Packer to stop and wait for confirmation after every step. Once the instance is up and running you can use the temporary .pem file that Packer will place in your pwd to connect to the instance and debug or run any tests.
* `ssh -A ubuntu@<PRIVATE_IP_ADDRESS>` -or- `ssh -A ec2-user@<PRIVATE_IP_ADDRESS>` should get you into the instance. Packer creates a temporary security group that gives SSH access to 0.0.0.0/0 but the instance does not have a public facing dns name/ip.
* Find the private_ip address in EC2 in the AWS console...it will be named Packer Builder.


# Forks and Contributing

Feel free to clone this project and use for yourself. This is a very basic example and can be greatly expanded. Just give me a mention if you use it.
Fork if you have something to contribute or open an issue.

Feel free to comment or contact me on Twitter: `@setheryops`

Also find this repo at https://github.com/sethfloydjr/packer-baseami

