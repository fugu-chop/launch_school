#!/usr/local/bin/bash

greeting () {
  echo This is the greeting function.
  echo Hello $1
}

greeting 'Peter' 

salutation () {
  echo This is the saluation function.
  echo "Hello $1"
  echo "Hello $2"
}

salutation 'Peter' 'Paul' 
