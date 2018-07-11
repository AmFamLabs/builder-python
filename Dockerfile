FROM jenkinsxio/builder-base:0.0.402

RUN yum install -y https://centos7.iuscommunity.org/ius-release.rpm
RUN yum update  -y
RUN yum install -y python36u python36u-libs python36u-devel python36u-pip
RUN ln -s /usr/bin/python3.6 /usr/bin/python3

CMD ["python3", "--version"]
