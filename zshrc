# history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=100000
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt hist_no_store
setopt hist_expand
setopt appendhistory autocd extendedglob
setopt extended_history # puts timestamps in the history

BLACK="%{"$'\033[01;30m'"%}"
GREEN="%{"$'\033[01;32m'"%}"
RED="%{"$'\033[01;31m'"%}"
YELLOW="%{"$'\033[01;33m'"%}"
BLUE="%{"$'\033[01;34m'"%}"
BOLD="%{"$'\033[01;39m'"%}"
NORM="%{"$'\033[00m'"%}"

PURPLE="%{"$'\033[35m'"%}"
PINK="%{"$'\033[01;35m'"%}"
WHITE="%{"$'\033[01;37m'"%}"
BROWN="%{"$'\033[33m'"%}"

autoload -Uz vcs_info

# prompt (if running screen, show window #)
if [ x$WINDOW != x ]; then
    export PS1="$WINDOW:%~%# "
else
#       export PS1="
# <${YELLOW}%~${NORM}>
# ${RED}%n${YELLOW}@${BLUE}%U%m%u$%(!.#.$) "
# export PS1="[${RED}%n${YELLOW}@${BLUE}%U%m%u$:${GREEN}%2c${NORM}]%(!.#.$) "
export PS1="[${PURPLE}%n${WHITE}@${PINK}%U%m%u$:${WHITE}%2c${NORM}]%(!.#.$) "
# export PS1="[%F{red}%n%F{yellow}@%F{blue}%U%m%u$:%F{green}%2c${NORM}]%(!.#.$) "
# right prompt - time/date stamp
# export RPS1="${GREEN}(%D{%m-%d %H:%M})${NORM}"
export RPS1="${BROWN}(%D{%m-%d %H:%M})${NORM}"
# export RPS1="%F{green}(%D{%m-%d %H:%M})${NORM}"
# this right prompt is for any kind of repository info - svn, git, mercurial ,etc. courtesy of vcs_info
# export RPS1="${YELLOW}%1v${NORM}"
fi

# format titles for screen and rxvt
function title() {
  # escape '%' chars in $1, make nonprintables visible
  a=${(V)1//\%/\%\%}

  # Truncate command, and join lines.
  a=$(print -Pn "%40>...>$a" | tr -d "\n")

  case $TERM in
  screen)
    print -Pn "\ek$a:$3\e\\"      # screen title (in ^A")
    ;;
  xterm*|rxvt)
    print -Pn "\e]2;$2 | $a:$3\a" # plain xterm title
    ;;
  esac
}

# precmd is called just before the prompt is printed
function precmd() {
  title "zsh" "$USER@%m" "%55<...<%~"
  psvar=()
  vcs_info
  [[ -n $vcs_info_msg_0_ ]] && psvar[1]="$vcs_info_msg_0_"
}

# preexec is called just before any command line is executed
function preexec() {
  title "$1" "$USER@%m" "%35<...<%~"
}

# this is ubuntu specific - in case you execute a command
# that is not installed, zsh automatically calls this handler
# so that you get a nice recommendation message (similar to bash)
function command_not_found_handler() {
     /usr/bin/python /usr/lib/command-not-found -- $1
}

# vi editing
# this prevents me from deleting a word using ESC-Backspace
bindkey -v

# colorful listings
zmodload -i zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

autoload -U compinit
compinit

# aliases
alias mv='nocorrect mv'       # no spelling correction on mv
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'
alias rm='~/.bin/rm2trash.sh'
alias j=jobs
if ls -F --color=auto >&/dev/null; then
  alias ls="ls --color=auto"
else
  alias ls="ls"
fi
alias ll="ls -l"
alias ..='cd ..'
alias .='pwd'
alias grep='grep -E --color=always'
# alias vim='gvim'
alias convert='/usr/bin/convert'
alias display='/usr/bin/display'

export SCALA_HOME=/usr

#copy with progress bar
alias cp='rsync -aP'
alias netstat='netstat -ap'

# ssh to other machines
alias epson='ssh -X kuroiwa@epson-156'
alias xt='ssh -X r2210@xt4'
alias cmst='ssh -X kuroiwa@cmst01'

#exports
# path=(/home/user/clearsenses/ruby-enterprise-1.8.7-20090928/release/bin $path)
# export PATH
# export RUBYLIB=/home/user/clearsenses/ruby-1.8.6-p383/release/lib
# #export GEM_HOME=/home/user/research/doublecheq/GEMS
# export GEM_HOME=/home/user/clearsenses/JAMBOOL_GEMS
# #export GEM_HOME=/home/user/clearsenses/GEMS-1.8
# export GEM_PATH=$GEM_HOME
# export RUBY_SOURCE_DIR=/home/user/clearsenses/ruby-enterprise-1.8.7-20090928/source/
# path=($GEM_PATH/bin $path)

#variables that need to be set for intellij - Ubuntu
# export JDK_HOME=/usr/lib/jvm/java-6-sun-1.6.0.15/
# export M2_HOME=/usr/share/maven2/

# functions
setenv() { export $1=$2 }  # csh compatibility

#bash style ctrl-a (beginning of line) and ctrl-e (end of line)
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
# key bindings

# Emulate tcsh's backward-delete-word
# tcsh-backward-delete-word () {
#     #local WORDCHARS="${WORDCHARS:s#/#}"
#     #local WORDCHARS='*?_[]~\/!#$%^<>|`@#$%^*()+?'
#     local WORDCHARS="${WORDCHARS:s#/#}"
#     zle backward-delete-word
# }
# 
# tcsh-backward-word () {
#     local WORDCHARS="${WORDCHARS:s#/#}"
#     zle emacs-backward-word
# }
# 
# tcsh-forward-word () {
#     local WORDCHARS="${WORDCHARS:s#/#}"
#     zle emacs-forward-word
# }
# 
# zle -N tcsh-backward-delete-word
# zle -N tcsh-backward-word
# zle -N tcsh-forward-word
# 
# # for escape backspace (delete a word) behavior similar to tcsh
# bindkey '\e^?' tcsh-backward-delete-word
# #for ctrl leftarrow and rightarrow navigation 
# bindkey ';5D' tcsh-backward-word
# bindkey ';5C' tcsh-forward-word

#if this is uncommented, it will ignore the stop-at-special-chars
#bindkey '\e^H' backward-delete-word

#uncomment this to have a nice update script that will cause ur zshrc to update from a central location

#selfupdate(){
#        URL="http://stuff.mit.edu/~jdong/misc/zshrc"
#        echo "Updating zshrc from $URL..."
#        echo "Press Ctrl+C within 5 seconds to abort..."
#        sleep 5
#        cp ~/.zshrc ~/.zshrc.old
#        wget $URL -O ~/.zshrc
#        echo "Done; existing .zshrc saved as .zshrc.old"
#}
#
#rsync -tzhhP rsync://cdimage.ubuntu.com/cdimage/daily/20090420.1/jaunty-alternate-i386.iso .
export TERM=xterm-256color
eval `dircolors ~/.dir_colors`
source /opt/intel/bin/compilervars.zsh intel64
export FV_HOME=/opt/fv13.2/fv
export MATVIEW_ROOT=/home/kuroiwa/Matview
export LD_LIBRARY_PATH=/opt/intel/composer_xe_2013.2.146/compiler/lib/intel64:/opt/mpich2/mpich-3.0.1/lib:$ld_library_path
path=(. /opt/mpich2/mpich-3.0.1/bin /opt/intel/bin /opt/fv13.2/fv/bin /opt/Pointwise/PointwiseV17.0R1 /opt/MatView/bin $path )
export PATH
