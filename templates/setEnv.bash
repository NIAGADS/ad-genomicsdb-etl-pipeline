export PROJECT_DIR=root-project-directory
export DATA_DIR=full-path-to-data-directory
export CONFIG_DIR=$PROJECT_DIR/ad-genomicsdb-etl-pipeline/pipeline
export DATABASE_URI=postgresql://<user>:<pwd>@<host>:<port>/<database>

# recolor prompt so you know when this env is activated

PURPLE="\[\033[01;35m\]"
GREEN="\[\033[01;32m\]"
RESET="\[\033[00m\]"

PS1="${GREEN}[gdb-env]@\h${RESET}:${PURPLE}\w${RESET}\$ "

# activate python env
source $PROJECT_DIR/niagads-pylib/.venv/bin/activate
