zmodload zsh/zprof
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
export ZSH="$HOME/.oh-my-zsh"
export GLFW_IM_MODULE=ibus
ZSH_THEME="powerlevel10k/powerlevel10k" # set by `omz`
HYPHEN_INSENSITIVE="true"


zstyle ':omz:update' mode disabled  # disable automatic updates
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="mm/dd/yyyy"
# HISTORY_IGNORE="(l[slah]|cd *|[bf]g|[n]#vi[m]#|f[cd]|tldr|z)"
HISTSIZE=100000
SAVEHIST=10000
# HISTFILE=${HOME}/.zsh_history
# setopt EXTENDED_GLOB
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
plugins=(zsh-z colored-man-pages) 

source $ZSH/oh-my-zsh.sh
if [[ $(command -v "exa") ]]; then
  alias ls="exa --icons"
  alias ll="exa -lh --git --icons"
  alias l="exa -lh --icons"
  alias la="exa -lah"
  alias tree="exa --tree --level 2"
fi

alias reborn="cd ~/Desktop/Game/Reborn/ && ./Game.AppImage $@"
alias rejuv="cd ~/Desktop/Game/Rejuvenation/ && ./mkxp-z.Appimage 2> /dev/null $@"
alias yaya="yay"
alias s="kitty +kitten ssh"
alias lg="lazygit"
# alias updatenvim="cd ~/neovim && git pull && sudo make install && cd -"
alias reload_sxhkd="pkill -USR1 -x sxhkd"
# alias diff="diff -u --color"

# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/lucario387/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/lucario387/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/lucario387/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/lucario387/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup

# <<< conda initialize <<<
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
  export MANPAGER='nvim +Man!'
fi

bindkey '^H' backward-kill-word


export DOTNET_CLI_TELEMETRY_OPTOUT=1
export GPG_TTY=$(tty)
# [ -f "/home/lucario387/.ghcup/env" ] && source "/home/lucario387/.ghcup/env" # ghcup-env

# opam configuration
# [[ ! -r /home/lucario387/.opam/opam-init/init.zsh ]] || source /home/lucario387/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# export GPG_TTY ="$(tty)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# export PAGER="/usr/bin/moar"
# alias less="moar"

source /usr/share/fzf/key-bindings.zsh 
source /usr/share/fzf/completion.zsh

# source /etc/profile.d/fzf.zsh

if [[ $(command -v "fd") && $(command -v "rg") ]]; then
  # COLORSCHEME="--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4" # Dracula
  # COLORSCHEME=" --color=fg:#cbccc6,bg:#1f2430,hl:#707a8c --color=fg+:#707a8c,bg+:#191e2a,hl+:#ffcc66 --color=info:#73d0ff,prompt:#707a8c,pointer:#cbccc6 --color=marker:#73d0ff,spinner:#73d0ff,header:#d4bfff" # Ayu
  COLORSCHEME="--color fg:#ebdbb2,bg:#282828,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f --color info:#83a598,prompt:#bdae93,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54" #Gruvbox
  export FZF_DEFAULT_OPTS="--height=50% --border $COLORSCHEME"
  export FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS --preview='bat --color=always --style=numbers --line-range :500 {}' --preview-window='60%,+{2}+3/3,~3'"
  RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case"
  INITIAL_QUERY="${*:-}"
  export FZF_DEFAULT_COMMAND="$RG_PREFIX $(printf %q '$INITIAL_QUERY')"
  export FZF_CTRL_T_COMMAND="fd --type f --strip-cwd-prefix --follow"
fi


# Browsing Kubernetes pods
pods() {
  FZF_DEFAULT_COMMAND="clear; kubectl get pods --all-namespaces" \
    fzf --info=inline --layout=reverse --header-lines=1 \
        --prompt "$(kubectl config current-context | sed 's/-context$//')> " \
        --header $'╱ Enter (kubectl exec) ╱ CTRL-O (open log in editor) ╱ CTRL-R (reload) ╱\n\n' \
        --bind 'ctrl-/:change-preview-window(80%,border-bottom|hidden|)' \
        --bind 'enter:execute:kubectl exec -it --namespace {1} {2} -- bash > /dev/tty' \
        --bind 'ctrl-o:execute:nvim --clean <(kubectl logs --all-containers --namespace {1} {2}) > /dev/tty' \
        --bind 'ctrl-r:reload:clear; kubectl get pods --all-namespaces' \
        --preview-window up:follow \
        --preview 'kubectl logs --follow --all-containers --tail=1000 --namespace {1} {2}' "$@"
}

gdiff() {
  local REG=`tput op`
  local GRP=`tput setaf 6`
  local ADD=`tput setaf 2`
  local REM=`tput setaf 1`

  local NL=$'\n'
  local GRP_LABEL="${GRP}@@ %df,%dn +%dF,%dN @@${REG}"

  local UNCH_GRP_FMT=''

  [[ "${1}" == '@full' ]] && { UNCH_GRP_FMT="${GRP_LABEL}${NL}%=" shift }

  diff \
    --new-line-format="${ADD}+%L${REG}" \
    --old-line-format="${REM}-%L${REG}" \
    --unchanged-line-format=" %L${REG}" \
    --new-group-format="${GRP_LABEL}${NL}%>" \
    --old-group-format="${GRP_LABEL}${NL}%<" \
    --changed-group-format="${GRP_LABEL}${NL}%<%>" \
    --unchanged-group-format="${UNCH_GRP_FMT}" \
    "${@}" | less -FXR
}

