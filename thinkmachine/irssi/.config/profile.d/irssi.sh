# XDG dir spec compliance
irssi_config="${XDG_CONFIG_HOME:-$HOME/.config}"/irssi/config
irssi_home="${XDG_DATA_HOME:-$HOME/.local/share}"/irssi
alias irssi="irssi --home=\"${irssi_home}\" --config=\"${irssi_config}\""
unset irssi_config
unset irssi_home
