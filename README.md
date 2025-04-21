# ScriptHub

> Just a couple of automation scripts, purely because I'm too lazy to do it manually.

## Reference Template

The structure under the template directory is as follows:

```
template/
    ├─ src/
    |   ├─ cleanup.sh
    |   └─ init.sh
    ├─ .env
    └─ run.sh

```

The `src` directory is used to store all scripts.


The `.env` file stores the execution order of the scripts.

The `run.sh` file is the default execution script. It identifies the list of files within `src` and `.env`, executes them if they exist, and stops if any execution fails.