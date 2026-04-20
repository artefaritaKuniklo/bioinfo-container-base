#!/usr/bin/env bash
set -e

echo "Installing pak and renv..."
Rscript -e "install.packages('pak', repos = 'https://r-lib.github.io/p/pak/dev/')"
Rscript --vanilla -e "install.packages('rprojroot', repos='https://mirrors.sjtug.sjtu.edu.cn/cran/')"
Rscript -e "install.packages('renv', repos='https://mirrors.sjtug.sjtu.edu.cn/cran/')"
if [ -f "renv.lock" ]; then
  echo "renv.lock already exists, skipping renv::init"
else
  echo "No renv.lock found, initializing renv..."
  Rscript -e "renv::init(bare=TRUE)"
fi
# Rscript -e "renv::install('pak', repos = 'https://r-lib.github.io/p/pak/dev/')"

echo "Installing mamba..."
bash .devcontainer/mamba.sh

echo "[DevContainer] Creating renv auto-activation script..."
mkdir -p /usr/local/lib/R/etc
cat << 'EOF' > /usr/local/lib/R/etc/renv_auto_activate.R
find_project_root <- function(start = getwd()) {
  current <- normalizePath(start, mustWork = TRUE)
  repeat {
    candidate <- file.path(current, "renv", "activate.R")
    if (file.exists(candidate)) return(candidate)
    parent <- dirname(current)
    if (parent == current) break
    current <- parent
  }
  return(NULL)
}

activate <- find_project_root()

if (!is.null(activate)) {
  project_root <- dirname(dirname(activate))
  current_dir <- normalizePath(getwd())
  if (current_dir != normalizePath(project_root)) {
    message("Warning: Activating renv from non-project root directory. Current: ", current_dir, " Project root: ", project_root)
  }
  message("Activating renv from: ", activate)
  source(activate)
} else {
  message("No renv project detected")
}
EOF

echo "[DevContainer] renv auto-activation script created."