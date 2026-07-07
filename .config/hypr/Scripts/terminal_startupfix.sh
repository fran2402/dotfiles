#!/bin/bash

# Wait for 1 second
sleep 1.5

# Launch the kitty terminal, run sleep 0.05, and then exit
kitty -- bash -c "sleep 0.05; exit"

