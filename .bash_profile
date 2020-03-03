set -o vi

alias barnacle='ssh grahman@barnacle.ucsd.edu'
alias cac="conda activate"
alias cdeac="conda deactivate"
alias vim="mvim -v"
alias vi="mvim -v"

export CLICOLOR=1
export LSCOLORS=GxfxCxDxBxegedabagAhed

alias rmi="rm -i"
CONDA_ENV="[$(basename "$CONDA_PREFIX")]"

#export PS1='\[\e[41;1;30m\]$(parse_env)\[\e[0m\]\[\e[43;1;30m\]$(parse_git_branch)\[\e[0m\]\[\e[42;1;30m\]\h:\[\e[0m\]\[\e[1;36m\]\W/\[\e[0m\]\n$ '
export PS1='\[\e[41;1;30m\]$(parse_env)\[\e[0m\]\[\e[43;1;30m\]$(parse_git_branch)\[\e[0m\]\[\e[42;1;30m\]\h:\[\e[0m\]\[\e[1;36m\]$(short_pwd)/\[\e[0m\]\n$ '

#PATH="~/bin:${PATH}"
#PATH="/Users/gibs/.gem/ruby/2.6.0/bin:${PATH}"
#export PATH

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[ᚠ \1]/'
}

# set changeps1 to False in .condarc
parse_env() {
	C=$(basename "$CONDA_PREFIX")
	if [ -z $C ]
	then
		echo ""
	else
		echo "($C)"
	fi
}

short_pwd() {
    cwd=$(pwd | perl -F/ -ane 'print join( "/", map { $i++ < @F - 1 ?  substr $_,0,1 : $_ } @F)')
    echo -n $cwd
}


# added by Miniconda3 4.6.14 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/miniconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/miniconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
conda deactivate
# <<< conda init <<<
