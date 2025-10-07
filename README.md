# Alzheimer's Disease GenomicsDB - Database and ETL Pipeline

Internal Issue Tracking Repository for NIAGADS Alzheimer's GenomicsDB Database and ETL Pipeline

## Documentation

### ETL Pipeline and Plugin System

An ETL (Extract, Transform, Load) pipeline is a modular system designed to automate the movement and transformation of data from source files or databases into a target data warehouse or application. In this project, the ETL pipeline is built around a flexible plugin architecture, allowing developers to implement custom plugins for data loads.  The pipeline also supports scripts for fetching or preprocessing data and validation (e.g., md5sum checks) tasks.

Plugins encapsulate the logic for extracting data from various formats, transforming it according to business logic, and loading it into the database. The pipeline manager orchestrates the execution of these plugins, supporting features such as parallel task execution, checkpointing, and configurable workflows. Although not yet implemented, the pipeline manager is designed to support dependency graphs in the future.  This approach enables rapid development, testing, and extension of new data processing tasks while maintaining a clear separation of concerns and reusable code components.

* [Plugin HOW-TO](plugins.md)
* Pipeline Manager HOW-TO

## Getting Started

### Required Software

* for Python environment setup, see: the [NIAGADS-pylib documentation](https://github.com/NIAGADS/niagads-pylib?tab=readme-ov-file#developers)

### Recommended Software

* [VSCode](https://code.visualstudio.com/)

### Required VSCode Plugins

* [Python Extension Pack](https://marketplace.visualstudio.com/items?itemName=donjayamanne.python-extension-pack)
* [autoDocstring](https://marketplace.visualstudio.com/items?itemName=njpwerner.autodocstring) **configure to use Google-style docstrings**
* [Black Formatter](https://marketplace.visualstudio.com/items?itemName=ms-python.black-formatter)
* [isort](https://marketplace.visualstudio.com/items?itemName=ms-python.isort)
* [Pylance](https://marketplace.visualstudio.com/items?itemName=ms-python.vscode-pylance)
* [Even Better TOML](https://marketplace.visualstudio.com/items?itemName=tamasfe.even-better-toml)

### Recommended VSCode Plugins

* [indent-rainbow](https://marketplace.visualstudio.com/items?itemName=oderwat.indent-rainbow)
* [Jupyter](https://marketplace.visualstudio.com/items?itemName=ms-toolsai.jupyter)
* [Python Indent](https://marketplace.visualstudio.com/items?itemName=KevinRose.vsc-python-indent)
* [Todo Tree](https://marketplace.visualstudio.com/items?itemName=Gruntfuggly.todo-tree)

### Helpful Online Tools

* [Online Python](https://www.online-python.com/)
* [Regular Expression Tester](https://regex101.com/)
* [JSON Editor Online](https://jsoneditoronline.org)
