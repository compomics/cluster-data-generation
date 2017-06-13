#!/bin/sh

##### OPTIONS
OUTPUT_PATH=$1
FILTER_XML=$2
INPUT_PATH=$3

# Log file name
LOG_FILE_NAME=$(basename ${INPUT_PATH})
MEMORY_LIMIT=40000
JOB_EMAIL="pride-report@ebi.ac.uk"

##### RUN it on the production LSF cluster
## this is not queued in the PRIDE LSF submission group, this is submitted as regular job as it is independent of any other job
bsub -M ${MEMORY_LIMIT} -R "rusage[mem=${MEMORY_LIMIT}]" -q production-rh7 -o /dev/null -g /spectra_cluster_exporter -u ${JOB_EMAIL} -J PRIDE-CLUSTER-EXPORT ./runJava.sh ./log/${LOG_FILE_NAME}.log ${MEMORY_LIMIT}m -jar ${project.build.finalName}.jar ${OUTPUT_PATH} ${FILTER_XML} ${INPUT_PATH}