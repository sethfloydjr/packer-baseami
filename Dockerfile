FROM ubuntu:18.04

#Standard things we need to run packer...
RUN  apt-get update && apt-get install -y python3-pip wget zip unzip vim curl


ARG PACKER_VERSION
ENV PACKER_VERSION=$PACKER_VERSION

RUN wget -q "https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip" && \
    unzip -d /usr/local/bin packer_${PACKER_VERSION}_linux_amd64.zip


RUN pip3 install awscli
RUN aws --version

#These vars are received from the CI/CD Vars for this project
ENV AWS_ACCESS_KEY_ID=$TF_VAR_AWS_ACCESS_KEY_ID
ENV AWS_SECRET_ACCESS_KEY=$TF_VAR_AWS_SECRET_ACCESS_KEY
ENV AWS_REGION=$AWS_REGION

#ENV AWS_ACCOUNT2_ACCOUNT=$TF_VAR_ACCOUNT2_ACCOUNT_NUMBER
#ENV AWS_ACCOUNT3_ACCOUNT=$TF_VAR_ACCOUNT3_ACCOUNT_NUMBER


#From here copy templates and required files to the docker image to be built:
RUN mkdir -p /packer
COPY AMICopy.sh /packer/AMICopy.sh
COPY baseAMI-*.json /packer/


RUN chmod -R 755 /packer/

ENV PATH=/packer:$PATH
