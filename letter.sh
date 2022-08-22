#!/bin/bash
script_path="${BASH_SOURCE}"
resource_path=$(dirname $(realpath $script_path))
md_file=$(realpath "${1%.*}.md")

cd $resource_path
echo $resource_path
{
  head -n -1 ./data/contact_details.yaml
  echo "auto_date:" $(date +"%-d %B %Y")
  tail -n +2 $md_file
} > temp.md

if [[ $# == 1 ]]
then
	pandoc temp.md --template ./templates/letter_template.html -f markdown -t html --self-contained -o ${md_file/%md/pdf} --resource-path $resource_path --pdf-engine-opt="--footer-center" --pdf-engine-opt="[page]" --pdf-engine-opt="--footer-font-name" --pdf-engine-opt="Lato Light" --pdf-engine-opt="--footer-font-size" --pdf-engine-opt="10" --pdf-engine-opt="--footer-spacing" --pdf-engine-opt="8" --pdf-engine-opt="--no-outline"
elif [[ $# == 2 ]]
then
	# cut off _header and .html if exsist and append _header.html
	# this allows for passing e.g. sussex, sussex_header, or sussex_header.html
	header="./assets/`echo "$2" | sed -e 's/.html//' -e 's/_header//'`_header.html"
	pandoc temp.md --template ./templates/letter_template.html -f markdown -t html --self-contained -o ${md_file/%md/pdf} --resource-path $resource_path --pdf-engine-opt="--footer-center" --pdf-engine-opt="[page]" --pdf-engine-opt="--footer-font-name" --pdf-engine-opt="Lato Light" --pdf-engine-opt="--footer-font-size" --pdf-engine-opt="10" --pdf-engine-opt="--footer-spacing" --pdf-engine-opt="8" --pdf-engine-opt="--header-html" --pdf-engine-opt="$header" --pdf-engine-opt="--header-spacing" --pdf-engine-opt="5" --pdf-engine-opt="--no-outline"
else
	echo "Usage example: ./letter.sh file_name.md ([header name]_header.html; just [header name] also works)"
fi
	
rm temp.md
cd $(dirname $md_file)

