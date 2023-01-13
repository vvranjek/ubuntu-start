#!/bin/env bash

usage()
{
  echo -e "Usage:"
  echo -e "\t$(basename $(readlink -f "${BASH_SOURCE[0]}")) [options]"
  echo -e ""
  echo -e "Options:"
  echo -e "\t-e, --example <example>\t\texample text."
  echo -e "\t-h, --help <helpp>\t\tDisplay this help message"
}

while [ "$1" != "" ]; do
  case $1 in
    -e | --exa | --example )  shift
                                  EXAMPLE="$1"
                                  ;;
    -h | --help)                  shift
                                  usage
                                  exit 0
                                  ;;
  esac
  shift
done

if [ "$EXAMPLE" = '' ];
then
    echo "Error: Missing arguments"
    usage
    exit 0
fi

exit 0

