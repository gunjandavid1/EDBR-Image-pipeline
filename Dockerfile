###You need to be ready with the files in build context
FROM centos/systemd:latest
RUN yum install epel-release -y 
RUN yum install https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm -y
ADD . /edbr_rpms
COPY edb.repo /etc/yum.repos.d/edb.repo
COPY ENTERPRISEDB-GPG-KEY /etc/pki/rpm-gpg/
WORKDIR /edbr_rpms
RUN echo Environment Completed


#Once you are done with building image..Login to container and execute the container_env_script.sh from  /edbr_rpms directory.
