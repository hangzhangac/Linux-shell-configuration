## Put all three files in your root directory
### For ~/.zshrc
After you install oh-my-zsh, run
```
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/paulirish/git-open.git $ZSH_CUSTOM/plugins/git-open
```

### For ~/.vimrc
Follow [https://draculatheme.com/vim](https://draculatheme.com/vim) to install the dracula theme.  
Then install Vundle to manage the plugins of VIM
```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
Then start vim and run :PluginInstall __OR__ run vim +PluginInstall +qall in the shell.


### For tmux
Run
```
tmux source ~/.tmux.conf
```
