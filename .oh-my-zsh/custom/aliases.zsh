
# new ones
alias hh="history | grep"

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Shortcuts
alias zshdotfiles="open $ZSH/custom"
alias g="git"
alias h="history"
alias refresh="source ~/.zshrc"
alias k="clear"

# Ubuntu/Debian server mgmt
alias nginx='sudo /etc/init.d/nginx'
alias supervisor='sudo supervisorctl'

# Git
alias gs='git status'
alias gp='git pull'
alias gpom='git push origin master'
alias gaall='git add --all && git add -u'
alias gitpush-originmaster='git push origin master'
alias gitadd-all='git add --all && git add -u'
alias gitcommit-message='git commit -m'


# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU coreutils `ls`
    colorflag="--color=auto -hF"
    eval $( dircolors -b $ZSH/custom/LS_COLORS )
fi

# List all files colorized in long format
alias l="ls -l ${colorflag}"

# List all files colorized in long format, including dot files
alias la="ls -la ${colorflag}"

# List only directories
alias lsd='ls -l ${colorflag} | grep "^d"'

# Always use color output for `ls`
alias ls="command ls ${colorflag}"

# Enable aliases to be sudo’ed
alias sudo='sudo '

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en1"
alias ips="ifconfig -a | grep -o 'inet6\? \(\([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\)\|[a-fA-F0-9:]\+\)' | sed -e 's/inet6* //'"

# Enhanced WHOIS lookups
alias whois="whois -h whois-servers.net"

# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# ROT13-encode text. Works for decoding, too! ;)
alias rot13='tr a-zA-Z n-za-mN-ZA-M'

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'


# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
    alias "$method"="lwp-request -m '$method'"
done
