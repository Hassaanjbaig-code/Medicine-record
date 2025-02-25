#!/bin/bash -e

# Check if the Rails server is being started, and run database setup if needed
if [[ "${1}" == "./bin/rails" && "${2}" == "server" ]]; then
  echo "Running database setup (db:prepare)..."
  ./bin/rails db:prepare
fi  # Close the first 'if' block

# Remove any existing server.pid to prevent conflicts
if [ -f tmp/pids/server.pid ]; then
  echo "Removing existing server.pid..."
  rm tmp/pids/server.pid
fi  # Close the second 'if' block

# Execute the passed command
exec "$@"