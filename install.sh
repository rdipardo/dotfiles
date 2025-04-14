#!/usr/bin/env bash
if ! [[ -f $(command -v rename) ]]; then sudo apt -y install rename; fi
for c in "$HOME/.bashrc" "$HOME/.profile" "$HOME/.vim/vimrc" "$HOME/.config/nvim/init.vim"
do
[[ -f "$c" ]] && cp -v "$c" "$c.bak.$(date +'%Y-%m-%d')"
done

find . -maxdepth 1 -print0 | xargs --null -t -I % cp -r % "$HOME" > /dev/null 2>&1
find "$HOME" -maxdepth 1 -print0 | xargs --null -I % rename -v 's/\/_/\/\./g' %
cp -v "$HOME/.vim/user.vim" "$HOME/.config/nvim/" > /dev/null 2>&1
touch "$HOME/.clj_completions" "$HOME/.scm_completions"
rm -rf "$HOME"/.git{,hub,attributes}
rm -f "$HOME"/{.vintrc.yml,install.sh,install.cmd,install_themes.sh,LICENSE,README}
find "$HOME/bin" -maxdepth 1 -print0 | xargs --null -I % chmod 744 %

echo ""
ls -lAh "$HOME"
