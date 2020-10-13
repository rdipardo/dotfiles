#!/usr/bin/env bash
if ! [[ -f $(command -v rename) ]]; then sudo apt -y install rename; fi

find . -maxdepth 1 -print0 | xargs --null -t -I % cp -r % "$HOME"
find "$HOME" -maxdepth 1 -print0 | xargs --null -I % rename 's/\/_/\/\./g' %
mkdir "$HOME/.config/nvim"
cp -v "$HOME/.vim/vimrc" "$HOME/.config/nvim/init.vim"
touch "$HOME/.clj_completions" "$HOME/.scm_completions"
rm -rf "$HOME/.git"
rm "$HOME/install.sh" "$HOME/.gitattributes" "$HOME/UNLICENSE" "$HOME/README.rst"
find "$HOME/bin" -maxdepth 1 -print0 | xargs -I % chmod 744 %

echo ""
ls -lARh "$HOME"
