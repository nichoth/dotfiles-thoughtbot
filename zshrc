# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# source ~/.git-prompt.sh

source ~/.z.sh

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
