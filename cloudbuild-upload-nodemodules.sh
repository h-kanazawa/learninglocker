# Upload compressed node_modules to GCS
#
# Run this script on a official Cloud Build image
# gcr.io/cloud-builders/gsutil

yarnlock_checksum=$(md5sum yarn.lock | cut -d ' ' -f 1)
node_module_path="node_modules/${yarnlock_checksum}.tar.gz"

gsutil -q stat gs://learninglocker-dev-artifact/${node_module_path}
non_exists=$?

if [ ${non_exists} -eq 0 ]; then
    echo "${gzipped_file} already exists in GCS"
else
    tar czf node_modules.tar.gz node_modules
    gsutil cp node_modules.tar.gz gs://learninglocker-dev-artifact/${node_module_path}
    rm node_modules.tar.gz
fi
