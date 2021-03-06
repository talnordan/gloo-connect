export ENVOY_PATH=$(which envoy)
GLOO_BRIDGE_PATH=$(which gloo-connect)

export CONSUL_CONFIG_HOME=${PWD}/consul-config
mkdir -p $CONSUL_CONFIG_HOME

export GLOO_CONSUL_BRIDGE_HOME=${PWD}/gloo-connect-config
mkdir -p $GLOO_CONSUL_BRIDGE_HOME

cat > $CONSUL_CONFIG_HOME/connect.json <<EOF
{
    "connect" : {
    "enabled" : true,
    "proxy_defaults" : {
        "exec_mode" : "daemon",
        "daemon_command" : [
        "${GLOO_BRIDGE_PATH}",
        "--conf-dir","${GLOO_CONSUL_BRIDGE_HOME}",
        "--envoy-path","${ENVOY_PATH}"
        ]
        }
    }
}
EOF

cat > $CONSUL_CONFIG_HOME/service.json <<EOF
{
    "service": {
        "name": "web",
        "port": 8080,
        "connect": {
            "proxy": {}
        }
    }
}
EOF