# OPENSPEC:START
# OpenSpec shell completions configuration
fpath=("/Users/nick/.oh-my-zsh/custom/completions" $fpath)
autoload -Uz compinit
compinit
# OPENSPEC:END

# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# source ~/.git-prompt.sh

source ~/.z.sh

killport() {
  local pids=$(lsof -ti:"$1")
  if [[ -z "$pids" ]]; then
    echo "nothing on port $1"
    return 1
  fi
  echo "$pids" | xargs kill "${2:-}"
}

# see https://withblue.ink/2020/05/17/how-and-why-to-sign-git-commits.html
export GPG_TTY=$(tty)
gpgconf --launch gpg-agent
export PATH=/opt/homebrew/bin:$PATH

# extra files in ~/.zsh/configs/pre , ~/.zsh/configs , and ~/.zsh/configs/post
# these are loaded first, second, and third, respectively.
_load_settings() {
  _dir="$1"
  if [ -d "$_dir" ]; then
    if [ -d "$_dir/pre" ]; then
      for config in "$_dir"/pre/**/*~*.zwc(N-.); do
        . $config
      done
    fi

    for config in "$_dir"/**/*(N-.); do
      case "$config" in
        "$_dir"/(pre|post)/*|*.zwc)
          :
          ;;
        *)
          . $config
          ;;
      esac
    done

    if [ -d "$_dir/post" ]; then
      for config in "$_dir"/post/**/*~*.zwc(N-.); do
        . $config
      done
    fi
  fi
}
_load_settings "$HOME/.zsh/configs"

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

setopt extended_glob

# export NVM_DIR="/Users/nick/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm


export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

export PATH="$HOME/.cargo/bin:$PATH"

# mkdir and then cd to the new dir
# longhand version for reference: mkdir -p "newdir" && cd "$_"
function md () { mkdir -p "$@" && cd "$@"; }

function findhere () { find "$@" -maxdepth 0 }


# The next line updates PATH for Netlify's Git Credential Helper.
test -f '/Users/nick/Library/Preferences/netlify/helper/path.zsh.inc' && source '/Users/nick/Library/Preferences/netlify/helper/path.zsh.inc'


# pnpm
export PNPM_HOME="/Users/nick/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
# WarpStream
export PATH="/Users/nick/.warpstream:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

export GPG_TTY=$(tty)

# kimi k2
## Use Moonshot AI's Kimi model with Claude CLI
function kimi() {
  (
    export ANTHROPIC_BASE_URL=https://api.moonshot.ai/anthropic
    export ANTHROPIC_AUTH_TOKEN="sk-5fLcJtMWSjVMSmUW608ODiEScVY7P4cncOhxOrJEFJCgzvSU"
    export ANTHROPIC_MODEL=kimi-k2-thinking-turbo
    export ANTHROPIC_SMALL_FAST_MODEL=kimi-k2-thinking
    claude "$@"
  )
}

alias t4="tree -L 4 -I 'node_modules|.git' --dirsfirst"
alias t3="tree -L 3 -I 'node_modules|.git' --dirsfirst"


# Added by Antigravity
export PATH="/Users/nick/.antigravity/antigravity/bin:$PATH"
export PATH="$HOME/.deno/bin:$PATH"


# Turso
export PATH="$PATH:/Users/nick/.turso"
autoload -Uz zmv

export PATH="$HOME/.local/bin:$PATH"
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home

