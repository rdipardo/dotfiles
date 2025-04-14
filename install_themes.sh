#!/usr/bin/env bash
THEME_DIR="$HOME/.config/geany/colorschemes"
THEMES=('bespin' 'cyber-sugar' 'delt-dark' 'epsilon' 'himbeere' 'inkpot')

install_theme (){
  local base='https://raw.githubusercontent.com/geany/geany-themes/master/colorschemes'
  curl -sL "$base/$1.conf" -o "$2/$1.conf"
}

mkdir -p "$THEME_DIR"
for t in "${THEMES[@]}"
do
  install_theme "$t" "$THEME_DIR"
done
