gitFolder=$PWD

# Loop through all folders and place the names in an array
git_folders=()
while IFS= read -r line; do
    git_folders+=( "$line" )
  done< <(ls $PWD)

# Loop through the array and run the commands needed to automaticly push a repo to github,
# git add, commit, push(IF commit executed sucsessfully meaning it was something to commit in that folder) 
for folder in "${git_folders[@]}"
do
   cd "$gitFolder/$folder"; printf "\n\nChecking the $folder repo "
   git add .
   git commit -a -m "Uploaded by script, no commit msg added"
   if [[ $? -eq 0 ]]; then
     git push
   fi
done