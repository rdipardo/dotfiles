#!/usr/bin/env bash
# shellcheck disable=SC2086,SC2089
set -x
DISTRO=
PKG_CMD='apt install -y rename'

if [[ -f '/etc/os-release' ]]; then
  DISTRO="$(awk '/^ID=.*$/ { gsub(/"/,"",$0);
                             gsub(/[\x2D ].*$/,"",$0);
                             print(tolower(substr($0,4))) }' /etc/os-release)"
fi

case "$DISTRO" in
  'arch' | 'manjaro' )
    PKG_CMD='pacman -Syu util-linux' ;;
  'almalinux' | 'centos' | 'fedora' | 'rocky' )
    PKG_CMD='dnf install -y util-linux' ;;
  'opensuse' )
    PKG_CMD='zypper install -y util-linux' ;;
  *) ;;
esac

[[ $(echo "$PKG_CMD" | grep -Ec 'rename$') -ne 0 ]] && \
  RENAME_ARGS='-v ''s/\/_/\/\./g''' || \
  RENAME_ARGS='-v ''/_'' ''/.'''

if ! [[ -f $(command -v rename) ]]; then sudo ${PKG_CMD}; fi
for c in "$HOME/.bashrc" "$HOME/.profile" "$HOME/.vim/vimrc" "$HOME/.config/nvim/init.vim"
do
[[ -f "$c" ]] && cp -v "$c" "$c.bak.$(date +'%Y-%m-%d')"
done

find . -maxdepth 1 -print0 -exec sh -c 'cp -r "$1" "$HOME" > /dev/null 2>&1' _ {} +
find "$HOME" -maxdepth 1 -print0 -exec rename ${RENAME_ARGS} {} +
cp -v "$HOME/.vim/user.vim" "$HOME/.config/nvim/" > /dev/null 2>&1
touch "$HOME/.clj_completions" "$HOME/.scm_completions"
rm -rf "$HOME"/.git{,hub,attributes}
rm -f "$HOME"/{.vintrc.yml,install.sh,install.cmd,install_themes.sh,LICENSE,README}
find "$HOME/bin" -maxdepth 1 -print0 -exec chmod 744 {} +

echo ""
ls -lAh "$HOME"
