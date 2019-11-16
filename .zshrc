source /usr/share/zsh/share/antigen.zsh
antigen init ~/.antigenrc

bindkey '^[[Z' reverse-menu-complete

alias m="mkdir"
alias s="source"
alias l="ls -hF"
alias la="ls -ahF"
alias ll="ls -alhF"
alias lr="ls -alRhF"
alias ran="ranger"
alias du="du -h"
alias rm="rm -i"
alias vim="nvim"
alias gvim="nvim-qt --no-ext-tabline"
alias yadm-upload="~/yadm_upload.sh"
alias nightlight-on="redshift -P -O 2000K"
alias nightlight-off="redshift -P -O 7000K"

export EDITOR=nvim

# show system time
# PROMPT='%F{white}%* '$PROMPT

# set venv
export VIRTUAL_ENV_DISABLE_PROMPT=1

export SPACESHIP_PROMPT_ADD_NEWLINE=true
export SPACESHIP_PROMPT_SEPARATE_LINE=true

# don't allow pure to set title
prompt_pure_set_title() {}

# show pure prompt in one line
# prompt_newline='%666v'
# PROMPT=" $PROMPT"

# let spaceship prompt show exit code
# SPACESHIP_EXIT_CODE_SHOW=true

# source vte.sh for tilix
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
