FROM centos:7

ENV QUARKUS_LAUNCH_DEVMODE=true \
    JAVA_ENABLE_DEBUG=true

#ADD apache-maven-3.8.5-bin.tar.gz /root/

RUN yum -y update \
	&& yum install -y java-11-openjdk-devel

COPY target/quarkus-app/lib/ /deployments/lib/
COPY target/quarkus-app/*.jar /deployments/
COPY target/quarkus-app/app/ /deployments/app/
COPY target/quarkus-app/quarkus/ /deployments/quarkus/

CMD ["java", "-jar", \
  "-Dquarkus.http.host=0.0.0.0", \
  "-Dquarkus.package.type=mutable-jar", \
  "-Dquarkus.live-reload.password=big", \
  "/deployments/quarkus-run.jar"]
