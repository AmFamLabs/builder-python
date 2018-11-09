FROM jenkinsxio/builder-base:latest

RUN yum install -y https://centos7.iuscommunity.org/ius-release.rpm
RUN yum update  -y
RUN yum install -y python36u python36u-libs python36u-devel python36u-pip
RUN ln -s /usr/bin/python3.6 /usr/bin/python3
RUN ln -s /usr/bin/python3.6 /usr/bin/python

# base jx image ends about here

RUN yum groupinstall "Development tools" -y
RUN yum install zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel xz xz-devel libffi-devel -y

RUN curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
RUN export PATH="/home/jenkins/.pyenv/bin:$PATH"
RUN export PYENV_ROOT=$HOME/.pyenv
RUN eval "$(pyenv init -)"
RUN eval "$(pyenv virtualenv-init -)"
pyenv install 2.7.14
pyenv install 2.7.15
pyenv install 3.5.4
pyenv install 3.5.5
pyenv install 3.6.5
pyenv install 3.6.6
pyenv install 3.6.7
pyenv install 3.7.0
pyenv install 3.7.1

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python get-pip.py

RUN pip install --upgrade pipenv wheel setuptools twine

RUN export PIPENV_YES=true


CMD ["python3", "--version"]
