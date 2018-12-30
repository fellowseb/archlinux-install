prompt_helper_codepoint() {
  local tty=$(tty) 
  tty=${tty:5}
  tty=${tty:0:3}
  if [ $tty = "tty" ]; then
    echo -e -n $2
  else
    echo -e -n "\u$1"
  fi
}

prompt_helper_ret_status() {
  if [ $1 -gt 0 ]; then
    echo -e "\033[1;38;5;1m\uf071 ${1#0}\e[0m"
    echo " "
  fi
}

prompt_helper_user_hostname() {
  echo -n -e "$(tput bold)\033[1;38;5;4m$(prompt_helper_codepoint f007 ) $1\e[0m@\033[38;5;15m\033[48;5;0m$2\e[0m"
}

prompt_helper_home_is_tilde() {
  if [ ${1:0:${#HOME}} = $HOME ]; then
    echo -n ~${1:${#HOME}}
  else
    echo -n ${1}
  fi
}

prompt_helper_workdir() {
  echo -n -e "\033[38;5;172m\uf07b $(prompt_helper_home_is_tilde $1)\033[48;5;1m\e[0m"
}

prompt_helper_git_status() {
  if git status &> /dev/null; then
    local status=$(git status -b -s)
    echo
    echo -n -e '\033[38;5;198m\uf126 '
    echo -n "$status" | head -1 | sed 's/## //g' | sed $'s/\.\.\./ \uf061 /g' | tr -d '\n'
    declare -A map_worktree=([?]=0 [A]=0 [M]=0 [D]=0 [U]=0 [C]=0 [R]=0)
    declare -A map_index=([?]=0 [A]=0 [M]=0 [D]=0 [U]=0 [C]=0 [R]=0)
    local first_char
    local second_char
    echo -n "$status" | tail -n+2 | while read line; do
      first_char=${line:0:1}
      second_char=${line:1:1}
      map_worktree[${first_char}]=$(( ${map_worktree[${second_char}]} + 1 ))
      map_index[${second_char}]=$(( ${map_index[${second_char}]} + 1 ))
    done
    echo -n -e " \uf059${map_worktree[?]}"
    echo -n -e " \uf0fe${map_worktree[A]}\uf14b${map_worktree[M]}\uf146${map_worktree[D]}"
    echo -n -e " \uf0fe${map_index[A]}\uf14b${map_index[M]}\uf146${map_index[D]}"
    echo -n -e "\e[0m"
  fi
}

