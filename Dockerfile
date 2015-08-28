FROM quay.io/ukhomeofficedigital/jenkins-slave:v0.1.0

RUN yum install -y java-1.8.0-openjdk-devel && \
    yum clean all
