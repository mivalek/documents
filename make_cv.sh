#!/bin/bash

Rscript scripts/cv_script.R

wkhtmltopdf --footer-right [page]/[topage] --footer-font-name "Lato Light" --footer-font-size 8 --footer-spacing 10 --footer-html cv_footer.html -T 25mm -B 40mm -L 25mm -R 25mm --disable-smart-shrinking --disable-external-links cv_mvalasek.html ../cv_mvalasek.pdf

rm cv_mvalasek.html
rm cv_footer.html
