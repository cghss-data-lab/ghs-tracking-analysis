# GHS Tracking analyses
This repository contains descriptions of GHS Tracking analyses and the code needed to perform them. Where applicable, artifacts representing the analyses outputs are included.

## Getting started
To run many of the analyses, access to the GHS Tracking database server is required, and to use many of the provided terminal commands, a configured `~/.pg_service.conf` file is required. See below for how to set these up.

### Accessing the GHS Tracking database server
TODO

### Configuring PostgreSQL services
TODO

## Running analyses
The directory [`analyses`](./analyses/) contains one directory per analysis. Each of those contains a `README.md` detailing the analysis and providing instructions for how to run it, if possible.

### One-time PostgreSQL service setup
Most analyses require a PostgreSQL service named `tracking-analysis` to be defined as follows.
1. Create the file `~/.pg_service.conf` by doing terminal command
    ```bash
    touch ~/.pg_service.conf
    ```
1. Open that file in your preferred text editor.
1. Add the following to `~/.pg_service.conf`, replacing `SECRET` with your connection information, and save.
    ```text
    [tracking-analysis]
    host=SECRET
    port=5432
    user=SECRET
    dbname=SECRET
    password=SECRET
    ```
## Adding analyses
Then, follow this checklist to add a new analysis.
1. Make a copy of the directory [./analyses/Template](./analyses/Template) in its parent directory [./analyses](./analyses) with your system file explorer or with terminal command
    ```bash
    cp -R Template/ "New analysis"
    ```
1. Rename the copy to the sentence-case, plain language name of your analysis in ~45 characters or fewer, e.g., `Top intl org funders of countries subtotals`
1. Go to that directory, which we'll refer to as `./analyses/New analysis` for this checklist
1. In `./analyses/New analysis/code/analysis.sql`, replace the contents of the file with your SQL query, ensuring you do NOT end it with a semicolon
1. In `./analyses/New analysis/README.md`, replace template placeholders with your own content.
1. While in directory `./analyses/New analysis`, do the following terminal command to run your analysis:
    ```bash
    bash run.sh
    ```
1. After, look in `./analyses/New analysis/results` for your results.

## Status of analyses
You may be looking for the GHS Tracking analysis status tracker, which is available in Airtable here: https://airtable.com/appyn4yMynjyHEE93/tblO4QET69ywVnf0L/viwNWdiueEBIdKjnj?blocks=hide
