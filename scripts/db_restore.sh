#!/bin/bash

echo 'Capturing backup...'
heroku pg:backups -a c4q-internal-staging capture
echo 'Fetching backup...'
curl -o latest.dump `heroku pg:backups -a c4q-internal-staging public-url`
echo 'Updating local database...'
pg_restore --verbose --clean --no-acl --no-owner -h localhost -d website_development latest.dump
