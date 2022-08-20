#!/bin/bash

if [[ "$1" == "def" ]]; then
  pdflatex -output-directory=$PWD/main $PWD/main/daniel_tellier.tex
else
  pdflatex -output-directory=$PWD/main $PWD/main/daniel_tellier.tex
fi
