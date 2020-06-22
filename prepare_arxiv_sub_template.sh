#!/bin/sh

# Add all the additional files here
files="PAPERNAME.tex PAPERNAME.bbl"

# If you change this, you also have to change the compile.yml file
# for GitHub actions
submission_folder="PAPERNAME_arxiv_submission"

# Remove comments. A simple way to do this is to use latexpand
strip_comments() {
    # https://tex.stackexchange.com/questions/83663/utility-to-strip-comments-from-latex-source
    latexpand --empty-comments "$1" | sed '/^\s*%/d' > "$1""_tmp" | cat -s -
    mv "$1""_tmp" "$1"
}

# ArXiv works better when the directory structure is flat, so we move everything
# into a single folder
mkdir -p "$submission_folder"

# Copy files
echo $files | tr ' ' '\n' | xargs -I{} cp {} "$submission_folder"
# Copy figures
find "figures_ext" -type f -name "*.pdf" | xargs -I{} cp {} "$submission_folder"

# We have to update with the new location of the figures
find "$submission_folder" -type f -name "*.tex" | xargs sed -i 's=figures\_ext\/==g'

# Next, we get rid of all the comments
find "$submission_folder" -type f -name "*.tex" | while read file; do strip_comments "$file"; done

# Arxiv do not support revtex4-2 at the moment, so we change it to revtex4-1
find "$submission_folder" -type f -name "*.tex" | xargs sed -i 's=revtex4-2=revtex4-1=g'
# Create final archives
# The 'cd's are an easy way to include only the files and not the directory
cd "$submission_folder" && tar cvf "../""$submission_folder"".tar" . && cd -

rm -rf "$submission_folder"
