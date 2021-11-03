## Intro
0. What is Snakemake?

## Basics
1. Traditional (pre-Snakemake) workflow:

```
.
├── README.md
├── inputs/
│   ├── little_women_part_1.txt
│   └── little_women_part_2.txt
└── traditional_shell_workflow/
    └── workflow.sh*

```
> Pro-tip: Don't try to learn a new workflow and learn Snakemake at
> the same time. Learn Snakemake with a very simple example or known workflow.

_Little Women_ (1868 by Luisa May Alcott) is a two-part  novel centered on the
story of four sisters in the March family: Jo, Amy, Laurie, and Beth.
**Which of the March sisters is referred to most often in part 1 of the book?**

Review a traditional bash shell approach in `traditional_shell_workflow/workflow.sh`.

2. A basic Snakefile and basic Snakemake commands

> Pro-tip: Put inputs, outputs, and workflow in separate dirs.

  - rule split_words
    - interpreting snakemake output
    > Pro-tip: Keep output file names consistent with rule names.

  - rule count_words
    - `snakemake -c2 -l`
    - `snakemake -c2 -n count_words`
    - `shell`: using `{input}` `{output}` variables
    - "Nothing to be done"

  - rule sort_counts
    - multiline blocks, double {{}}

  - rule select_words
    - add header line to output
    - naming targets by filename
    - `all` rule
    - `params` and using configuration file
    - `snakemake -c2 -F` # force all

> Pro-tip: Test your Snakefile incrementally after making smallish changes

  - Filename wildcards
    - manual lists
    - config and expand function

- rule summarize_counts
  - `shell` vs `run` vs `script`
```
rule summarize_counts:
    input:
        expand("outputs/{x}.select_words.txt",
            x = config['input_base_files'])
    output:
        "outputs/summarize_counts.txt"
    script: 'scripts/summarize_counts.py'
```

- Visualizing DAG
```
snakemake -c4 --dag | dot -Tpdf > dag.pdf && open dag.pdf
snakemake -c4 --rulegraph | dot -Tpdf > rulegraph.pdf && open rulegraph.pdf
```

## Next steps
- Named inputs/outputs
- Resource requirements
- Environment management with conda/mamba and Docker/Singularity
- HPC execution
- [Snakefile grammar](https://snakemake.readthedocs.io/en/stable/snakefiles/writing_snakefiles.html#grammar) is extensive: 
```
input        = "input" ":" parameter_list
output       = "output" ":" parameter_list
params       = "params" ":" parameter_list
log          = "log" ":" parameter_list
benchmark    = "benchmark" ":" statement
cache        = "cache" ":" bool
message      = "message" ":" stringliteral
threads      = "threads" ":" integer
resources    = "resources" ":" parameter_list
version      = "version" ":" statement
conda        = "conda" ":" stringliteral
container    = "container" ":" stringliteral
run          = "run" ":" ni statement
shell        = "shell" ":" stringliteral
script       = "script" ":" stringliteral
notebook     = "notebook" ":" stringliteral
moduleparams = [ni snakefile] [ni metawrapper] [ni config] [ni skipval]
snakefile    = "snakefile" ":" stringliteral
metawrapper  = "meta_wrapper" ":" stringliteral
config       = "config" ":" stringliteral
skipval      = "skip_validation" ":" stringliteral
```

> Pro-tip: Test your Snakefile on a non-HPC system or use very small
> test inputs on the login-nodes before configuring/optimizing for scheduled
> execution.

## Links
- https://snakemake.github.io/
- https://snakemake.readthedocs.io/en/stable/snakefiles/deployment.html
- https://www.gutenberg.org/
