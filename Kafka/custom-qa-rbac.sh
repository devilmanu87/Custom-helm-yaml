#!/bin/bash

export NAMESPACE=alpha-cp-hub
export SR_ID=srv_crddev_acnqasr
confluent iam rolebinding create --kafka-cluster-id $KAFKA_ID --principal User:$SR_ID --role SecurityAdmin --schema-registry-cluster-id id_schemaregistry_${NAMESPACE}
confluent iam rolebinding create --kafka-cluster-id $KAFKA_ID --principal User:$SR_ID --role ResourceOwner --resource Group:id_schemaregistry_${NAMESPACE}
confluent iam rolebinding create --kafka-cluster-id $KAFKA_ID --principal User:$SR_ID --role ResourceOwner --resource Topic:_schemas_schemaregistry_${NAMESPACE}
confluent iam rolebinding create --kafka-cluster-id $KAFKA_ID --principal User:$SR_ID --role ResourceOwner --resource Topic:_confluent-license
confluent iam rolebinding create --kafka-cluster-id $KAFKA_ID --principal User:$SR_ID --role DeveloperRead --schema-registry-cluster-id id_schemaregistry_${NAMESPACE} --resource Subject:*

export CONN_ID=srv_crddev_acnqacnt
confluent iam rolebinding create --kafka-cluster-id $KAFKA_ID --principal User:$CONN_ID --role SecurityAdmin --connect-cluster-id ${NAMESPACE}.connectors
confluent iam rolebinding create --kafka-cluster-id $KAFKA_ID --principal User:$CONN_ID --role ResourceOwner --resource Group:${NAMESPACE}.connectors
confluent iam rolebinding create --kafka-cluster-id $KAFKA_ID --principal User:$CONN_ID --role DeveloperWrite --resource Topic:_confluent-monitoring --prefix
confluent iam rolebinding create --kafka-cluster-id $KAFKA_ID --principal User:$CONN_ID --role ResourceOwner --resource Topic:${NAMESPACE}.connectors- --prefix

export RR_ID=srv_crddev_acnqarr
confluent iam rolebinding create --kafka-cluster-id $KAFKA_ID --principal User:$RR_ID --role ResourceOwner --resource Group:${NAMESPACE}.replicator
confluent iam rolebinding create --kafka-cluster-id $KAFKA_ID --principal User:$RR_ID --role DeveloperWrite --resource Topic:_confluent-monitoring --prefix
confluent iam rolebinding create --kafka-cluster-id $KAFKA_ID --principal User:$RR_ID --role ResourceOwner --resource Topic:${NAMESPACE}.replicator- --prefix

export ksqlDB_ID=srv_crddev_acnqaksql
confluent iam rolebinding create --kafka-cluster-id $KAFKA_ID --principal User:$ksqlDB_ID --role ResourceOwner --ksql-cluster-id ${NAMESPACE}.ksql_ --resource KsqlCluster:ksql-cluster
confluent iam rolebinding create --kafka-cluster-id $KAFKA_ID --principal User:$ksqlDB_ID --role ResourceOwner --resource Topic:_confluent-ksql-${NAMESPACE}.ksql_ --prefix

export C3_ID=srv_crddev_acnqac3
confluent iam rolebinding create --principal User:$C3_ID --role SystemAdmin --kafka-cluster-id $KAFKA_ID

export ERP_ID=srv_crddev_acnqaerp
confluent iam rolebinding create --principal User:$ERP_ID --role DeveloperRead --kafka-cluster-id $KAFKA_ID --schema-registry-cluster-id id_schemaregistry_${NAMESPACE} --resource Subject:*

export C3_USERS_ID=srv_crddev_acnqaadmn
confluent iam rolebinding create --kafka-cluster-id $KAFKA_ID --role SystemAdmin --principal User:$C3_USERS_ID
confluent iam rolebinding create --kafka-cluster-id $KAFKA_ID --schema-registry-cluster-id id_schemaregistry_${NAMESPACE} --principal User:$C3_USERS_ID --role SystemAdmin
confluent iam rolebinding create --kafka-cluster-id $KAFKA_ID --connect-cluster-id ${NAMESPACE}.connectors --principal User:$C3_USERS_ID --role SystemAdmin
confluent iam rolebinding create --kafka-cluster-id $KAFKA_ID --connect-cluster-id ${NAMESPACE}.replicator --principal User:$C3_USERS_ID --role SystemAdmin
confluent iam rolebinding create --kafka-cluster-id $KAFKA_ID --ksql-cluster-id ${NAMESPACE}.ksql_ --resource KsqlCluster:ksql-cluster --principal User:$C3_USERS_ID --role ResourceOwner
