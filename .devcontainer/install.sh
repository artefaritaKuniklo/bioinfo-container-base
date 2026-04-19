#!/usr/bin/env bash
set -e

echo "Installing pak and renv..."
Rscript -e "install.packages('pak', repos = 'https://r-lib.github.io/p/pak/dev/')"
Rscript --vanilla -e "install.packages('IRkernel', lib='/usr/local/lib/R/site-library', repos='https://mirrors.sjtug.sjtu.edu.cn/cran/')"
Rscript -e "pak::pkg_install('renv', ask=FALSE)"
if [ -f "renv.lock" ]; then
  echo "renv.lock already exists, skipping renv::init"
else
  echo "No renv.lock found, initializing renv..."
  Rscript -e "renv::init(bare=TRUE)"
fi
Rscript -e "renv::install('pak', repos = 'https://r-lib.github.io/p/pak/dev/')"

echo "Installing mamba..."
bash .devcontainer/mamba.sh