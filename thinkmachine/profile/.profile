# Timezone
export TZ='Europe/Paris'

# User-specific binaries
if [ -d "$HOME/.local/bin" ]; then
  export PATH="$PATH:$HOME/.local/bin"
fi

# Default text editor
export EDITOR=vim
# Default visual editor
export VISUAL=$EDITOR

# Load profiles from ~/.config/profile.d
if test -d "${XDG_CONFIG_HOME:-$HOME/.config}"/profile.d/; then
  for profile in "${XDG_CONFIG_HOME:-$HOME/.config}"/profile.d/*.sh; do
    test -r "$profile" && . "$profile"
  done
  unset profile
fi
