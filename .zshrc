# zmodload zsh/zprof

# Load home-manager session variables
if [ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
  source "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

zinit ice depth"1" # git clone depth
zinit light romkatv/powerlevel10k

zstyle ':omz:plugins:nvm' lazy yes


zi snippet OMZP::vi-mode

# zi snippet OMZP::gitfast 
# export fpath=("$HOME/.local/share/zinit/snippets/gitfast" $fpath)

zi snippet OMZP::nvm
zi snippet OMZP::kubectl
zi snippet OMZP::kind

# zinit ice atload"bindkey '^X' create_completion"
# zinit light tom-doerr/zsh_codex

# zinit light zsh-users/zsh-autosuggestions
# zinit light zsh-users/zsh-syntax-highlighting
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-completions

autoload -U compinit && compinit
zinit cdreplay -q

zinit light Aloxaf/fzf-tab

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

# zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
# zstyle ':fzf-tab:*' use-fzf-default-opts yes
# zstyle ':fzf-tab:*' switch-group '<' '>'

eval "$(fzf --zsh)"

# zinit ice atload"bindkey '^I' menu-select" atload'bindkey "$terminfo[kcbt]" menu-select' completions
# zinit light marlonrichert/zsh-autocomplete
# zstyle ':completion:*' completer _complete _complete:-fuzzy _correct _approximate _ignored
# zstyle ':autocomplete:*' delay 0.2  # seconds (float)



alias vim="nvim";
alias eh='vim ~/.config/home-manager/home.nix && home-manager switch'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'


setopt EXTENDED_HISTORY

export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
export PATH="$PATH:$HOME/.local/bin"
export EDITOR=nvim
export K9S_EDITOR=nvim
export COURSIER_PROGRESS=false
export LANG=en_US.UTF-8
# export PATH="$PATH:/Users/dogac/go/bin"
# export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
# export PATH="$HOME/.pyenv/bin:$PATH"
# export BUN_INSTALL="$HOME/.bun"
# export PATH="$BUN_INSTALL/bin:$PATH"
# export TERRAGRUNT_TFPATH=$(which terraform)
# export PATH="$PATH:$HOME/.rvm/bin"

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
[ -f "$HOME/.secrets" ] && source "$HOME/.secrets"

alias dps='docker ps --format "table {{.Names}}\t{{.Status}}"'
alias gitdel="git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -D"
alias fzg="fd --type f | fzf"
alias vim="nvim"
alias vi="nvim"
alias oldvim="\vim"
alias ka="kubectl apply -f"
alias kd="kubectl delete -f"
alias cli-tools-update="cd $CLI_TOOLS && git pull"
alias ls="ls --color"
alias ager='age -r $(<recipients.txt) -i $HOME/.config/age/keys.txt'

alias gst='git status'
alias gaa='git add -A'
alias gc='git commit'
alias gcm='git checkout main'
alias gd='git diff'
alias gdc='git diff --cached'
# [c]heck [o]ut
alias co='git checkout'
# [f]uzzy check[o]ut
fo() {
  git branch --no-color --sort=-committerdate --format='%(refname:short)' | fzf --header 'git checkout' | xargs git checkout
}
# [p]ull request check[o]ut
po() {
  gh pr list --author "@me" | fzf --header 'checkout PR' | awk '{print $(NF-5)}' | xargs git checkout
}
alias up='git push'
alias upf='git push --force'
alias pu='git pull'
alias pur='git pull --rebase'
alias fe='git fetch'
alias re='git rebase'
alias lr='git l -30'
alias cdr='cd $(git rev-parse --show-toplevel)' # cd to git Root
alias hs='git rev-parse --short HEAD'
alias hm='git log --format=%B -n 1 HEAD'

# ceedee dot dot dot
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

# Northwestern Specific
alias sshquest='ssh -X ftw9443@login.quest.northwestern.edu'
alias sshimec='ssh -X ftw9443@imec.ece.northwestern.edu'

function gitall() {
    git add .
    git commit -m "$1"
    git push
}

function gitcp() {
    git commit -m "$1"
    git push
}

function gitups() {
  git branch --set-upstream-to=origin/$(git branch --show-current) $(git branch --show-current)
}

function git {
  if [[ "$1" == "checkout" && "$@" != *"--help"* && "$#" == 1 ]]; then
    command  git checkout "$(git branch --sort=-committerdate | fzf | tr -d '[:space:]')"
  else
    command git "$@"
  fi
}

# useful only for Mac OS Silicon M1,
# still working but useless for the other platforms
function dockerx() {
 if [[ `uname -m` == "arm64" ]] && [[ "$1" == "run" || "$1" == "build" ]]; then
    /usr/local/bin/docker "$1" --platform linux/amd64 "${@:2}"
  else
     /usr/local/bin/docker "$@"
  fi
}

function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}


function korun() {
    local file="$1"
    local output_dir="bin"
    local base_name
    local executable

    # Check if the file exists
    if [[ ! -f "$file" ]]; then
        echo "Error: File '$file' does not exist."
        return 1
    fi

    # Create the bin directory if it doesn't exist
    mkdir -p "$output_dir"

    # Extract the base name (filename without extension)
    base_name=$(basename "$file" .kt)
    executable="$output_dir/$base_name"

    # Compile the Kotlin file into a JAR
    kotlinc "$file" -include-runtime -d "$output_dir/$base_name.jar"

    if [[ $? -ne 0 ]]; then
        echo "Compilation failed."
        return 1
    fi

    # Create the executable wrapper script
    cat <<EOF > "$executable"
#!/bin/bash
exec java -jar "\$(dirname "\$0")/$base_name.jar" "\$@"
EOF

    # Make the wrapper executable
    chmod +x "$executable"

    echo "Executable created: $executable"

    # Shift arguments and run the executable with them
    shift
    "$executable" "$@"
}

load_secrets() {
  if ! command -v op &> /dev/null; then
    echo "[!] 1Password CLI (op) not found. Please install it from https://developer.1password.com/docs/cli/get-started/"
    return 1
  fi

  echo "[+] Fetching secrets from 1Password..."

  # 1. Fetch "age/keys.txt" secure note
  echo "[+] Downloading age keys..."
  AGE_KEYS=$(op item get age/keys.txt --format json | jq -r '.fields[] | select(.label=="notesPlain") | .value' 2>/dev/null)
  if [[ -z "$AGE_KEYS" ]]; then
    echo "[!] Failed to fetch 'age/keys.txt' from 1Password."
  else
    mkdir -p ~/.config/age
    echo "$AGE_KEYS" > ~/.config/age/keys.txt
    chmod 600 ~/.config/age/keys.txt
    echo "[✓] Saved to ~/.config/age/keys.txt"
  fi

  # 2. Fetch ".secrets" secure note
  echo "[+] Downloading .secrets..."
  SECRETS_CONTENT=$(op item get .secrets --format json | jq -r '.fields[] | select(.label=="notesPlain") | .value' 2>/dev/null)
  if [[ -z "$SECRETS_CONTENT" ]]; then
    echo "[!] Failed to fetch '.secrets' from 1Password."
  else
    echo "$SECRETS_CONTENT" > ~/.secrets
    chmod 600 ~/.secrets
    echo "[✓] Saved to ~/.secrets"
  fi
}

upload_secrets() {
  if ! command -v op &> /dev/null; then
    echo "[!] 1Password CLI (op) not found. Please install it from https://developer.1password.com/docs/cli/get-started/"
    return 1
  fi

  # Upload function for a single file
  _upload_note() {
    local file_path="$1"
    local item_title="$2"

    if [[ ! -f "$file_path" ]]; then
      echo "[!] File not found: $file_path"
      return
    fi

    local content
    content=$(<"$file_path")

    echo "[+] Uploading '$file_path' to 1Password item: '$item_title'..."

    # Check if item exists
    if op item get "$item_title" &>/dev/null; then
      # Update existing item
      op item edit "$item_title" notesPlain="$content" &>/dev/null \
        && echo "[✓] Updated '$item_title'" \
        || echo "[!] Failed to update '$item_title'"
    else
      # Create new item as a Secure Note
      op item create --title "$item_title" --category "Secure Note" notesPlain="$content" &>/dev/null \
        && echo "[✓] Created '$item_title'" \
        || echo "[!] Failed to create '$item_title'"
    fi
  }

  # Upload both secrets
  _upload_note "$HOME/.secrets" ".secrets"
  _upload_note "$HOME/.config/age/keys.txt" "age/keys.txt"
}

# export NVM_DIR="$HOME/.nvm"
# [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh" --no-use
#  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
#  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# eval "$(direnv hook $(basename $SHELL))"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
# eval "$(rbenv init - zsh)"
eval "$(zoxide init zsh)"
# eval "$(gh copilot alias -- zsh)"
# eval "$(mise activate zsh)"

# zinit as="command" lucid from="gh-r" for \
#     id-as="mise" mv="mise* -> mise" \
#     atclone="./mise* completion zsh > _mise" \
#     atpull="%atclone" \
#     atload='eval "$(mise activate zsh)"' \
#     jdx/mise
source <(COMPLETE=zsh jj)


autoload -U edit-command-line
zle -N edit-command-line
bindkey '^ee' edit-command-line

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -s ~/.bun/_bun ] && source ~/.bun/_bun

# alias claude="/Users/dogac/.claude/local/claude"

source "$HOME/.llm.zsh"

# . "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"

# zprof
