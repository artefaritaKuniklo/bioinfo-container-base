# Bioinformatics Toolbox Container / 生信基础容器

## Overview / 项目概述
This repository provides a container for **reproducible** single-cell and general bioinformatics purposes, with R and Python tools included. It is designed to organize data, environment configuration, and pipeline scripts for reproducible analysis.

高可复现性单细胞和通用生物信息学容器

## Structure / 目录结构
- `data/` - Raw data files.
- `output/` - Analysis results, figures, and processed outputs, **including intermediate results**.
- `renv/` - R environment package cache.
- `src/` - Analysis scripts, notebooks, and pipeline code.

- `data/` - 原始文件。
- `output/` - 分析结果、图表和处理后输出，**包括中间结果**。
- `renv/` - R 包缓存。
- `src/` - 分析脚本、jupyter notebook/R notebook和其它衔接脚本。

## Requirements / 运行依赖
- Docker
- VS Code with Dev Container extension

- Docker
- devcontainer(vscode)

## Setup / 环境搭建
1. Reopen/rebuild the Dev Container: In the VS Code command palette, search for `devcontainer: reopen in container` or `devcontainer: rebuild container`
2. Once the container build completes, the IR kernel will be automatically registered, making the R kernel available in Jupyter Lab

1. 在 VS Code 命令栏中搜索 `devcontainer: reopen...`
2. 当构建完成后，IRkernel 会自动注册，R 内核即可在 Jupyter Lab 中使用

## Usage / 使用说明

### Features / 特性

1. Integrated `clusterProfiler` with `interpret()` function enables direct LLM analysis of single-cell enrichment analysis results
   > Functions for interpreting functional enrichment analysis results using Large Language Models. Supports single-call interpretation, multi-agent deep analysis, and hierarchical cluster strategies. (from `?interpret`)

1. 实装带 `interpret()` 的 `clusterProfiler` 可使用LLM直接分析单细胞相关富集分析结果

    > Functions for interpreting functional enrichment analysis results using Large Language Models. Supports single-call interpretation, multi-agent deep analysis, and hierarchical cluster strategies. (from desc part of ?interpret)

### Infrastructure & Execution / 脚本运行与容器基础架构

1. By default, commonly used packages such as `iparallel` and `Seurat` are pre-installed. All R packages are locked by the `renv.lock` file, and all conda/mamba packages are locked by the `environment.lock` file. **Do not manually edit version lock files** to avoid inconsistencies between the lock files and the actual environment.
2. By design, `R`, `IRkernel` (the R kernel adapted for Jupyter), and `Rscript` all activate the `renv` environment, ensuring consistent package versions across sessions.

1. 在预期状态下，`iparallel` 和 `Seurat` 等常用软件包已经被安装，所有 `R` 相关来源的包被 `renv.lock` 文件锁定, 所有 `conda/mamba` 相关来源的包被 `environment.lock` 文件锁定，请切勿手动操作版本锁文件以避免引起锁文件和真实环境的不一致
2. 在预期状态下，`R`, `IRkernel (适配 Jupyter 的 R 运行内核包)` 和 `Rscript` 均应当激活 `renv` 环境

### Important Notes / 注意事项

- `renv` maintains its own `.gitignore` settings for package library files.
- Keep `data/` and `output/` out of version control if files are large or generated, which is the default behavior of repo-level `.gitignore` file.

- `renv` 会为包库文件维护自己的 `.gitignore` 设置。
- 如果数据文件较大或为生成文件，建议将 `data/` 和 `output/` 保持在版本控制之外。
