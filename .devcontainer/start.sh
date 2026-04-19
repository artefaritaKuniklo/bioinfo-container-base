#!/usr/bin/env bash
set -e

echo "Restoring renv environment..."
Rscript -e "renv::restore()"

echo "Preparing micromamba..."
export PATH="$HOME/.local/bin:$PATH"
eval "$("$HOME/.local/bin/micromamba" shell hook -s bash)"

echo "Activating scRNA environment..."
micromamba create -y -n scRNA -f environment.lock

echo "Registering IRkernel..."
micromamba run -n scRNA Rscript --vanilla -e "IRkernel::installspec(user = FALSE)"