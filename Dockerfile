FROM jenkins/inbound-agent:alpine as jnlp

FROM openshift/jenkins-slave-base-centos7:latest

USER root

RUN yum repolist > /dev/null && \
    yum clean all && \
    INSTALL_PKGS="skopeo" && \
    yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all

USER 1001

COPY --from=jnlp /usr/local/bin/jenkins-agent /usr/local/bin/jenkins-agent
COPY --from=jnlp /usr/share/jenkins/agent.jar /usr/share/jenkins/agent.jar

ENTRYPOINT ["/usr/local/bin/jenkins-agent"]
