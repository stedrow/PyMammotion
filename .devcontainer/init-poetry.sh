#!/bin/bash
poetry install --no-interaction --no-ansi
exec "$@"