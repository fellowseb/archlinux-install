# XDG dir spec compliance
export AWS_SHARED_CREDENTIALS_FILE="${XDG_CONFIG_HOME:-$HOME/.config}"/aws/credentials
export AWS_CONFIG_FILE="${XDG_CONFIG_HOME:-$HOME/.config}"/aws/config
