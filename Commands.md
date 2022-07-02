# grep & replace

`grep -rl matchstring somedir/ | xargs sed -i 's/string1/string2/g'`

# delete all docker container and images

`docker stop $(docker ps -aq)`   
`docker container prune --force`   
`docker rm -vf $(docker ps -a -q)`   
`docker rmi -f $(docker images -a -q)`  
`docker system prune`

# find files, grep and rename

`find . | grep search | rename 's/old/new'`

You can use use `-n` to only see the changes, without applying them, to ensure the regex is correct.

`find . | grep search | rename -n 's/old/new'`
`find / -path "*/Models/bin" 2>/dev/null`
`find / -type d -name "*something*" 2>/dev/null`
`find / -type f -name "*something*" 2>/dev/null`

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
`du -sh .`
`du -h .` *list of subdirectories and their sizes*
`du -h * | sort -h` list and order by size

# check status of
`sudo systemctl status nginx`

# Find all directories and delete them
`find . -type d -name "bin" | xargs sudo rm -rf `

# get shell name
`echo $0`

# suppressing error messages
`grep -nr something 2>/dev/null`

# all .git repositories on your machine
`find / -type d -name .git 2>/dev/null`

# find and remove all <none> docker images
`docker images | grep none | awk '{ print $3; }' | xargs docker rmi`

# see linux version
`cat /etc/os-release`
`lsb_release -a`
`hostnamectl`

# docker usage stats
`docker system df`

# tar unzip
`tar -xf archive.tar.gz`

# find and filter ports
`netstat -tulpn | grep LISTEN | grep -v tcp6 | grep port_number`

# double-click
`xdg-open filename`

# disk usage and free space
`df -h /`
df = disk-free

# test internet speed from shell
`curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -`

# get current timezone
`cat /etc/timezone`
`timedatectl`

# get system info
`uname`
`man uname`

---
`2>/dev/null` closes the error stream (bad habit, because some apps crash if they encounter closed stream for erro)
`2>/dev/null` ignores error, but redirects them to an open stream

# find using negation
`find / -type f ! -path '*Api/Settings.json' -name "Settings.json" 2>/dev/null`

# undo latest commit
`git reset HEAD~`
`git reset --hard`

# See error code in shell
Run a command, then
`echo $?`

# check boolean in terminal
`[ "AdminApi" == "AdminApi" ] && echo yes`

# Find the location of a command
`whereis Setup`

# validate certificate
`openssl verify --verbose Certificate.pem`

# Counting files
`find . -name "*.md" 2>/dev/null | wc -l`

# Get docker image manifest
`docker manifest inspect -v image_full_name`

# Get DNS records
`cat /etc/resolv.conf`
`resolvectl status`

# Open terminal (shortcut)
`Ctrl+Alt+T`

# ns lookup
`dig example.com`

# Get script execution time
`time script.sh`
`time command`