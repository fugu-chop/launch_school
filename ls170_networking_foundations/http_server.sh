#!/usr/local/bin/bash

function server () {
  echo Server running on ${BASH_VERSION}
  while [ true ]
  do
    read method path version
    if [[ $method = 'GET' ]]
    then
      echo HTTP/1.1 200 OK
    else
      echo HTTP/1.1 400 Bad Request
    fi
    echo $method $path $version
  done
}

coproc SERVER_PROCESS { server; }

nc -lv 2345 <&${SERVER_PROCESS[0]} >&${SERVER_PROCESS[1]}
