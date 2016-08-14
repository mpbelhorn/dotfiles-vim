#  Source order:
#  1: /etc/zshenv
#  2: ~/.zshenv
#  3: /etc/zprofile if login is True else pass
# *4: ~/.zprofile if login is True else pass
#  5: /etc/zshrc if interactive is True else pass
#  6: ~/.zshrc if interactive is True else pass
#  7: /etc/zlogin if login is True else pass
#  8: ~/.zlogin if login is True else pass

if [ -d /sw/cave/tmux/1.8/centos5.10_gnu4.1.2/bin ]; then
  export PATH=$PATH:/sw/cave/tmux/1.8/centos5.10_gnu4.1.2/bin
fi

if [ -d $HOME/.local/bin ]; then
  export PATH=$PATH:$HOME/.local/bin
fi

# Let following init files know this has been read.
export LOCAL_ZPROFILE_READ="True"
