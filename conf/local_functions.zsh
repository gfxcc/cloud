#
# customized functions
#

# recursively search KEYWORD under current path
function rgp() {
    grep -rn $1 .
}

function srgp() {
    grep --include=\*.{f,h,cpp,c,py,js,html,sh,mk} -rn $1 .
}


#
# cmake
#
init_cmake() {
    wget "https://raw.githubusercontent.com/gfxcc/cloud/master/init/cmake/CMakeLists.txt"
    mkdir build
}

clean_cmake() {
    rm -rf CMakeFiles
    rm CMakeCache.txt
}

#
# gtest
#
init_gtest() {
    wget "https://raw.githubusercontent.com/gfxcc/cloud/master/init/gtest/CMakeLists.txt"
    wget "https://raw.githubusercontent.com/gfxcc/cloud/master/init/gtest/unittest.cc"
    mkdir build
}

#
# make
#
init_make() {
    wget "https://raw.githubusercontent.com/gfxcc/cloud/master/init/make/Makefile"
}


#
# vim
#
clean_vim() {
    setopt rm_star_silent
    rm -rf ~/.vimswap/*
    rm -rf ~/.vimviews/*
    setopt no_rm_star_silent
}

startvimprofile() {
    vim --cmd 'profile start vim.profile' \
        --cmd 'profile func *'                 \
        --cmd 'profile file *' $1
}


#
# config management
#
sync_conf() {
    if [[ "$#" -ge 1  ]]; then
        if [[ "$1" == "pull" ]]; then
            echo "start pull mode"
            # clone config repo
            git clone https://github.com/gfxcc/cloud sync_conf_tmp
            cp sync_conf_tmp/conf/.vimrc ~/.vimrc
            cp sync_conf_tmp/conf/.zhsrc ~/.zshrc
            setopt rm_star_silent
            rm -rf sync_conf_tmp
            setopt no_rm_star_silent
            echo "sync_conf pull SUCCESSE"
        elif [[ "$1" == "push" ]]; then
            echo "start push mode"
            # clone config repo
            git clone https://github.com/gfxcc/cloud sync_conf_tmp
            cp ~/.vimrc sync_conf_tmp/conf/.vimrc
            cp ~/.zshrc sync_conf_tmp/conf/.zshrc

            cd sync_conf_tmp
            git add conf/.vimrc
            git add conf/.zshrc

            # check if commit message is given
            if [[ "$#" == 2 ]]; then
                COMMIT_MSG=$2
            else
                COMMIT_MSG="sync_conf push on $(hostname)"
            fi
            git commit -m "${COMMIT_MSG}"
            git push
            cd ..
            setopt rm_star_silent
            rm -rf sync_conf_tmp
            setopt no_rm_star_silent
            echo "sync_conf push SUCCESSE"
        fi
    else
        echo "Usage: sync_conf (pull|push)"
    fi
}
