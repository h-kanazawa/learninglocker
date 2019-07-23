# Upload compressed */dist to GCS
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

if [ ${non_exists_ui} -eq 0 ]; then
    echo "${ui_path} already exists in GCS"
else
    tar czf ui/dist.tar.gz ui/dist
    gsutil cp ui/dist.tar.gz gs://learninglocker-dev-artifact/${ui_path}
    rm ui/dist.tar.gz
    echo "Upload ui/dist to GCS ${ui_path}"
fi

if [ ${non_exists_api} -eq 0 ]; then
    echo "${api_path} already exists in GCS"
else
    tar czf api/dist.tar.gz api/dist
    gsutil cp api/dist.tar.gz gs://learninglocker-dev-artifact/${api_path}
    rm api/dist.tar.gz
    echo "Upload api/dist to GCS ${api_path}"
fi

if [ ${non_exists_worker} -eq 0 ]; then
    echo "${worker_path} already exists in GCS"
else
    tar czf worker/dist.tar.gz worker/dist
    gsutil cp worker/dist.tar.gz gs://learninglocker-dev-artifact/${worker_path}
    rm worker/dist.tar.gz
    echo "Upload worker/dist to GCS ${worker_path}"
fi

if [ ${non_exists_cli} -eq 0 ]; then
    echo "${cli_path} already exists in GCS"
else
    tar czf cli/dist.tar.gz cli/dist
    gsutil cp cli/dist.tar.gz gs://learninglocker-dev-artifact/${cli_path}
    rm cli/dist.tar.gz
    echo "Upload cli/dist to GCS ${cli_path}"
fi
