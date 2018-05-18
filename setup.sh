#!/bin/bash

echo "Detected OS: $OSTYPE"

if [ -f ~/.dotfiles/configurations/$OSTYPE.sh ]; then
  if [[ $OSTYPE == *"darwin"* ]]; then
    echo 'Using ~/.bash_profile...'
    if [ -f ~/.bash_profile ]; then
      if grep -q "source ~/.dotfiles/configurations/$OSTYPE.sh" ~/.bash_profile; then
        echo "Aborting. ~/.dotfiles/configurations/$OSTYPE.sh is already sourced in ~/.bash_profile"
      else
        echo "Adding ~/.dotfiles/configurations/$OSTYPE.sh source to ~/.bash_profile"
        echo -e "\nsource ~/.dotfiles/configurations/$OSTYPE.sh" >> ~/.bash_profile
      fi
      source ~/.bash_profile
    else
      echo 'Aborting. Could not find ~/.bash_profile.'
    fi
  else
    echo 'Using ~/.bashrc...'
    if [ -f ~/.bashrc ]; then
      if grep -q "source ~/.dotfiles/configurations/$OSTYPE.sh" ~/.bashrc; then
        echo "Aborting. ~/.dotfiles/configurations/$OSTYPE.sh is already sourced in ~/.bashrc"
      else
        echo "Adding ~/.dotfiles/configurations/$OSTYPE.sh source to ~/.bashrc"
        echo -e "\nsource ~/.dotfiles/configurations/$OSTYPE.sh" >> ~/.bashrc
      fi
      source ~/.bashrc
    else
      echo 'Aborting. Could not find ~/.bashrc.'
    fi
  fi
else
  echo "Aborting. There is no matching configuration for operating system: $OSTYPE"
fi

__dotfiles_symlink_dotfiles() {
  if [[ -d $1 ]]; then
    for file in $1/.*; do
      if [[ -f "$file" ]]; then
        if [[ -f "$HOME/$(basename $file)" ]]; then
          read -p "Removing $HOME/$(basename $file) and symlinking $file Are you sure? <y/n> " prompt
          if [[ $prompt =~ [yY](es)* ]]; then
            rm "$HOME/$(basename $file)"
            ln -s $file "$HOME/$(basename $file)"
          fi
        else
          echo "Symlinking $HOME/$(basename $file) to $file"
          ln -s $file "$HOME/$(basename $file)"
        fi
      fi
    done
  fi
}

__dotfiles_symlink_dotfiles ~/.dotfiles/.configurations
__dotfiles_symlink_dotfiles ~/.dotfiles/.configurations/$OSTYPE

__dotfiles_symlink_file() {
  if [[ -f "$2/$(basename $1)" ]]; then
    read -p "Removing $2/$(basename $1) and symlinking $1 Are you sure? <y/n> " prompt
    if [[ $prompt =~ [yY](es)* ]]; then
      rm "$2/$(basename $1)"
      ln -s $1 $2
    fi
  else
    echo "Symlinking $1 to $2"
    ln -s $1 $2
  fi
}

__dotfiles_symlink_file "$HOME/.dotfiles/.configurations/$OSTYPE/micro/bindings.json" "$HOME/.config/micro"
__dotfiles_symlink_file "$HOME/.dotfiles/.configurations/$OSTYPE/micro/settings.json" "$HOME/.config/micro"
