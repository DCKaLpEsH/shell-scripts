#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Directory where migration files will be stored
MIGRATIONS_DIR="./migrations"

# Ensure a migration name is provided
if [ -z "$1" ]; then
  echo "Usage: $0 migration_name"
  exit 1
fi

# Convert the input name to snake_case
migration_name="$1"
snake_case_name=$(echo "$migration_name" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/_/g' | sed -E 's/^_|_$//g')

# Generate a timestamp in IST
timestamp=$(TZ=Asia/Kolkata date +"%Y%m%d%H%M%S")

# Build the final filename and path
filename="${timestamp}_${snake_case_name}.sql"
filepath="${MIGRATIONS_DIR}/${filename}"

# Make sure the migrations directory exists
mkdir -p "$MIGRATIONS_DIR"

# 👉 This is where the SQL file is created
cat <<EOF > "$filepath"
-- Migration: ${snake_case_name}
-- Created at: $(TZ=Asia/Kolkata date)
-- =======================================
-- UP
-- Write your forward migration SQL below

-- =======================================
-- DOWN
-- Write your rollback SQL below

EOF

# Confirm to the user
echo "Created ${filepath}"
