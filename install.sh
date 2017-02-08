#!/bin/bash

DATE="$(date +%Y-%m-%d)"
BACKUP="${HOME}/.oldconf/${DATE}"

LOGFILE="/tmp/install_${DATE}.log"
FAIL_PKG_LIST="/tmp/install_${DATE}_pkgfail.log"

GITHUB_SETUPCONF="https://github.com/M4R5/setupconf"
PATH_SETUPCONF="${HOME}/.setupconf"
PATH_DOTFILES="${PATH_SETUPCONF}/dotfiles"
PATH_PKG_LIST="${PATH_SETUPCONF}/pkglist.txt"
DIR_DOTFILES="${PATH_DOTFILES/${HOME}}"

GITHUB_VUNDLE="https://github.com/VundleVim/Vundle.vim.git"
PATH_VUNDLE="${HOME}/.vim/bundle/Vundle.vim"

echo "Provide root acces :"
sudo echo -n ""

echo "Presetting :"
echo "  => Updating apt base"
sudo apt-get update                 1>>"${LOGFILE}" 2>&1

echo "  => Upgrading all packages"
sudo apt-get dist-upgrade -y        1>>"${LOGFILE}" 2>&1

echo "  => Installing git"
sudo apt-get install -y git         1>>"${LOGFILE}" 2>&1

echo "  => Cloning ${GITHUB_SETUPCONF} in ${PATH_SETUPCONF}"
git clone "${GITHUB_SETUPCONF}" "${PATH_SETUPCONF}" 1>>"${LOGFILE}" 2>&1

echo "  => Reading ${PATH_PKG_LIST} :"
while IFS= read -r pkg; do
    echo -n "    - Installing ${pkg}"
    sudo apt-get install -y "${pkg}"  1>>"${LOGFILE}" 2>&1
    if [ $? -eq 100 ]; then
        echo " : error while installing"
        echo "${pkg}" >> "${FAIL_PKG_LIST}"
    else
        echo " : done"
    fi
done <"${PATH_PKG_LIST}"

echo "Setting :"
echo "  => Creating vim subdirectories"
mkdir -p "${HOME}/.vim/colors"
mkdir -p "${HOME}/.vim/undo"
mkdir -p "${HOME}/.vim/bundle"

echo "  => Creating .config subdirectories"
mkdir -p "${HOME}/.config/terminator"

mkdir -p "${BACKUP}"
echo "  => Creating links :"
find "${PATH_DOTFILES}" | while IFS= read -r realfilepath; do
    [ -d "${realfilepath}" ] && continue

    linkfilepath="${realfilepath/${DIR_DOTFILES}}"
    if [ -e "${linkfilepath}" ]; then
        echo "    - Backup of ${linkfilepath} in ${BACKUP}"
        cp --dereference "${linkfilepath}" "${BACKUP}" 1>>"${LOGFILE}" 2>&1
    fi

    echo "    - Create symbolic link ${realfilepath} ${linkfilepath}"
    ln -sf "${realfilepath}" "${linkfilepath}" 1>>"${LOGFILE}" 2>&1
done

echo "  => Cloning ${GITHUB_VUNDLE} in ${PATH_VUNDLE}"
git clone "${GITHUB_VUNDLE}" "${PATH_VUNDLE}" 1>>"${LOGFILE}" 2>&1
echo "  => Installing vim plugins"
vim +PluginInstall +qall

echo "  => Configuring YouCompleteMe"
python "$HOME/.vim/bundle/YouCompleteMe/install.py" --clang-completer 1>>"${LOGFILE}" 2>&1
