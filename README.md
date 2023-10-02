# kitchensink


* Create postgres `kitchensink` db

``` Run `podman run --rm=true --name kitchensink -e POSTGRES_USER=sa -e POSTGRES_PASSWORD=sa -e POSTGRES_DB=kitchensink -d -p 5432:5432 docker.io/library/postgres:10` ```

* Run the app using `./mvnw quarkus:dev`