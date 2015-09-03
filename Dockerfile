FROM quay.io/ukhomeofficedigital/jenkins-slave:v0.1.0

RUN yum install -y java-1.8.0-openjdk-devel unzip && \
    yum clean all

ENV SONAR_RUNNER_VERSION=2.4
ENV SONARQUBE_HOST_URL=http://localhost:9000
ENV SONARQUBE_JDBC_USERNAME=sonar
ENV SONARQUBE_JDBC_PASSWORD=sonar
ENV SONARQUBE_JDBC_URL=jdbc:mysql://localhost:3306/sonar?useUnicode=true&amp;characterEncoding=utf8

RUN wget -O /tmp/sonar-runner-dist-$SONAR_RUNNER_VERSION.zip \
        http://repo1.maven.org/maven2/org/codehaus/sonar/runner/sonar-runner-dist/$SONAR_RUNNER_VERSION/sonar-runner-dist-$SONAR_RUNNER_VERSION.zip && \
    mkdir /sonar-runner && \
    unzip /tmp/sonar-runner-dist-$SONAR_RUNNER_VERSION.zip -d /sonar-runner && \
    rm /tmp/sonar-runner-dist-$SONAR_RUNNER_VERSION.zip && \
    ln -s /sonar-runner/sonar-runner-$SONAR_RUNNER_VERSION/bin/sonar-runner /usr/local/bin/sonar-runner
COPY sonar-entrypoint.sh /usr/local/bin/sonar-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/sonar-entrypoint.sh"]
