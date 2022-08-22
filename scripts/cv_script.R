
# .libPaths("C:/Users/mv298/Documents/R/win-library/4.1")
yaml <- readLines("data/contact_details.yaml")
cv_file <- readLines("scripts/cv.Rmd")
cv_file <- c(yaml[-length(yaml)], cv_file[-1])
writeLines(cv_file, "temp.Rmd")
rmarkdown::render("temp.Rmd", rmarkdown::html_document(template = "templates/cv_template.html"), output_file = "cv_mvalasek.html")

writeLines(c("---\ntitle: header", yaml[-1]), "temp_footer.Rmd")
rmarkdown::render("temp_footer.Rmd", rmarkdown::html_document(template = "templates/cv_footer_template.html"), output_file = "cv_footer.html")

file.remove("temp.Rmd", "temp_footer.Rmd")
