# Writing an ETL Plugin for GenomicsDB

This guide explains how to create a new ETL plugin for the GenomicsDB ETL framework. Plugins orchestrate extract, transform, and load (ETL) operations, and are managed by the pipeline system. All plugins must inherit from `AbstractBasePlugin` and implement its required (abstract) methods.

## Code Organization

For the NIAGADS Alzheimer's GenomicsDB, all ETL plugins should be saved in the [`bases/niagads/genomicsdb_service/etl/plugins`](https://github.com/NIAGADS/niagads-pylib/tree/bda5cfc5dffc2e1073edca8a18896ef403d0cc9a/bases/niagads/genomicsdb_service/etl/plugins) directory in the [`niagads-pylib`](https://github.com/NIAGADS/niagads-pylib) project.  ETL plugins are part of the business logic and are considered a `base`-type brick in the `Polylith` software architecture.  

Supporting infrastructure:

* [CLI Plugin Runner](https://github.com/NIAGADS/niagads-pylib/blob/bda5cfc5dffc2e1073edca8a18896ef403d0cc9a/bases/niagads/pipeline_service/runners/plugin.py) - allows users to run plugins independently of a pipeline from the command line and/or integrate a plugin with other scripts.  Run using `runpipe-plugin`.  See the [Running a Plugin](#running-a-plugin) section below.

* [Plugin Base Code](https://github.com/NIAGADS/niagads-pylib/tree/bda5cfc5dffc2e1073edca8a18896ef403d0cc9a/components/niagads/etl/plugins) - reusable `component`-type bricks that define the basic functionality of an ETL plugin, including, ETL logic, parameter defaults and handling, logging, and the plugin registry.

## Plugin Structure

A _plugin_ is a Python class that inherits from [`AbstractBasePlugin`](https://github.com/NIAGADS/niagads-pylib/blob/main/components/niagads/etl/plugins/base.py). It must implement the following abstract methods and properties:

- `description`: Returns a string describing the plugin.
- `parameter_model`: Returns a Pydantic model class for plugin parameters (subclass of `BasePluginParams`).
- `operation`: Returns the `ETLOperation` type for the plugin.
- `affected_tables`: Returns a list of database tables (`schema.table`) affected by the plugin.
- `streaming`: Boolean indicating if the plugin E & T steps process records one-by-one (streaming) or in bulk.
- `extract`: Extracts records from the data source.
- `transform`: Transforms extracted data.
- `load`: Asynchronously loads transformed data into the database.
- `get_record_id`: Returns a unique identifier for a record (used for creating checkpoints for resumes points).

## Example: SimpleTextLoaderPlugin

Below is a simplified example of how to implement a plugin that loads and processes a plain text file, illustrating the required structure and methods.

```python
from niagads.etl.plugins.base import AbstractBasePlugin
from niagads.etl.plugins.parameters import BasePluginParams, PathValidatorMixin
from niagads.genomicsdb.models.admin.pipeline import ETLOperation
from pydantic import Field

class SimpleTextLoaderParams(BasePluginParams, PathValidatorMixin):
    file: str = Field(..., description="text file to load")

    # add validatio check to ensure that the file passed to the `file`
    # parameter exists
    validate_file_exists = PathValidatorMixin.validator("file", is_dir=False)

class SimpleTextLoaderPlugin(AbstractBasePlugin):
    _params: SimpleTextLoaderParams # type annotation

    @classmethod
    def description(cls):
        return "Loads and processes lines from a plain tab-delimited text file."

    @classmethod
    def parameter_model(cls):
        return SimpleTextLoaderParams

    @property
    def operation(self):
        return ETLOperation.INSERT

    @property
    def affected_tables(self):
        return ["genomicsdb.text_table"]

    @property
    def streaming(self):
        return True

    def extract(self):
        # Parse header and yield each line as a dict mapping header to values
        with open(self._params.file) as f:
            header = next(f).strip().split("\t")  # assumes tab-delimited
            for line in f:
                fields = line.strip().split("\t")
                yield dict(zip(header, fields))

    def transform(self, data):
        # Example: convert all values to uppercase
        return {k: v.upper() for k, v in data.items()}

    async def load(self, transformed, mode):
        # Example: pretend to load records into DB
        # Replace with actual DB logic as needed
        print(f"Loaded {len(transformed)} records: {transformed}")
        return len(transformed)

    def get_record_id(self, record):
        # assume data had an id field for demonstration
        return record["id"]
```

## Key Points

- **Parameter Model**: Define a Pydantic model for plugin parameters. Inherit from [`BasePluginParams`](https://github.com/NIAGADS/niagads-pylib/blob/bda5cfc5dffc2e1073edca8a18896ef403d0cc9a/components/niagads/etl/plugins/parameters.py#L25) and add any plugin-specific fields.  Make sure to add any necessary validation.  Notice how the validation can be handled directly by the Pydantic model.  See the [`PathValidatorMixin`](https://github.com/NIAGADS/niagads-pylib/blob/bda5cfc5dffc2e1073edca8a18896ef403d0cc9a/components/niagads/etl/plugins/parameters.py#L73) for an example.
- **Streaming vs Bulk**: Set the `streaming` property. If `True`, records are processed line by line and loaded in batches; if `False`, the ET stage processes the entire dataset at once (bulk).  Loading will still be in batches according to the `commit_after` setting.
- **ETL Methods**: Implement `extract`, `transform`, and `load` methods. Use `self.__session_manager` for loading data.
- **Checkpointing**: Implement `get_record_id` to support resume and checkpoint features.  If `record_id` is not relevant to your task, have `get_record_id` simply return `None`; the checkpoint will use a `line number` instead.
- **Logging**: Use `self.logger` for JSON logging and status updates. 
- **Error Handling**: Enclose any codeblock in the ETL functions that may raise an error in `try/except` block to ensure that the error gets raised.  Failure to do so will lead to the plugin to exit with status `FAIL` without providing a stack-trace.

See the [`XMLRecordLoader` plugin](https://github.com/NIAGADS/niagads-pylib/blob/bda5cfc5dffc2e1073edca8a18896ef403d0cc9a/bases/niagads/genomicsdb_service/etl/plugins/xml.py) for an example of how to write a plugin, including logging and error handling.

## Running a Plugin

Plugins can be run via the CLI, programmatically, or through the ETL Pipeline Mangaer. Command line usage is illustrated below using the `XMLRecordLoader` plugin:

From within the project (e.g. during development):

```bash
poetry run runpipe-plugin XMLRecordLoader --file test.xml --mode DRY_RUN
```

From outside the project by activating the virtual environment.  First find the path to the virtual environment by executing:

```bash
poetry env activate
```

This will display the command to activate the environment, copy that command and run it. e.g.,

```bash
source /projects/genomicsdb/niagads-pylib/.venv/bin/activate
```

You should then be able to execute the plugin runner without having to call `poetry run`, e.g.,

```bash
runpipe-plugin XMLRecordLoader --file test.xml --mode DRY_RUN
```

To get plugin usage add the `--help` option:

```bash
runpipe-plugin XMLRecordLoader --help
```

For more details, see the documentation for `AbstractBasePlugin` and existing plugins in the repository at `bases/niagads/genomicsdb/etl/plugins`.
