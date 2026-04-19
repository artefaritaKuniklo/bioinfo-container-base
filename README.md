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
- docker
- devcontainer(vscode)

## Setup / 环境搭建
1. Reopen/rebuild the devcontainer: in cmd pallet of vscode search `devcontainer: reopen...`
2. When the building process finished the IRkernel will be auto-registered so the R kernel will be usable in jupyter-lab

3. Reopen/rebuild devcontainer: 打开vscode命令栏，搜索 `devcontainer: reopen...`
4. 当构建完成后，IRkernel 会自动注册，R 内核即可在 Jupyter Lab 中使用

## Notes / 说明
- `renv` maintains its own `.gitignore` settings for package library files.
- Keep `data/` and `output/` out of version control if files are large or generated, which is the default behavior of repo-level `.gitignore` file.

- `renv` 会为包库文件维护自己的 `.gitignore` 设置。
- 如果数据文件较大或为生成文件，建议将 `data/` 和 `output/` 保持在版本控制之外。
