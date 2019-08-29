#!/bin/bash

DIR=`dirname $(readlink -f $0)`
TOKEN=`cat $DIR/.token`
PROJECT=$2
DOMAIN=$3
CERT=~/.acme.sh/$4/fullchain.cer
KEY=~/.acme.sh/$4/$4.key

function check_cert () {
    if sha256sum -c $DIR/$DOMAIN.sha; then
        echo "Certificate not changed, exiting."
        exit 0
    else
        sha256sum $CERT > $DIR/$DOMAIN.sha
        sha256sum $KEY >> $DIR/$DOMAIN.sha
    fi
}

function create () {
    curl --request POST \
        --header "PRIVATE-TOKEN: $TOKEN" \
        --form "domain=$DOMAIN" \
        --form "certificate=@$CERT" \
        --form "key=@$KEY" \
        https://gitlab.com/api/v4/projects/$PROJECT/pages/domains
}

function update () {
    curl --request PUT \
        --header "PRIVATE-TOKEN: $TOKEN" \
        --form "certificate=@$CERT" \
        --form "key=@$KEY" \
        https://gitlab.com/api/v4/projects/$PROJECT/pages/domains/$DOMAIN
}

case $1 in
    create)
        check_cert
        create
        ;;
    update)
        check_cert
        update
        ;;

    *)
        echo "Usage $0 command project domain cert"
        echo
        echo "command:  create/update"
        echo "project:  project ID"
        echo "domain:   pages domain"
        echo "cert:     certificate domain"
        exit 1;
        ;;
esac

