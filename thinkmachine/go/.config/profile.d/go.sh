# XDG dir spec compliance
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}"/go

# Add bin dirs to PATH
PATH="${PATH}":/usr/local/go/bin
if [ -d "${GOPATH}"/bin ]; then
  PATH="${PATH}":"${GOPATH}"/bin
fi
export PATH
