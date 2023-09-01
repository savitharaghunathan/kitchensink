# kitchensink

## Deploy DB 
```oc new-app postgresql-ephemeral    -p DATABASE_SERVICE_NAME=kitchensink-db    -p POSTGRESQL_DATABASE=kitchensink```

## Deploy app
```helm install --set build.ref=galleon kitchensink -f helm.yaml jboss-eap/eap74```
