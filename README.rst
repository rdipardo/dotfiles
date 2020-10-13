#############
User's Guide
#############

Assumptions
===========
- a fresh installation of Debian (stable), Ubuntu, or derivative
- ``sudo`` is available and ``sudo usermod -aG sudo $USER`` has been run
  successfully

Setup
=====
Make sure that `rename <https://packages.debian.org/stable/rename>`_ is (or
can be) installed.

Clone this repo and run ``chmod +x ./install.sh && ./install.sh``

:NOTE: Existing directories will **not** be overwritten by the
       `installation script`_.

       Edit the script to run ``rename`` with `the -f option`_ if a
       potentially destructive installation is what you want.

Essential packages
==================
The utilities in `$HOME/bin`_ expect, at minimum:

- `clang <https://packages.debian.org/stable/clang>`_
- `cmake <https://packages.debian.org/stable/cmake>`_
- `curl <https://packages.debian.org/stable/curl>`_
- `docker <https://docs.docker.com/engine/install/debian/>`_
- `findutils <https://packages.debian.org/en/stable/findutils>`_
- `freetds-dev <https://packages.debian.org/stable/freetds-dev>`_
- `iptables <https://wiki.debian.org/iptables>`_
- `jq <https://packages.debian.org/stable/jq>`_
- ``luit``, a component of the
  `x11-utils <https://packages.debian.org/stable/x11-utils>`_ package
- `perl <https://packages.debian.org/stable/perl>`_ with both the ``DBI`` and
  ``DBD::ODBC`` modules installed: ``$ sudo cpan DBI DBD::ODBC``
- `python <https://packages.debian.org/stable/python3>`_
- `rlwrap <https://packages.debian.org/stable/rlwrap>`_
- `tdsodbc <https://packages.debian.org/stable/tdsodbc>`_
- `unixodbc <https://packages.debian.org/stable/unixodbc>`_
- `unixodbc-dev <https://packages.debian.org/stable/unixodbc-dev>`_

:NOTE: Avoid the `freetds-bin`_ package -- it's out-of-date. You should
       `build the FreeTDS binaries <#building-freetds>`_ instead.

Optional
--------
Some useful libraries to have when `configuring FreeTDS`_, if you want:

`Kerberos <https://web.mit.edu/Kerberos/>`_ authentication
    `libkrb5-dev <https://packages.debian.org/stable/libkrb5-dev>`_

OpenSSL support
    `libssl-dev <https://packages.debian.org/stable/libssl-dev>`_

Building FreeTDS
================
* Check out a release branch of the
  `FreeTDS repo <https://github.com/FreeTDS/freetds>`_, for example::

    git clone -b R1_2 https://github.com/FreeTDS/freetds.git

* Make sure the `build dependencies`_ are installed
* Run ``sh ./autogen.sh``

.. _`configuring FreeTDS`:

* Browse all the available build options with ``./configure  --help``.
  For example, my current installation was configured with::

    ./configure --with-tdsver=7.4 \
      --enable-krb5 \
      --enable-msdblib \
      --enable-sybase-compat \
      --sysconfdir=$HOME/etc

* Run ``make`` and verify the configuration with ``./src/apps/tsql -C``. The
  output should resemble the following::

    Compile-time settings (established with the "configure" script)
                             Version: freetds v1.2
              freetds.conf directory: /home/rob/etc
      MS db-lib source compatibility: yes
         Sybase binary compatibility: yes
                       Thread safety: yes
                       iconv library: yes
                         TDS version: 7.4
                               iODBC: no
                            unixodbc: yes
               SSPI "trusted" logins: no
                            Kerberos: yes
                             OpenSSL: yes
                              GnuTLS: no
                                MARS: yes

Ask anything
=============
Request additional guidance or report a problem by
`opening an issue <https://github.com/rdipardo/dotfiles/issues>`_.

License
=======
Any copyright has been dedicated to the Public Domain.
For more information, please refer to https://unlicense.org.

.. _`$HOME/bin`: https://github.com/rdipardo/dotfiles/tree/main/bin
.. _`installation script`: https://github.com/rdipardo/dotfiles/tree/main/install.sh
.. _`the -f option`: https://manpages.debian.org/testing/rename/file-rename.1p.en.html
.. _`freetds-bin`: https://packages.debian.org/stable/freetds-bin
.. _`build dependencies`: https://github.com/FreeTDS/freetds/blob/master/INSTALL.GIT.md
