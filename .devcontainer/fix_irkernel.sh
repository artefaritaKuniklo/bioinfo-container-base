#!/usr/bin/env bash
set -e

echo "[IRkernel Fix] Detecting project root..."

RENV_ACTIVATE=$(find /workspaces -maxdepth 3 -type f -name activate.R | grep "/renv/activate.R" | head -n 1)
if [ -z "$RENV_ACTIVATE" ]; then
    echo "[IRkernel Fix] ERROR: renv/activate.R not found"
    exit 1
fi

PROJECT_ROOT=$(dirname "$(dirname "$RENV_ACTIVATE")")
echo "[IRkernel Fix] Project root detected: $PROJECT_ROOT"

RENV_ACTIVATE="$PROJECT_ROOT/renv/activate.R"
KERNEL_DIR="/usr/local/share/jupyter/kernels/ir_renv"

if [ ! -f "$RENV_ACTIVATE" ]; then
    echo "[IRkernel Fix] ERROR: renv/activate.R not found at $RENV_ACTIVATE"
    exit 1
fi

echo "[IRkernel Fix] Ensuring IRkernel is installed in renv..."
micromamba run -n scRNA Rscript -e "source('$RENV_ACTIVATE'); if (!'IRkernel' %in% installed.packages()[,1]) renv::install('IRkernel')"

echo "[IRkernel Fix] Registering IRkernel with renv..."
micromamba run -n scRNA Rscript -e "source('$RENV_ACTIVATE'); IRkernel::installspec(name='ir_renv', displayname='R (renv)', user=FALSE)"

echo "[IRkernel Fix] Patching kernel.json to force renv activation..."
cat > $KERNEL_DIR/kernel.json <<EOF
{
  "argv": [
    "bash",
    "-c",
    "cd '$PROJECT_ROOT'; /usr/local/lib/R/bin/R --slave -e \"source('renv/activate.R'); IRkernel::main()\" --args {connection_file}"
  ],
  "display_name": "R (renv)",
  "language": "R"
}
EOF

echo "[IRkernel Fix] Verifying renv activation..."
micromamba run -n scRNA bash -c "cd '$PROJECT_ROOT'; Rscript -e \"source('renv/activate.R'); print(.libPaths()); library(IRkernel); cat('IRkernel loaded successfully\n')\""

echo "[IRkernel Fix] Completed successfully."
