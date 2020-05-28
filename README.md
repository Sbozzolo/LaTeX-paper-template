# Template for scientific papers in LaTeX

## Features

- `.gitignore` for LaTeX. (`pdf` files will not be included in the repo to avoid
  conflicts)
- Compile with `make`
- Compile images with `pgfplots`
- Compile automatically on GitHub with GitHub actions
- (NOT IMPLEMENTED YET) Pre-process paper to prepare an arXiv submission tarball

## Setting up the paper

Before making any edits, you have to properly set up the paper. This template
contains strings that have to be replaced with the correct values, e.g., the
name of the paper. The template is designed to use the name of the repository as
the base name for all the files.

Edit the file `setup.sh` with your information, then run `setup.sh`. This has to
be done only the first time.

You can copy a `.bib` file to this current repo by customizing the variable
`BIBFILE_PATH` in `setup.sh`.

## Figures

The preferred way to generate figures is with the objectively superior
[pgfplots](http://pgfplots.sourceforge.net/). With `pgfplots`, your figures
always look perfectly consistent with the rest of the paper. You don't have to
worry about font, or readability, or anything else. Plus, `pgfplots` images have
great archival value: they contain all the data, so you can retrieve your data
years later their generation.

### Compile and use the figures

Place your files in the `figures` directory making sure that they have extension
`.tikz`. You can compile a single image with `make img IMG=NAMEOFIMAGE`, where
`NAMEOFIMAGE` is the filename (without the `tikz` extension). Alternatively, you
can compile all the images with `./compile_all_images.sh`. To include an image
in the in the `.tex` file, use `includegraphics` and include the figure in the
`figures_ext` folder, which contains the compiled images in `pdf` format.

You may need to edit the preamble of the `img_generator.tex` file to add
additional packages or to change the class so that it matches the one of the
paper.
