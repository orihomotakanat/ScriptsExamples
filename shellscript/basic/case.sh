#!/bin/bash

case "$1" in
  swift|ruby)
    echo "My favorites"
    ;;
  js|shell|java)
    echo "Want to study"
    ;;
  *)
    echo "I don't understand"
    ;;
esac
