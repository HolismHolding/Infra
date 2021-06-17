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


