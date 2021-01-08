FROM openshift/jenkins-slave-base-centos7

MAINTAINER Jeandre Palm <4304398+jeandrep@users.noreply.github.com>

USER root

RUN yum -y install skopeo && \
    yum update -y && \
    yum clean all && \
    rm -rf /var/cache/yum

USER 1001
