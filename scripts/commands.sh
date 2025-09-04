#!/bin/sh

# O shell irá encerrar a execução do script quando um comando falhar
set -e

while ! nc -z $POSTGRES_HOST $POSTGRES_PORT; do
  echo "🟡 Waiting for Postgres Database Startup ($POSTGRES_HOST $POSTGRES_PORT) ..."
  sleep 2
done

echo "✅ Postgres Database Started Successfully ($POSTGRES_HOST:$POSTGRES_PORT)"

echo "Começando a fezer as migrações...."
python manage.py makemigrations --noinput

echo "Aplicando as migrações...."
python manage.py migrate --noinput

echo "Iniciando o servidor.."
python manage.py runserver 0.0.0.0:8000