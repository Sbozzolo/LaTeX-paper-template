#!/bin/sh

# This script customizes the template for the specific paper

# In particular, setup.sh
# - Changes the name of the files with the base name of the current repository
# - Sets up the preferred LaTeX engine
# - Sets up paper title, name, email, affiliation
# - Copy the bib file here (if it is BIBFILE_PATH)
# - (More features in the future)

# Paper information. CUSTOMIZE HERE!

# The template sets one author. You can add the other ones later.
TITLE="Template for a paper"
AUTHOR="Gabriele Bozzola"
EMAIL="gabrielebozzola@arizona.edu"
AFFILIATION="Department of Astronomy, University of Arizona, Tucson, AZ, USA"

BIBFILE_PATH="$HOME/documents/papers/bibliography.bib"

# Make sure to have shell-escape to properly compile figures
LATEX_EXE="latexmk"
LATEX_ARGS="-pdf --synctex=1 -interaction=nonstopmode -file-line-error -shell-escape"

# No need to look further, all the customization is above

# Get name of the root directory of the git repository
name=$(basename `git rev-parse --show-toplevel`)

sed -e "s/PAPERNAME/$name/g" \
    -e "s/LATEXEXE/$LATEX_EXE/g" \
    -e "s/LATEXARGS/$LATEX_ARGS/g" Makefile_template > Makefile

sed -e "s/PAPERNAME/$name/g" prepare_arxiv_sub_template.sh > prepare_arxiv_sub.sh

sed -e "s/PAPERNAME/$name/g" \
    -e "s/LATEXARGS/$LATEX_ARGS/g" compile_template.yml > .github/workflows/compile.yml

# We save it in a _tmp because we have to handle bibliography

sed -e "s/PAPERAUTHOR/$AUTHOR/g" \
    -e "s/PAPEREMAIL/$EMAIL/g" \
    -e "s/PAPERTITLE/$TITLE/g" \
    -e "s/PAPERAFFILIATION/$AFFILIATION/g" paper_template.tex > "$name"".tex_tmp"

# Check if bibfile exists, in that case copy it here. If not, remove references
# to bibliography from the paper.
if [ -f "$BIBFILE_PATH" ]
then
    cp "$BIBFILE_PATH" "$name"".bib"
    sed -e "s/PAPERBIBLIOGRAPHY/$name/g" "$name"".tex_tmp" > "$name"".tex"
else
    echo "Bibliography file not found at $BIBFILE_PATH. Have you customized BIBFILE_PATH in $0?" 1>&2;
    echo "Proceeding without bibliography" 1>&2;
    grep -v "bibliography"  "$name"".tex_tmp" > "$name"".tex"
fi

rm Makefile_template
rm paper_template.tex
rm prepare_arxiv_sub_template.sh
rm "$name"".tex_tmp"
rm compile_template.yml
rm README.md
rm TODO.org
rm setup.sh

git add Makefile
git add prepare_arxiv_sub.sh
git add "$name"".tex"
git add "$name"".bib"
git add .github/workflows/compile.yml
git commit -am "First commit after paper generation"
