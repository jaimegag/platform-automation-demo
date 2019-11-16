if [ ! $# -eq 2 ]; then
  echo "Must supply product name as iaas and environment.  ex: ./fly-pipelines.sh vsphere lab"
  exit 1
fi

iaas=$1
environment=$2

## OM and Director
fly -t ci set-pipeline -p deploy-om-and-director -c pipelines/om-and-director-pipeline.yml -l environments/${iaas}/${environment}/common-pipeline-params.yml -n
fly -t ci unpause-pipeline -p deploy-om-and-director

## PAS
# fly -t ci set-pipeline -p deploy-cf -c pipelines/standard-product-pipeline.yml -l environments/${iaas}/${environment}/common-pipeline-params.yml -v product=cf -n
# fly -t ci unpause-pipeline -p deploy-cf

## Harbor
# fly -t ci set-pipeline -p deploy-harbor -c pipelines/standard-product-pipeline.yml -l environments/${iaas}/${environment}/common-pipeline-params.yml -v product=harbor-container-registry -n
# fly -t ci unpause-pipeline -p deploy-harbor

## PKS
fly -t ci set-pipeline -p deploy-pks -c pipelines/standard-product-pipeline.yml -l environments/${iaas}/${environment}/common-pipeline-params.yml -v product=pivotal-container-service -n
fly -t ci unpause-pipeline -p deploy-pks

## Rabbit MQ
# fly -t ci set-pipeline -p deploy-rabbit -c pipelines/standard-product-pipeline.yml -l environments/${iaas}/${environment}/common-pipeline-params.yml -v product=p-rabbitmq -n
# fly -t ci unpause-pipeline -p deploy-rabbit

## MySql
# fly -t ci set-pipeline -p deploy-mysql -c pipelines/standard-product-pipeline.yml -l environments/${iaas}/${environment}/common-pipeline-params.yml -v product=pivotal-mysql -n
# fly -t ci unpause-pipeline -p deploy-mysql

## Generating Certs
# fly -t ci set-pipeline -p generate-certs -c pipelines/generate-certs-pipeline.yml -l environments/${iaas}/${environment}/common-pipeline-params.yml -n
# fly -t ci unpause-pipeline -p generate-certs
