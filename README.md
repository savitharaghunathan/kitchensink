# kitchensink

### JBOSS EAP Standalone server

* Run `postgres` as a podman container

* Run `podman run --rm=true --name kitchensink -e POSTGRES_USER=sa -e POSTGRES_PASSWORD=sa -e POSTGRES_DB=kitchensink -d -p 5432:5432 docker.io/library/postgres:10`

* Run `/opt/jboss-eap-7.4/bin/jboss-cli.sh  --connect` 
* Run `/subsystem=datasources/jdbc-driver=postgresql-driver:add(driver-name=postgresql-driver, driver-class-name=org.postgresql.Driver, driver-module-name=org.postgresql)`

* Navigate to project home and run `mvn clean package wildfly:deploy`

* Access the app - `<ip>:8080/kitchensink`

