FROM jenkinsxio/builder-base:latest

RUN yum install -y https://centos7.iuscommunity.org/ius-release.rpm
RUN yum distribution-synchronization
RUN yum update  -y
RUN yum install -y python36u python36u-libs python36u-devel python36u-pip
RUN ln -s /usr/bin/python3.6 /usr/bin/python3
# NOTE: jenkinsxio/builder-python original image ends about here...

# install vault
RUN cd /tmp \
    && curl -LO https://releases.hashicorp.com/vault/1.0.2/vault_1.0.2_linux_amd64.zip \
    && unzip vault*.zip \
    && chmod +x vault \
    && mv vault /usr/local/bin \
    && rm vault*.zip \
    && cd - 

RUN yum groupinstall "Development tools" -y
RUN yum install zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel xz xz-devel libffi-devel -y

RUN curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
RUN echo 'export PATH=/root/.pyenv/bin:$PATH' >> /root/.bashrc
RUN echo 'export PYENV_ROOT=/root/.pyenv' >> /root/.bashrc
RUN echo 'eval "$(pyenv init -)"' >> /root/.bashrc
RUN echo 'eval "$(pyenv virtualenv-init -)"' >> /root/.bashrc
RUN source /root/.bashrc && pyenv install 2.7.14
RUN source /root/.bashrc && pyenv install 2.7.15
RUN source /root/.bashrc && pyenv install 3.5.4
RUN source /root/.bashrc && pyenv install 3.5.5
RUN source /root/.bashrc && pyenv install 3.6.5
RUN source /root/.bashrc && pyenv install 3.6.6
RUN source /root/.bashrc && pyenv install 3.6.7
RUN source /root/.bashrc && pyenv install 3.7.0
RUN source /root/.bashrc && pyenv install 3.7.1
RUN source /root/.bashrc && pyenv install 3.7.2

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python3 get-pip.py

RUN pip3 install --upgrade pipenv wheel setuptools twine awscli


CMD ["python3", "--version"]
