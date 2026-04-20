#!/usr/bin/env bash
set -e

echo "[IRkernel Fix] Detecting renv activate..."
RENV_ACTIVATE=$(find /workspaces -maxdepth 3 -type f -name activate.R | grep "/renv/activate.R" | head -n 1)
if [ -z "$RENV_ACTIVATE" ]; then
    echo "[ERROR] renv/activate.R not found"
    exit 1
fi
PROJECT_ROOT=$(dirname "$(dirname "$RENV_ACTIVATE")")

echo "Restoring renv environment..."
Rscript -e "setwd(dirname('$RENV_ACTIVATE')); renv::restore()"

echo "Preparing micromamba..."
export PATH="$HOME/.local/bin:$PATH"
eval "$("$HOME/.local/bin/micromamba" shell hook -s bash)"

echo "Activating scRNA environment..."
micromamba create -y -n scRNA -f "$PROJECT_ROOT/environment.lock"

echo "Registering IRkernel..."
micromamba run -n scRNA Rscript -e "source('$RENV_ACTIVATE'); IRkernel::installspec(name = 'ir_renv', displayname = 'R (renv)', user=FALSE)"

echo "Fixing IRkernel..."
bash .devcontainer/fix_irkernel.sh