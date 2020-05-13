# A GitHub Action for Agda

This is a GitHub action for typechecking your Agda code. It also runs
`agda --html` on your code so you can access the generated HTML.

My aim in building this action was to be able to publish the generated HTML on
GitHub Pages, but as far as I understand it, the design of GitHub Pages makes
this hard to do. If you know how to do this in an easy way please open up an
issue so we can add that feature.

## Usage

To be able to use this action, there should be a single file in your Agda
development that you want to typecheck. If this is not the case, add a new root
file that imports all the other files you are interested in typechecking.
Assuming that such a file, say `Foo.agda`, exists, you just need to create a
file `.github/workflows/main.yml` in your repository that has the content:

```
on: [push]

jobs:
  typechecking:
    runs-on: ubuntu-latest
    name: Typechecking
    steps:
    - name: "Clone repository"
      uses: actions/checkout@v2
    - name: Run Agda
      id: typecheck
      uses: ayberkt/agda-github-action@v1.1
      with:
        main-file: Foo.agda
        source-dir: src
    - name: Upload HTML
      id: html-upload
      uses: actions/upload-artifact@v1
      with:
        name: html
        path: html
```

So, you provide two arguments to this action: the name of your root file and the
directory in which that file lives (e.g., `src`).
