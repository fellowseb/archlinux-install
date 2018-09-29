# XDG dir spec compliance
export VIMINIT='let $MYVIMRC="'"${XDG_CONFIG_HOME:-$HOME/.config}"'/vim/vimrc" | source $MYVIMRC'
