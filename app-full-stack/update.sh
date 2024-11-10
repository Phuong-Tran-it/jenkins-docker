#!/bin/bash

# Configuration
FRONTEND_REPO="phuongtn20/frontend-app"
BACKEND_REPO="phuongtn20/backend-app"
ENV_FILE=".env"

# Function to get latest tag by date
get_latest_tag() {
    local repository=$1
    latest_tag=$(curl -s "https://hub.docker.com/v2/repositories/${repository}/tags?page_size=100" | \
        jq -r '.results | sort_by(.last_updated) | reverse | .[0].name')
    echo $latest_tag
}  

# Get latest tags
FRONTEND_TAG=$(get_latest_tag $FRONTEND_REPO)
BACKEND_TAG=$(get_latest_tag $BACKEND_REPO)

# Update .env file
cat > $ENV_FILE << EOF
FRONTEND_REPO="phuongtn20/frontend-app"
BACKEND_REPO="phuongtn20/backend-app"
FRONTEND_TAG=${FRONTEND_TAG}
BACKEND_TAG=${BACKEND_TAG}
EOF

echo "Updated tags:"
echo "Frontend: ${FRONTEND_TAG}"
echo "Backend: ${BACKEND_TAG}"

docker compose down
docker compose up -d
