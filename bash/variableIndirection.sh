#!/bin/bash

foo="AAAA"
bar=foo

printf "%s\n" ${bar}
printf "%s\n" ${!bar}

