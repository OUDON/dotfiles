export LANG=ja_JP.UTF-8

setopt auto_cd
setopt auto_pushd

setopt correct
bindkey -v


### Alias ###
setopt complete_aliases
alias c++='c++-6 -D_GLIBCXX_DEBUG -std=c++11 -Wall -Wextra -Wshadow -g'
alias g++='g++-6 -D_GLIBCXX_DEBUG -std=c++11 -Wall -Wextra -Wshadow -g'
alias gcc='gcc-6'
alias objdump='gobjdump -M intel -D'

alias sed='gsed'
alias ls='ls --color'

alias -s py=python
alias -s cpp=vim

alias be='bundle exec'

### Alias for Competitive Programming ###
alias topcoder='open /Applications/TopCoder/ContestAppletProd.jnlp'
alias acget='python ~/procon/atcoder/tools/ACGet.py'
alias actest='python ~/procon/atcoder/tools/ACTest.py'
alias atcoder='python ~/procon/atcoder/tools/AtCoderTools.py'


### pyenv ###
export PYENV_ROOT="${HOME}/.pyenv"
# if [ -d "${PYENV_ROOT}" ]; then
export PATH=${PYENV_ROOT}/bin:$PATH
eval "$(pyenv init -)"
# fi


# Reference : http://d.hatena.ne.jp/oovu70/20120405/p1
### Complement ###
autoload -U compinit; compinit
setopt auto_menu
bindkey "^[[Z" reverse-menu-complete  # Shift-Tabで補完候補を逆順する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
setopt list_packed             # 補完候補をできるだけ詰めて表示する


### Histroy ###
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt share_history
setopt hist_reduce_blanks

# マッチしたコマンドのヒストリを表示できるようにする
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end


# -----------------------------
# Clip Board Fucntion
# -----------------------------
func_clip() { cat $1 | pbcopy }
alias clip=func_clip

func_hclip() {
    highlight -O rtf --font Ricty --font-size 28 $1 | pbcopy
}
alias hclip=func_hclip


# ------------------------------
# Look And Feel Settings
# ------------------------------
### Ls Color ###
# 色の設定
export LSCOLORS=Exfxcxdxbxegedabagacad
# 補完時の色の設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# ZLS_COLORSとは？
export ZLS_COLORS=$LS_COLORS
# lsコマンド時、自動で色がつく(ls -Gのようなもの？)
export CLICOLOR=true
# 補完候補に色を付ける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

### Prompt ###
# プロンプトに色を付ける
autoload -U colors; colors
# 一般ユーザ時
tmp_prompt="%{${fg[cyan]}%}%n%# %{${reset_color}%}"
tmp_prompt2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
tmp_rprompt="%{${fg[green]}%}[%~]%{${reset_color}%}"
tmp_sprompt="%{${fg[yellow]}%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"

# rootユーザ時(太字にし、アンダーバーをつける)
if [ ${UID} -eq 0 ]; then
  tmp_prompt="%B%U${tmp_prompt}%u%b"
  tmp_prompt2="%B%U${tmp_prompt2}%u%b"
  tmp_rprompt="%B%U${tmp_rprompt}%u%b"
  tmp_sprompt="%B%U${tmp_sprompt}%u%b"
fi

PROMPT=$tmp_prompt    # 通常のプロンプト
PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
RPROMPT=$tmp_rprompt  # 右側のプロンプト
SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト

# SSHログイン時のプロンプト
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
  PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
;

### Title (user@hostname) ###
case "${TERM}" in
(kterm*|xterm*|)
  precmd() {
    echo -ne "\033]0;${USER}@${HOST%%.*}\007"
  }
  ;;  
esac

### Git ###
# http://d.hatena.ne.jp/uasi/20091025/1256458798
# touch .git/rprompt-nostatu : 遅くなった時に色をつけない
autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

function rprompt-git-current-branch {
        local name st color gitdir action
        if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
                return
        fi

        name=`git rev-parse --abbrev-ref=loose HEAD 2> /dev/null`
        if [[ -z $name ]]; then
                return
        fi

        gitdir=`git rev-parse --git-dir 2> /dev/null`
        action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"

    if [[ -e "$gitdir/rprompt-nostatus" ]]; then
        echo "$name$action "
        return
    fi

        st=`git status 2> /dev/null`
    if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
        color=%F{green}
    elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
        color=%F{yellow}
    elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
                color=%B%F{red}
        else
                color=%F{red}
        fi

        echo "$color$name$action%f%b"
}

# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst

RPROMPT='%{${fg[green]}%}[%{${reset_color}%}`rprompt-git-current-branch`%{${fg[green]}%}][%~]%{${reset_color}%}'

### peco ###
function peco-select-history()
{
  local tac
  if which tac > /dev/null 2>&1; then
    tac="tac"
  else
    tac="tail -r"
  fi

  BUFFER=$(history -n 1 | eval $tac | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

function peco-select-file() {
    LBUFFER+=$(\find . | \peco)
    CURSOR=$#LBUFFER
}
zle -N peco-select-file
bindkey '^f' peco-select-file
