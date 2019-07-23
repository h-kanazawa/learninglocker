# Download compressed node_modules from GCS
#
# Run this script on a official Cloud Build image
# gcr.io/cloud-builders/gsutil

yarnlock_checksum=$(md5sum yarn.lock | cut -d ' ' -f 1)
node_module_path="node_modules/${yarnlock_checksum}.tar.gz"

gsutil -q stat gs://learninglocker-dev-artifact/${node_module_path}
non_exists=$?

if [ ${non_exists} -eq 1 ]; then
    echo "${node_module_path} is not exist in GCS"
else
    echo "Download node_modules from GCS"
    gsutil cp gs://learninglocker-dev-artifact/${node_module_path} node_modules.tar.gz
    tar xzf node_modules.tar.gz
    rm node_modules.tar.gz
fi
