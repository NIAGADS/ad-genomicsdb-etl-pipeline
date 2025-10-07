# Alzheimer's Disease GenomicsDB - Database and ETL Pipeline

Internal Issue Tracking Repository for NIAGADS Alzheimer's GenomicsDB Database and ETL Pipeline

## Documentation

### ETL Pipeline and Plugin System

The ETL pipeline automates data extraction, transformation, and loading into the target database using a flexible plugin architecture. Plugins handle specific data formats and business logic, while the pipeline manager coordinates their execution, supports checkpointing, and enables rapid development of new data processing tasks.

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
