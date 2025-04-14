scheme() { CHEZSCHEMELIBDIRS=.:/usr/share/r6rs /usr/bin/chezscheme "$@"; }
guile() { rlwrap /usr/bin/guile "$@"; }
ciforth() { rlwrap "$HOME/.ciforth/lina64" "$@"; }
