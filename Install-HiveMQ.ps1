helm repo add hivemq https://hivemq.github.io/helm-charts
helm repo update
helm install hivemqo hivemq/hivemq-platform-operator -n hivemq --create-namespace
helm install hivemqp hivemq/hivemq-platform -n hivemq -f values.yaml