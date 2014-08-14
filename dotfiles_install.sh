function dotfiles_install() {
  if [[ -z $workspace ]]; then
    echo "set workspace path:";
    read workspace
    echo "workspace set to $workspace"
  fi

  if [[ -z $name ]]; then
    echo "enter name for .gitconfig";
    read name
    echo "name set to $name"
  fi

  if [[ -z $email ]]; then
    echo "enter email for .gitconfig";
    read email
    echo "email set to $email"
  fi

  if [[ -z $userpass64 ]]; then
    local userpass
    local temp

    cont=0;
    while [[ $cont == 0 ]]; do
      echo "enter network password for proxy configuration (for wget, github, etc.):"
      read -s -p "" userpass
      echo "re-enter:"
      read -s -p "" temp
      if [[ "$userpass" == "$temp" ]]; then
        echo "password set"
        cont=1
      else
        echo "ERROR: passwords don't match" 1>&2
        echo "try again..."
      fi
    done
    userpass64=$(echo $userpass | base64)
  fi

  echo "workspace=\"$workspace\"" > .userrc
  echo "user=$(whoami)" >> .userrc
  echo "name=\"$name\"" >> .userrc
  echo "email=$email" >> .userrc
  echo "userpass64=$userpass64" >> .userrc

  sed -e "s/user_name/$name/g" -e "s/user_email/$email/g" .gitconfig_default > .gitconfig

  rm_links
  set_links
  exec /bin/bash -l
}

function set_links() {
  ln -s $workspace/utils/dotfiles/.ackrc ~/.ackrc;
  ln -s $workspace/utils/dotfiles/.autotest ~/.autotest;
  ln -s $workspace/utils/dotfiles/.bashrc ~/.bashrc;
  ln -s $workspace/utils/dotfiles/.bash_logout ~/.bash_logout;
  ln -s $workspace/utils/dotfiles/.emacs ~/.emacs;
  ln -s $workspace/utils/dotfiles/.emacs-lisp ~/.emacs-lisp;
  ln -s $workspace/utils/dotfiles/.gemrc ~/.gemrc;
  ln -s $workspace/utils/dotfiles/.getmail ~/.getmail;
  ln -s $workspace/utils/dotfiles/.gitconfig ~/.gitconfig;
  ln -s $workspace/utils/dotfiles/.githelpers ~/.githelpers;
  ln -s $workspace/utils/dotfiles/.gitmodules ~/.gitmodules;
  ln -s $workspace/utils/dotfiles/.hgrc ~/.hgrc;
  ls -s $workspace/utils/dotfiles/.minttyrc ~/.minttyrc;
  ln -s $workspace/utils/dotfiles/.mutt ~/.mutt;
  ln -s $workspace/utils/dotfiles/.proxybash ~/.proxybash;
  ln -s $workspace/utils/dotfiles/.ps1rc ~/.ps1rc;
  ln -s $workspace/utils/dotfiles/.offlineimap.py ~/.offlineimap.py;
  ln -s $workspace/utils/dotfiles/.offlineimaprc ~/.offlineimaprc;
  ln -s $workspace/utils/dotfiles/.rvmrc ~/.rvmrc;
  ln -s $workspace/utils/dotfiles/.screenrc ~/.screenrc;
  ln -s $workspace/utils/dotfiles/.tmux.conf ~/.tmux.conf;
  ln -s $workspace/utils/dotfiles/.userrc ~/.userrc;
  ln -s $workspace/utils/dotfiles/.vim ~/.vim;
  ln -s $workspace/utils/dotfiles/.vimrc ~/.badvimrc;
  ln -s $workspace/utils/dotfiles/.vimrc ~/.vimrc;
  ln -s $workspace/utils/dotfiles/.zprofile ~/.zprofile;
  ln -s $workspace/utils/dotfiles/.zsh ~/.zsh;
  ln -s $workspace/utils/dotfiles/.zshenv ~/.zshenv;
  ln -s $workspace/utils/dotfiles/.zshrc ~/.zshrc;
  ln -s $workspace/utils/dotfiles/bin ~/dfbin;
}

function rm_links() {
  dirstamp=$(date +%Y%m%d%H%M%S);
  mkdir -p ~/.oldrcs/$dirstamp;
  mv ~/.ackrc ~/.oldrcs/$dirstamp/ 2>/dev/null;
  mv ~/.autotest  ~/.oldrcs/$dirstamp/ 2>/dev/null;
  mv ~/.badvimrc  ~/.oldrcs/$dirstamp/ 2>/dev/null;
  mv ~/.bashrc  ~/.oldrcs/$dirstamp/ 2>/dev/null;
  mv ~/.bash_logout  ~/.oldrcs/$dirstamp/ 2>/dev/null;
  mv ~/.emacs  ~/.oldrcs/$dirstamp/ 2>/dev/null;
  mv ~/.emacs-lisp ~/.oldrcs/$dirstamp/ 2>/dev/null;
  mv ~/.gemrc  ~/.oldrcs/$dirstamp/ 2>/dev/null;
  mv ~/.getmail  ~/.oldrcs/$dirstamp/ 2>/dev/null;
  mv ~/.gitconfig  ~/.oldrcs/$dirstamp/ 2>/dev/null;
  mv ~/.githelpers  ~/.oldrcs/$dirstamp/ 2>/dev/null;
  mv ~/.gitmodules  ~/.oldrcs/$dirstamp/ 2>/dev/null;
  mv ~/.hgrc  ~/.oldrcs/$dirstamp/ 2>/dev/null;
  mv ~/.minttyrc ~/.oldrcs/$dirstamp/ 2>/dev/null;
  mv ~/.mutt  ~/.oldrcs/$dirstamp/ 2>/dev/null;
  mv ~/.proxybash ~/.oldrcs/$dirstamp/ 2>/dev/null;
  mv ~/.ps1rc ~/.oldrcs/$dirstamp/ 2>/dev/null;
  mv ~/.offlineimap.py ~/.oldrcs/$dirstamp/ 2>/dev/null;
  mv ~/.offlineimaprc  ~/.oldrcs/$dirstamp/ 2>/dev/null;
  mv ~/.rvmrc  ~/.oldrcs/$dirstamp/ 2>/dev/null;
  mv ~/.screenrc  ~/.oldrcs/$dirstamp/ 2>/dev/null;
  mv ~/.tmux.conf ~/.oldrcs/$dirstamp/ 2>/dev/null;
  mv ~/.userrc  ~/.oldrcs/$dirstamp/ 2>/dev/.userrc;
  mv ~/.vim  ~/.oldrcs/$dirstamp/ 2>/dev/null;
  mv ~/.vimrc  ~/.oldrcs/$dirstamp/ 2>/dev/null;
  mv ~/.zprofile  ~/.oldrcs/$dirstamp/ 2>/dev/null;
  mv ~/.zsh  ~/.oldrcs/$dirstamp/ 2>/dev/null;
  mv ~/.zshenv  ~/.oldrcs/$dirstamp/ 2>/dev/null;
  mv ~/.zshrc  ~/.oldrcs/$dirstamp/ 2>/dev/null;
  mv ~/dfbin  ~/.oldrcs/$dirstamp/ 2>/dev/null;
}
