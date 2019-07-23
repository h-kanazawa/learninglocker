# Download */dist from GCS
#
# Run this script on a official Cloud Build image
# gcr.io/cloud-builders/gsutil

yarnlock_checksum=$(md5sum yarn.lock | cut -d ' ' -f 1)
lib_checksum=$(git log --oneline -1 --pretty=format:'%H' -- lib)
ui_checksum=$(git log --oneline -1 --pretty=format:'%H' -- ui)
api_checksum=$(git log --oneline -1 --pretty=format:'%H' -- api)
worker_checksum=$(git log --oneline -1 --pretty=format:'%H' -- worker)
cli_checksum=$(git log --oneline -1 --pretty=format:'%H' -- cli)

ui_path="ui/${yarnlock_checksum}-${lib_checksum}-${ui_checksum}.tar.gz"
api_path="api/${yarnlock_checksum}-${lib_checksum}-${api_checksum}.tar.gz"
worker_path="worker/${yarnlock_checksum}-${lib_checksum}-${worker_checksum}.tar.gz"
cli_path="cli/${yarnlock_checksum}-${lib_checksum}-${cli_checksum}.tar.gz"

gsutil -q stat gs://learninglocker-dev-artifact/${ui_path}
non_exists_ui=$?
gsutil -q stat gs://learninglocker-dev-artifact/${api_path}
non_exists_api=$?
gsutil -q stat gs://learninglocker-dev-artifact/${worker_path}
non_exists_worker=$?
gsutil -q stat gs://learninglocker-dev-artifact/${cli_path}
non_exists_cli=$?

if [ ${non_exists_ui} -eq 1 ]; then
    echo "${ui_path} is not exist in GCS"
else
    echo "Download ui/dist from GCS"
    gsutil cp gs://learninglocker-dev-artifact/${ui_path} ui/dist.tar.gz
    tar xzf ui/dist.tar.gz
    rm ui/dist.tar.gz
fi

if [ ${non_exists_api} -eq 1 ]; then
    echo "${api_path} is not exist in GCS"
else
    echo "Download api/dist from GCS"
    gsutil cp gs://learninglocker-dev-artifact/${api_path} api/dist.tar.gz
    tar xzf api/dist.tar.gz
    rm api/dist.tar.gz
fi

if [ ${non_exists_worker} -eq 1 ]; then
    echo "${worker_path} is not exist in GCS"
else
    echo "Download worker/dist from GCS"
    gsutil cp gs://learninglocker-dev-artifact/${worker_path} worker/dist.tar.gz
    tar xzf worker/dist.tar.gz
    rm worker/dist.tar.gz
fi

if [ ${non_exists_cli} -eq 1 ]; then
    echo "${cli_path} is not exist in GCS"
else
    echo "Download cli/dist from GCS"
    gsutil cp gs://learninglocker-dev-artifact/${cli_path} cli/dist.tar.gz
    tar xzf cli/dist.tar.gz
    rm cli/dist.tar.gz
fi
