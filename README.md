C:\Users\<owner>\AppData\Local\nvim


* https://note.com/histone/n/na8ebb8a5909f 
1.Plugin Manager(https://github.com/junegunn/vim-plug)
  PS:
    iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
        ni $HOME/vimfiles/autoload/plug.vim -Force
  PS:
    iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
        ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
      


colorshcema:
  C:\Users\<owner>\AppData\Local\nvim-data\plugged\molokai\colors
  -> C:\Program Files\Neovim\share\nvim\runtime\colors
