#!/bin/bash
# Docker entrypoint script.
cd /home/app
iex --sname $NODE_NAME@$NODE_HOST -S mix
