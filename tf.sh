#!/bin/bash
set -e

### simple wrapper for working with terraform ###

# functions
log() {
  echo "* [${2:-INFO}] $1"
}

die() {
  >&2 log "$1" "ERROR"
  exit 1
}

# get arguments
while getopts ':a:e:x:' OPT; do
  case $OPT in
    a)  action=$OPTARG;;
    e)  env=$OPTARG;;
    x)  xtraopts=$OPTARG;;
  esac
done

# vars
cwd=$(dirname $0)
env_tfvars="${cwd}/environments/${env}.tfvars"
state_file=${cwd}/state/${env}.tfstate

# usage
HELP="
  usage: $0 [ -a value -e value -x 'value(s)' ]

     -a --> action: plan, push, apply
     -e --> environment: management, dev, test, prod etc.
     -x --> extra options: terraform args (optional)
"

# test input vars
if [ -z "$action" -o -z "$env" ]; then
  echo "$HELP"
  die "Required args not entered"
fi

# test env vars
env_vars="
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_DEFAULT_REGION
"

count=0
for var in $env_vars; do
  if [ -z "${!var:-}" ]; then
    log "Environment variable $var is unset"
    ((count++))
  fi
done

# exit if all not set
if [ "$count" -ne 0 ]; then
  die "One or more environment variables are unset"
fi

# test env config
if [ ! -e "$env_tfvars" ]; then
  die "Environment tfvars do not exist for $env"
fi

# define role
if [ -d "roles/$env" ]; then
  role="roles/${env}"
else
  role="roles/shared"
fi

# main
terraform get $role || die 'Failed to terraform get'
terraform $action \
  -state="$state_file" \
  -var "environment=${env}" \
  -var-file="$env_tfvars" \
  $xtraopts \
  $role || die 'Failed to run terraform'
