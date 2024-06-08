
function markdown() {
  if [[ $1 == "--help" ]]; then
    cat ./markdown/markdown/markdown_cheetsheet.md
    return 0;
  fi
  basename=$(echo ${1%%.*})
  user_body=$(echo $(perl ./markdown/Markdown.pl $1))
  awk -v title="$basename" -v body="$user_body" '{
    sub(/user_title/, title);
    sub(/user_body/, body);
    print;
  }' ./markdown/template.html > $basename.html
}

# perl $workspace/utils/markdown/Markdown.pl $1 > body.html
# user_body=$(echo $(cat body.html))
# cp $workspace/utils/markdown/markdown.css $basename.css
# awk -v title="$basename" -v style="$basename" -v body="$user_body" '{
#   sub(/user_title/, title);
#   sub(/user_style/, style);
#   sub(/user_body/, body);
#   print;
# }' $workspace/utils/markdown/template.html > $basename.html
# gsed -e 's/user_title/$basename/g' -e 's/user_style/$basename/g' -e "s@user_html@$user_html@g" $workspace/utils/markdown/template.html > $basename.html
