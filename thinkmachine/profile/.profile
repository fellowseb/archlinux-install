# Timezone
export TZ='Europe/Paris'

# User-specific binaries
if [ -d "$HOME/.local/bin" ]; then
  export PATH=$PATH:$HOME/.local/bin
fi

# Default text editor
export EDITOR=vim
# Default visual editor
export VISUAL=$EDITOR

# Load profiles from ~/.config/profile.d
if [ -z ${XDG_CONFIG_HOME} ]; then
  if test -d "${HOME}"/.config/profile.d/; then
    for profile in "${HOME}"/.config/profile.d/*.sh; do
      test -r "$profile" && . "$profile"
    done
    unset profile
  fi
else
  if test -d "${XDG_CONFIG_HOME}"/profile.d/; then
    for profile in "${XDG_CONFIG_HOME}"/profile.d/*.sh; do
      test -r "$profile" && . "$profile"
    done
    unset profile
  fi
fi
