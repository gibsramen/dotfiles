# MATLAB alias
alias matlab='/Applications/MATLAB.app/bin/matlab -nodesktop -nosplash $*'
alias nrnb-cluster='ssh grahman@grenache.ucsd.edu -t ssh nrnb-head'
alias barnacle='ssh grahman@barnacle.ucsd.edu'
alias algo="cd ~/Dropbox/Grad_School/Algo"

export CLICOLOR=1
export LSCOLORS=GxfxCxDxBxegedabagAhed

alias rmi="rm -i"

#export PS1='\[\e[0m\]\[\e[0;32m\][\[\e[0m\]\[\e[1;36m\]\W\[\e[0m\]\[\e[0;32m\]@\h]\[\e[0m\]$ '
export PS1='\[\e[0m\]$(parse_git_branch)\[\e[0;32m\][\[\e[0m\]\[\e[1;36m\]\W\[\e[0m\]\[\e[0;32m\]@\h]\[\e[0m\]$ '

# Setting PATH for Python 3.5                                                      
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
export PATH

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH

PATH="~/bin:${PATH}"
export PATH

# added by Miniconda3 4.5.12 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/Users/gibraanrahman/miniconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/Users/gibraanrahman/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/gibraanrahman/miniconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/Users/gibraanrahman/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
