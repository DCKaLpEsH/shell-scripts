# If you're using spring boot, place this in your src/main/resources file.

#!/bin/bash

# Exit on error
set -e

# Configuration
MIGRATIONS_DIR="./migrations"

# Ensure migration name is provided
if [ -z "$1" ]; then
  echo "Usage: $0 migration_name"
  exit 1
fi

# Convert name to snake_case (basic)
migration_name="$1"
snake_case_name=$(echo "$migration_name" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/_/g' | sed -E 's/^_|_$//g')

# Get current UTC timestamp
timestamp=$(TZ=Asia/Kolkata date +"%Y%m%d%H%M%S")

# Final file name
filename="${timestamp}_${snake_case_name}.sql"
filepath="${MIGRATIONS_DIR}/${filename}"

# Create migrations dir if not exists
mkdir -p "$MIGRATIONS_DIR"

# Create the file with a header
cat <<EOF > "$filepath"
-- Migration: ${snake_case_name}
-- Created at: $(date -u)
-- Write your SQL statements below this line.

EOF

# Output result
echo "Created ${filepath}"
