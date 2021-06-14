# grep & replace

`grep -rl matchstring somedir/ | xargs sed -i 's/string1/string2/g'`

# delete all docker images

`docker rm -vf $(docker ps -a -q)`
`docker rmi -f $(docker images -a -q)`

# find files

find . -name *pattern*

