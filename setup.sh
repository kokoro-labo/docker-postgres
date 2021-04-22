#!/bin/sh

sh cleanup.sh

if [ -e ".env" ]; then
  echo "\n>>> rm .env..."
  rm .env
fi

echo "\n>>> make .env..."
touch .env

echo "\n>>> input password..."
read -p " - POSTGRES_PASSWORD : " POSTGRES_PASSWORD
echo "POSTGRES_PASSWORD=${POSTGRES_PASSWORD}" >> .env

echo "\n>>> container up..."
docker-compose up -d

echo "\n>>> setup completed"

exit 0
