#!/bin/bash

# Download configuration files from Hydra, for a given network.

CARDANO_CONFIG_URL=$1
CARDANO_NETWORK=$2

wget -q $CARDANO_CONFIG_URL/$CARDANO_NETWORK-config.json            -O network/$CARDANO_NETWORK/cardano-node/config.json
wget -q $CARDANO_CONFIG_URL/$CARDANO_NETWORK-topology.json          -O network/$CARDANO_NETWORK/cardano-node/topology.json

wget -q $CARDANO_CONFIG_URL/$CARDANO_NETWORK-byron-genesis.json     -O network/$CARDANO_NETWORK/genesis/byron.json
wget -q $CARDANO_CONFIG_URL/$CARDANO_NETWORK-shelley-genesis.json   -O network/$CARDANO_NETWORK/genesis/shelley.json
wget -q $CARDANO_CONFIG_URL/$CARDANO_NETWORK-alonzo-genesis.json    -O network/$CARDANO_NETWORK/genesis/alonzo.json

wget -q $CARDANO_CONFIG_URL/$CARDANO_NETWORK-db-sync-config.json    -O network/$CARDANO_NETWORK/cardano-db-sync/config.json
# Somehow, the configuration for db-sync refers to some path in the Nix store :| ...
sed -i 's@"NodeConfigFile":.*$@"NodeConfigFile": "../cardano-node/config.json",@' network/**/cardano-db-sync/config.json
