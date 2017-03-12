Dotfiles
========

This repository contains my ever growing collection of various config files.


Cloning
-------

Since this repository contains submodules, you will need to clone it in the following way:

```
git clone --recursive https://github.com/drdanick/dotfiles
```


Vim
---

Assuming you cloned the repositories submodules, all that's required to set vim up is to copy .vimrc and .vim/
to your home folder.

To install the vim plugins, start vim and enter the command `:PluginInstall`.


Tmux
----

Simply copy .tmux.conf to your home directory. The config is designed for Versions > 2.0, though there are some lines
you can comment out in order to get mouse support in earlier versions.


License
-------

Although this doesn't really need a license, one has been included.
See LICENSE for details.
