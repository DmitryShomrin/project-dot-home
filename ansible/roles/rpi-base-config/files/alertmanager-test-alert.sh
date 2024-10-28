#!/bin/bash

# Set default values
name=$RANDOM
url='https://alertmanager.s5n.dev/api/v2/alerts'
summary='Testing summary!'
instance="$name.example.net"
default_severity='warning'
starts_at=$(date +%Y-%m-%dT%T.%9N%:z)

# Function to send alert
send_alert() {
    local custom_severity=$1
    local current_severity=${custom_severity:-$default_severity}

    curl -XPOST -H "Content-Type: application/json" $url -d "[
        {
            \"labels\": {
                \"alertname\": \"$name\",
                \"service\": \"my-service\",
                \"severity\":\"$current_severity\",
                \"instance\": \"$instance\"
            },
            \"annotations\": {
                \"summary\": \"$summary\"
            },
            \"startsAt\": \"$starts_at\",
            \"generatorURL\": \"https://prometheus.local/<generating_expression>\"
        }
    ]"
    echo ""
}

# Function to send resolve
send_resolve() {
    local custom_severity=$1
    local current_severity=${custom_severity:-$default_severity}

    curl -XPOST -H "Content-Type: application/json" $url -d "[
        {
            \"labels\": {
                \"alertname\": \"$name\",
                \"service\": \"my-service\",
                \"severity\":\"$current_severity\",
                \"instance\": \"$instance\"
            },
            \"annotations\": {
                \"summary\": \"$summary\"
            },
            \"endsAt\": \"$ends_at\",
            \"generatorURL\": \"https://prometheus.local/<generating_expression>\"
        }
    ]"
    echo ""
}

# Main script
echo "Firing up alert $name"
send_alert

read -p "Press enter to resolve alert"

echo "Sending resolve"
ends_at=$(date +%Y-%m-%dT%T.%9N%:z)
send_resolve