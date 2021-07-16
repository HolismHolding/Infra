#!/bin/bash

sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /HolismHolding/Infra/DevelopmentCertificate/PrivateKey.key -out /HolismHolding/Infra/DevelopmentCertificate/PublicKey.crt

# US
# CA
# San Francisco
# Holism
# Development
# Holism
# admin@holism.tld
