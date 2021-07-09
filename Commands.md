# grep & replace

`grep -rl matchstring somedir/ | xargs sed -i 's/string1/string2/g'`

# delete all docker container and images

`docker stop $(docker ps -aq)`   
`docker container prune --force`   
`docker rm -vf $(docker ps -a -q)`   
`docker rmi -f $(docker images -a -q)`   

# find files, grep and rename

`find . | grep search | rename 's/old/new'`

You can use use `-n` to only see the changes, without applying them, to ensure the regex is correct.

`find . | grep search | rename -n 's/old/new'`

# git submodules

`git submodules init`    
`git submodules update`   
`git submodules foreach 'git add . || :'`   
`git submodules foreach 'git commit -m "message" || :'`   
`git submodules foreach 'git push || :'`   

# kill processes on port

`sudo lsof -t -i:3000 | xargs sudo kill`

# delete git submodule
`git submodule status` => to show `path/to/submodule`   
`git submodule deinit -f path/to/submodule`   
`rm -rf .git/modules/path/to/submodule`   
`git rm -f path/to/submodule`   

# see the size of a directory
`du -sh directory_name`

# check status of
`sudo systemctl status nginx`

# Find all directories and delete them
`find . -type d -name "bin" | xargs sudo rm -rf `

# get shell name
`echo $0`

# suppressing error messages
`grep -nr something 2>&-`

# all .git repositories on your machine
`find / -type d -name .git 2>&-`