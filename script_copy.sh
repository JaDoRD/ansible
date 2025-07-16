#!/usr/bin/env bash

containers=$(docker ps -q)

if [ -z "$containers" ]; then
  echo "Нет запущенных контейнеров."
  exit 0
fi

for container in $containers; do
  name=$(docker inspect --format '{{.Name}}' "$container" | sed 's|/||')
  echo "============================="
  echo "Контейнер: $name ($container)"
  echo "Переменные окружения:"
  docker inspect --format '{{range $index, $value := .Config.Env}}{{$value}} {{println}}{{end}}' "$container"
  echo
done
