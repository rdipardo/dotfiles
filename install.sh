#!/usr/bin/env bash
if ! [[ -f $(command -v rename) ]]; then sudo apt -y install rename; fi

find . -maxdepth 1 -print0 | xargs --null -t -I % cp -r % "$HOME" > /dev/null 2>&1
find "$HOME" -maxdepth 1 -print0 | xargs --null -I % mkdir -p "./$(dirname % | cut -d'_' -f 2)"
find "$HOME" -maxdepth 1 -print0 | xargs --null -I % rename -v 's/\/_/\/\./g' %
touch "$HOME/.clj_completions" "$HOME/.scm_completions"
rm -rf "$HOME"/.git{,hub,attributes}
rm -f "$HOME"/{install.sh,LICENSE,README}
find "$HOME/bin" -maxdepth 1 -print0 | xargs --null -I % chmod 744 %

echo ""
ls -lAh "$HOME"
