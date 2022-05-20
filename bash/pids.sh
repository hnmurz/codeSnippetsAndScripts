#!/bin/bash

return 1;

# $! grabs the last background process's pid in the current shell.
foo &
pid=$!
