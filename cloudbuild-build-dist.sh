# Build */dist
#
# Run this script on a official Cloud Build image
# eu.gcr.io/$PROJECT_ID/learninglocker.build

if [ -e ui/dist ]; then
    echo "ui has been already built"
else
    yarn build-ui-server
    yarn build-ui-client
fi

if [ -e api/dist ]; then
    echo "api has been already built"
else
    yarn build-api-server
fi

if [ -e cli/dist ]; then
    echo "cli has been already built"
else
    yarn build-cli-server
fi

if [ -e worker/dist ]; then
    echo "worker has been already built"
else
    yarn build-worker-server
fi
