find / -type d -name .git 2>&- | 
while read gitFolder; do
    parent=$(dirname $gitFolder);
    if [[ `git -C $parent status --porcelain` ]]; then
        echo "";
        echo $parent;
        git -C $parent status --porcelain
        git -C $parent add .
        git -C $parent commit -m "committed by script"
        git -C $parent push
    fi
done