# kitchensink

### JBOSS EAP Standalone server

* Run `postgres` as a podman container

* Run `podman run --rm=true --name kitchensink -e POSTGRES_USER=sa -e POSTGRES_PASSWORD=sa -e POSTGRES_DB=kitchensink -d -p 5432:5432 docker.io/library/postgres:10`

* Run `/opt/jboss-eap-7.4/bin/jboss-cli.sh  --connect` 
* Run `/subsystem=datasources/jdbc-driver=postgresql-driver:add(driver-name=postgresql-driver, driver-class-name=org.postgresql.Driver, driver-module-name=org.postgresql)`

* Navigate to project home and run `mvn clean package wildfly:deploy`

* Access the app - `<ip>:8080/kitchensink`

### JBOSS EAP on Openshift 

* This uses `Opensift` branch

* Create the database and add necessary labels
```
oc new-app --name=kitchensink-db \
 -e POSTGRESQL_USER=sa \
 -e POSTGRESQL_PASSWORD=sa \
 -e POSTGRESQL_DATABASE=kitchensink centos/postgresql-10-centos7 \
 --as-deployment-config=false

oc label deployment/kitchensink-db app.kubernetes.io/part-of=kitchensink-app --overwrite=true && \
oc label deployment/kitchensink-db app.openshift.io/runtime=postgresql --overwrite=true
```

* Create the app
```
oc new-app --template=eap74-basic-s2i \
-p APPLICATION_NAME=kitchensink \
-p EAP_IMAGE_NAME=jboss-eap74-openjdk8-openshift:latest \
-p EAP_RUNTIME_IMAGE_NAME=jboss-eap74-openjdk8-runtime-openshift:latest \
-p MAVEN_ARGS_APPEND="-Dcom.redhat.xpaas.repo.jbossorg" \
-p SOURCE_REPOSITORY_URL="https://github.com/savitharaghunathan/kitchensink.git" \
-p SOURCE_REPOSITORY_REF=openshift \
-p CONTEXT_DIR=.
```
_Note: It uses Openshift branch for deployment_

* Inject database env variables

```
oc set env dc/kitchensink DB_HOST=kitchensink-db DB_PORT=5432 DB_NAME=kitchensink DB_USERNAME=sa DB_PASSWORD=sa && \

oc label dc/kitchensink app.kubernetes.io/part-of=kitchensink-app --overwrite=true && \
oc label dc/kitchensink app.openshift.io/runtime=jboss --overwrite=true

oc annotate dc/kitchensink \
 app.openshift.io/connects-to='[{"apiVersion":"apps/v1","kind":"Deployment","name":"kitchensink-db"}]' \
 --overwrite=true
```

