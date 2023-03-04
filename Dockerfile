FROM openjdk:21-slim-bullseye

ENV ARTIFACT_NAME=spring-petclinic-3.0.0-SNAPSHOT

WORKDIR /usr/lib/

COPY target/${ARTIFACT_NAME}.jar /usr/lib/

EXPOSE 8080

ENTRYPOINT [ "java", "-jar", "${ARTIFACT_NAME}.jar" ]
