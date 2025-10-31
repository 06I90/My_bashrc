# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
# -a 显示所有文件，包括以点（.）开头的隐藏文件
# -l 以长格式显示文件
# -F 在文件名后添加指示符来标识文件类型，例如 / 表示目录，* 表示可执行文件
# -A 显示所有文件，但不显示 .（当前目录）和 ..（上级目录）这两个特殊文件
# -C 将输出按列排列
# -t 按照时间顺序排列，修改时间晚的文件排在top
# -r 顺序倒置

alias ll='ls --color=auto -Alhtr'

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.




#######################################################--- My alias ---#######################################################

ARCH=riscv
DRIVER5=sf_smac
DRIVER6=openwrt-x2880-driver
OPENWRT5=openwrt-18.06
OPENWRT6=Openwrt-master
LMAC5=wireless-sw-sfax8
LMAC6=wireless-sw-x2880

REPO=-1
set_REPO_based_on_dir() {
    local current_dir="$PWD"
    if [[ "$current_dir" == *$OPENWRT6* ]]; then
        export REPO=1
    elif [[ "$current_dir" == *$OPENWRT5* ]]; then
        export REPO=0
    elif [[ "$current_dir" == *$LMAC6* ]]; then
        export REPO=3
    elif [[ "$current_dir" == *$LMAC5* ]]; then
        export REPO=2
    fi
}
export PROMPT_COMMAND="set_REPO_based_on_dir"

if [[ ":$PATH:" != *":/home/SIFLOWER/jinke.liu/tools/Bear"* ]]; then
    export PATH="$PATH:/home/SIFLOWER/jinke.liu/tools/Bear"
fi

# cscope，暂时无法使用
# CSCOPE_DB="/home/SIFLOWER/jinke.liu/code/6wifi/Openwrt-master/cscope.out"



## 1.1 Grep


### 1.1.1 Only grep in *.c *.h

##### 按字搜索
alias gw='find . -type f \( -name "*.c" -o -name "*.h" \) -print0 | xargs -0 grep -F --color=auto -n -w'

##### hostapd专用，搜索时避开.pc文件夹
# alias gw='find . -type d -name .pc -prune -o -type f \( -name "*.c" -o -name "*.h" \) -print0 | xargs -0 grep -F --color=auto -n -w'

##### g string_part1 string_part2 ... = g "string_part1 string_part2 ..."
##### 非按字搜索，无需输引号，例如需要搜索"return true"，直接"g return true"就可以了
##### 在遇到标点符号时会存在一些bug，所以尽量不要带标点搜索
g() {
    local pattern
    pattern="$*"

    find . -type f \( -name "*.c" -o -name "*.h" \) -exec grep -F --color=auto -nH "$pattern" {} +
}


### 1.1.2 General grep

EXCLUDE=(
  --exclude '*.o.cmd'
  --exclude 'dictionary'
  --exclude '*.js'
  --exclude '*.map'
  --exclude '*.symvers'
  --exclude '*.html'
  --exclude 'tags'
  --exclude 'compile_commands.json*'
  --exclude 'sf2880_c906_dasm'
  --exclude 'sf1688_dasm'
  --exclude 'sf2880_c906_map'
  --exclude 'sf1688_map'
  --exclude 'sf2880_c906_readelf'
)

function f() {
  grep -rnI "${EXCLUDE[@]}" "$@"
}

function w() {
  grep -rnwI "${EXCLUDE[@]}" "$@"
}

##### 查找函数的定义（排除函数调用处）
function ffd() {
    find . -type f \( -name "*.c" -o -name "*.h" \) -print0 | \
    xargs -0 grep -rnI --color=always \
              "${EXCLUDE[@]}" \
              -e "$@" \
    | grep -v ");" \
    | grep -v "if "
}

function wfd() {
    find . -type f \( -name "*.c" -o -name "*.h" \) -print0 | \
    xargs -0 grep -rnwI --color=always \
              "${EXCLUDE[@]}" \
              -e "$@" \
    | grep -v ");" \
    | grep -v "if "
}

##### 在linux仓库使用，排除架构不相关的源码，如果是riscv架构，在./arch目录下只在./arch/riscv下搜索
function fl() {
    find . \( -path "./arch/$ARCH/*" -o -not -path "./arch/*" \) -type f \
        ! -name "*.o.cmd" \
        ! -name "dictionary" \
        ! -name "*.js" \
        ! -name "*.map" \
        ! -name "*.symvers" \
        ! -name "*.html" \
        ! -name "tags" \
        ! -name "compile_commands.json*" \
    | xargs grep -rn --color=auto -I "$@"
}

function wl() {
    find . \( -path "./arch/$ARCH/*" -o -not -path "./arch/*" \) -type f \
        ! -name "*.o.cmd" \
        ! -name "dictionary" \
        ! -name "*.js" \
        ! -name "*.map" \
        ! -name "*.symvers" \
        ! -name "*.html" \
        ! -name "tags" \
        ! -name "compile_commands.json*" \
    | xargs grep -rnw --color=auto -I "$@"
}

function fh() {
    if [[ "$PWD" == *$DRIVER6* ]]; then
        grep -rn "$1" \
            "./Makefile" \
            "./src/umac/fullmac/Makefile" \
            "./src/umac/Makefile" \
            "./src/umac/lmac_config.mk"
        return 0
    elif [[ "$PWD" == *"$DRIVER5"* ]]; then
        grep -rn "$1" \
            "./Makefile" \
            "./src/Makefile" \
            "./src/fmac/Makefile" \
            "./src/bb_src/lmac/lmac_config.mk" \
            "./src/bb_src/umac/umac_config.mk" \
            "./src/bb_src/umac/fullmac/fullmac.mk"
        return 0
    elif [[ "$PWD" == *"$LMAC6"* ]]; then
        grep -rn "$1" \
            "./lmac/lmac_config.mk"
        return 0
    elif [[ "$PWD" == *"$LMAC5"* ]]; then
        grep -rn "$1" \
            "./macsw/lmac_config.mk" \
            "./macsw/ip/lmac/src/siwifi/siwifi_config.h"
        return 0
    elif [ $REPO -eq 1 ]; then
        echo "=====  Linux config  ====="
        cat ./sf_kernel/linux-5.10/.config | grep -rn $1
    elif [ $REPO -eq 0 ]; then
        echo "=====  Linux config  ====="
        cat ../linux-4.14.90-dev/linux-4.14.90/.config | grep -rn $1
    else
        echo "Not match: current directory does not match any conditions"
    fi
    echo -e "\n"
    echo "===== Openwrt config ====="
    cat ./.config | grep -rn $1
}

function wh() {
    if [[ "$PWD" == *$DRIVER6* ]]; then
        grep -rnw "$1" \
            "./Makefile" \
            "./src/umac/fullmac/Makefile" \
            "./src/umac/Makefile" \
            "./src/umac/lmac_config.mk"
        return 0
    elif [[ "$PWD" == *"$DRIVER5"* ]]; then
        grep -rnw "$1" \
            "./Makefile" \
            "./src/Makefile" \
            "./src/fmac/Makefile" \
            "./src/bb_src/lmac/lmac_config.mk" \
            "./src/bb_src/umac/umac_config.mk" \
            "./src/bb_src/umac/fullmac/fullmac.mk"
        return 0
    elif [[ "$PWD" == *"$LMAC6"* ]]; then
        grep -rnw "$1" \
            "./lmac/lmac_config.mk"
        return 0
    elif [[ "$PWD" == *"$LMAC5"* ]]; then
        grep -rnw "$1" \
            "./macsw/lmac_config.mk" \
            "./macsw/ip/lmac/src/siwifi/siwifi_config.h"
        return 0
    elif [ $REPO -eq 1 ]; then
        echo "=====  Linux config  ====="
        cat ./sf_kernel/linux-5.10/.config | grep -rnw $1
    elif [ $REPO -eq 0 ]; then
        echo "=====  Linux config  ====="
        cat ../linux-4.14.90-dev/linux-4.14.90/.config | grep -rnw $1
    else
        echo "Not match: current directory does not match any conditions"
    fi
    echo -e "\n"
    echo "===== Openwrt config ====="
    cat ./.config | grep -rnw $1
}



## 1.2 Simple alias


alias cb='code ~/.bashrc'
alias sb='source ~/.bashrc'
alias cv='code ~/.vimrc'
alias md="md5sum"
alias a='alias'
alias his='history'



## 1.3 Change directory

alias r='cd - > /dev/null 2>&1'

function to() {
    cd ~/code/$1/[oO]pen*
}

function change_directory() {
    local paths=("$@")
    if [ $REPO -eq 1 ]; then
        cd ${paths[0]}
    elif [ $REPO -eq 0 ]; then
        cd ${paths[1]}
    else
        echo "Not match: current directory does not match any conditions"
    fi
}

##### Change to the directory of Openwrt-master or openwrt-18.06
function t() {
    current_dir=$PWD

    # Check if the current path contains 'Openwrt-master' or 'openwrt-18.06'
    if [[ $current_dir == *$OPENWRT6* || $current_dir == *$OPENWRT5* ]]; then
        # Keep going up the directory tree until reaching Openwrt-master or openwrt-18.06
        while [[ $(basename "$current_dir") != $OPENWRT6 && $(basename "$current_dir") != $OPENWRT5 ]]; do
            current_dir=$(dirname "$current_dir")
        done
        # Change to the root directory of Openwrt-master or openwrt-18.06
        cd "$current_dir" || return
    else
        echo "You are not in a directory containing \"openwrt\""
        cd ../..
    fi
}

function li() {
    change_directory "sf_kernel/linux-5.10" "../linux-4.14.90-dev/linux-4.14.90"
}

function s() {
    change_directory "package/kernel/siflower/sf_eth" "package/kernel/sf_eth"
}

function q() {
    change_directory "package/kernel/siflower/openwrt-x2880-driver" "package/kernel/sf_smac"
}

function u() {
    change_directory "package/kernel/siflower/openwrt-x2880-driver/src/umac" "package/kernel/sf_smac/src/bb_src/umac"
}

##### TODO: 不是很完善
function fw() {
    change_directory "package/kernel/siflower/openwrt-x2880-driver/config/wlan_vendor_siflower" "package/kernel/sf_smac/config/a28fullmask"
    ls
}

##### 快速索引到板子根目录对应的目录，在这里进行grep搜索代替在板子上直接搜索（板子上grep太慢）
alias bd='cd build_dir/target*/root-siflower && ls'

##### 用于替换的ko
function ko() {
    change_directory "build_dir/target*/linux*/sf_wifi-1.0/ipkg*/kmod-sf_*/lib/modules/*/" "build_dir/target*/linux*/sf_smac/ipkg*/kmod-sf_*/lib/modules/*/"
}



## 1.4 find


### 1.4.1 general find

alias fd='find -type d -name'
alias ff='find -type f -name'

##### 模糊查找（根据字眼查找，返回含有匹配字眼的文件路径，比如要找siwifi_tx.c，直接fp tx.c即可）
function fp() {
    find -path "*$1*"
}



## 1.5 Git


alias gs='git status -uno'
alias gsv='git status'
alias gd='git diff'
alias gp='git pull'
alias gr='git remote'
alias grv='git remote -v'
alias gc='git checkout'
alias gcb='git checkout -b' # gcb branch_name origin/remote_branch---拉取远程分支到本地，取名为branch_name
alias gba='git branch -avv'
alias gl='git log'
alias p='git show -p'
alias gst='git stash'
alias save='function _save() { commit_hash=$(git rev-parse --short=7 HEAD); git stash save "$1-$commit_hash"; }; _save' # save XXX = git stash save XXX-commit_hash[0-7]
alias list='git stash list'
alias apply='git stash apply'
alias drop='git stash drop'
alias gcm='git commit -s -m'
alias cx1='git reset HEAD~1' # 撤销最新的一个提交（撤销git commit和git add）
alias ht='git reset --hard'
alias gir='git init && git add . && git commit -m "init" >/dev/null 2>&1 && echo "done!"' #新建仓库

gpn() {
    if [ -z "\$1" ]; then
        echo "Please provide the number of commits."
        return 1
    fi
    git fetch origin  # 拉取最新的远程更新
    git log --oneline -n "\$1"  # 显示指定数量的提交记录
}

gps() {
    local remotes_brc_name=$(git branch -avv | grep '*' | awk -F'[][]' '{print $2}' | awk -F'[/:]' '{print $2}')
    if [ $(whoami) == "root" ]; then
        git push origin $remotes_brc_name
    else
        git push origin HEAD:refs/for/$remotes_brc_name
    fi
}

##### --grep=筛选带有字眼的提交记录 --name-only展示涉及的文件名 --oneline显示单行commit_id [tag] theme
cx() {
    git log --grep="$1" --name-only
}



## 1.6 Compile


alias mm='make menuconfig'
alias mkm='make kernel_menuconfig'
alias m1='make -j1 V=sc'
alias m32='make -j32'
##### 查看编译结束生成的镜像文件，方便下载
alias m1-='cd bin/targets/siflower && [ -d "sf21a6826" ] && cd sf21a6826; ll; code $(find . -type f -name "openwrt-siflower-*-squashfs-sysupgrade.bin" -print -quit); t'
alias m32-='cd bin/targets/siflower && [ -d "sf21a6826" ] && cd sf21a6826; ll; code $(find . -type f -name "openwrt-siflower-*-squashfs-sysupgrade.bin" -print -quit); t'
alias jb='yes | ./make.sh'
alias 28='./make.sh a28_ac28'
alias 28s='./make.sh a28_ac28s'


### 1.6.1
function mc() {
    local current_dir=$PWD

    if [[ "$current_dir" == *$OPENWRT6* ]]; then
        make package/kernel/siflower/openwrt-x2880-driver/compile -j32
    elif [[ "$current_dir" == *$OPENWRT5* ]]; then
        make package/kernel/sf_smac/compile -j32
    else
        echo "Current directory does not match any known patterns."
    fi
}

function mc1() {
    local current_dir=$PWD

    if [[ "$current_dir" == *$OPENWRT6* ]]; then
        make package/kernel/siflower/openwrt-x2880-driver/compile -j1 V=sc
    elif [[ "$current_dir" == *$OPENWRT5* ]]; then
        make package/kernel/sf_smac/compile -j1 V=sc
    else
        echo "Current directory does not match any known patterns."
    fi
}

function mc-() {
    local current_dir=$PWD
    if [[ "$current_dir" == *$OPENWRT6* ]]; then
        cd build_dir/target*/linux*/sf_wifi-1.0/ipkg*/kmod-sf_*/lib/modules/*/ && ls
    elif [[ "$current_dir" == *$OPENWRT5* ]]; then
        cd build_dir/target*/linux*/sf_smac/ipkg*/kmod-sf_*/lib/modules/*/ && ls
    else
        echo "Current directory does not match any known patterns."
    fi
}

alias mc1-='mc-'

##### hostapd---usr/bin/wpad
alias hh='cd package/network/services/hostapd'

function h() {
    make package/network/services/hostapd/compile -j32
    h- > /dev/null
    md wpad
    t
}

function h1() {
    make package/network/services/hostapd/compile -j1 V=sc
    h- > /dev/null
    md wpad
    t
}

function h-() {
    local current_dir=$PWD

    if [[ "$current_dir" == *$OPENWRT6* ]]; then
        cd build_dir/target-*/hostapd-*/hostapd-* && ls
    elif [[ "$current_dir" == *$OPENWRT5* ]]; then
        cd build_dir/target-*/hostapd-* && ls
    else
        echo "Current directory does not match any known patterns."
    fi
}

##### netifd---sbin/netifd
alias nn='cd package/network/config/netifd'
alias n='make package/network/config/netifd/compile -j32 && n- > /dev/null && md netifd && t'
alias n1='make package/network/config/netifd/compile -j1 V=sc && n- > /dev/null && md netifd && t'
alias n-='cd build_dir/target-*/netifd-* && ls'

##### backports---lib/modules/5.10.104+/cfg80211.ko
alias bb='cd package/kernel/mac80211'
alias b='make package/kernel/mac80211/compile -j32 && b- > /dev/null && md cfg80211.ko && t'
alias b1='make package/kernel/mac80211/compile -j1 V=sc && b- > /dev/null && md cfg80211.ko && t'
alias b-='cd build_dir/target-*/linux-*/backports-*/net/wireless && ls'

##### sfwifi_iface---usr/bin/sfwifi_iface
alias ii='cd package/siflower/bin/sfwifi_iface/src'
alias i='make package/siflower/bin/sfwifi_iface/compile -j32 && i- > /dev/null && md sfwifi_iface && t'
alias i1='make package/siflower/bin/sfwifi_iface/compile -j1 V=sc && i- > /dev/null && md sfwifi_iface && t'
alias i-='cd build_dir/target-*/sfwifi_iface && ls'

##### iw---/usr/sbin/iw
alias ii='cd package/network/utils/iwinfo'
alias i='make package/network/utils/iw/compile -j31 && i- > /dev/null && md iw && t'
alias i1='make package/network/utils/iw/compile -j1 V=sc && i- > /dev/null && md iw && t'
alias i-='cd build_dir/target*/iw*/iw*'

##### hello---lib/modules/5.10.104+/hello.ko---用于测试的内核模块
alias hi='cd package/kernel/hello/src && code hello.c'
alias mhi='make package/kernel/hello/compile -j32 && mhi- > /dev/null && md hello.ko && t'
alias mhi1='make package/kernel/hello/compile -j1 V=sc'
alias mhi-='cd build_dir/target-*/linux-*/hello* && ls'

##### iw---/usr/sbin/iw
# alias bb='cd package/network/utils/iwinfo/'
# alias b='make package/network/utils/iw/compile -j32'
# alias b1='make package/network/utils/iw/compile -j1 V=sc'
# alias b-='cd build_dir/target*/iw*/iw* && ls'

##### iwinfo---/usr/bin/iwinfo /usr/lib/lua/iwinfo.so /usr/lib/libiwinfo.so.20210430
# alias bb='cd package/network/utils/iwinfo/'
# alias b='make package/network/utils/iwinfo/compile -j32'
# alias b1='make package/network/utils/iwinfo/compile -j1 V=sc'
# alias b-='cd build_dir/target*/libiwinfo* && ls'



## 1.7 Disassemble,


##### use @Openwrt-master---反汇编文件采用覆盖机制，每次生成反汇编文件前记得保存之前的反汇编文件
##### WiFi5 可能需要使用.o文件进行反汇编，因为ko文件中没有足够的符号信息
alias fhb='./staging_dir/toolchain*/bin/*musl-objdump -dlS  ./staging_dir/target*/root-siflower/lib/modules/*/*fmac.ko > wifi.s && echo ok && code wifi.s'
alias fhbf='./staging_dir/toolchain*/bin/*musl-objdump -dlS' # 指定文件进行反汇编
alias fhbb='./staging_dir/toolchain*/bin/*musl-objdump -dlS ./staging_dir/target*/root-siflower/lib/modules/*/cfg80211.ko > backport.s && echo ok && code backport.s'
alias fhbkn='./staging_dir/toolchain*/bin/*musl-objdump -dlS ./sf_kernel/linux-5.10/vmlinux > kn.s && echo ok && code kn.s'



## 1.8 RepositoryMgmt


##### 打开代码仓库
function o() {
    cd ~/code/$1/Openwrt-master && code . && cd - > /dev/null 2>&1
}

function o5() {
    cd ~/code/$1/openwrt-18.06 && code . && cd - > /dev/null 2>&1
}

alias gpa='~/mytools/RepositoryMgmt/git-pull_all.sh' # 更新4个仓库的内容至最新
alias ca='~/mytools/RepositoryMgmt/check_all.sh'     # 查看4个仓库的状态

##### 生成新的仓库，Usage: newr repository_name
function newr() {
    if [ $REPO -eq 1 ]; then
    ~/mytools/RepositoryMgmt/add_repository.sh "$@"
    elif [ $REPO -eq 0 ]; then
    ~/mytools/RepositoryMgmt/5add_repository.sh "$@"
    else
        echo "Not match: current directory does not match any conditions"
    fi
}

# ##### 生成新的仓库之后，需要进行mm并选中两个自定义的内核模块，也需要进行mkm，再执行下面的addc
# alias ueb='~/mytools/RepositoryMgmt/update_easyboard.sh' # 更新EasyBoard的配置，板子上需要先执行. /.bashrc

##### 将各个仓库下的最新提交信息、分支信息，更新至log.txt文件末尾，仅限在openwrt目录下使用；log.txt文件结构为头部自定义，尾部自动生成
function gengl() {
    local current_dir=$PWD

    if [[ "$current_dir" == *$OPENWRT6* ]]; then
        ~/mytools/RepositoryMgmt/gen_git-log.sh
    elif [[ "$current_dir" == *$OPENWRT5* ]]; then
        ~/mytools/RepositoryMgmt/gen_git-log5.sh
    else
        echo "Current directory does not match any known patterns."
    fi
}

##### Bear
alias br='bear -l /home/SIFLOWER/jinke.liu/tools/Bear/libear.so'

function mcc() {
    if [ $REPO -eq 1 ]; then
    ~/tools/Bear/modify_cc_json.sh
    elif [ $REPO -eq 0 ]; then
    ~/tools/Bear/5modify_cc_json.sh
    else
        echo "Not match: current directory does not match any conditions"
    fi
}



## 1.9 Patch
##### Usage: ph/pn/pm ['0'|'1'|'2'|'3 patch_name']，0准备TMP文件夹，1准备git并手动修改文件，2暂存到TMP，3打patch并恢复git
alias ph='. ~/mytools/patch/patch.sh hostapd'     # 打hostapd的patch
alias pn='. ~/mytools/patch/patch.sh netifd'      # 打netifd的patch
alias pb='. ~/mytools/patch/patch.sh mac80211'    # 打backports的patch



## 1.10 Transfer
function tu() {
    ~/mytools/Trans/trans.sh umac_ko ko                         # 传输  umac 的 ko
    ko
    md *
    t
}

function th() {
    ~/mytools/Trans/trans.sh hostapd wpad                       # 传输  hostapd 的 wpad
    h- > /dev/null 2>&1
    md wpad
    t
}

function tb() {
    ~/mytools/Trans/trans.sh backports cfg80211.ko              # 传输  mac80211 的 cfg80211.ko
    b- > /dev/null 2>&1
    md cfg80211.ko
    t
}

alias tn='~/mytools/Trans/trans.sh netifd netifd'               # 传输  netifd 的 netifd

function ti() {                                                 # 传输镜像，Usage: ti [prefix]
    ~/mytools/Trans/trans.sh image image $1
}



## 2.0 孵化器
gsh() {
    if [ -z "$1" ]; then
        echo "Usage: grepsh <search-text>"
        return 1
    fi
    find . -name "*.sh" -exec grep -n --color=auto "$1" {} +
}



###################################### 待整理 ######################################

##### 中兴
alias u1='cd /home/SIFLOWER/jinke.liu/code/zte/linux-5.10/drivers/net/wireless/siflower/umac/'
alias u2='cd /home/SIFLOWER/jinke.liu/code/zte/driver_siflower/umac/fullmac/'
alias hz='cd /home/SIFLOWER/jinke.liu/code/zte/Openwrt-master/build_dir/target-aarch64_cortex-a53_musl/hostapd-wpad-mesh-wolfssl/hostapd-2023-09-08-e5ccbfc6/'
# alias bz='cd /home/SIFLOWER/jinke.liu/code/zte/backport/backports-5.15.8-1/net/wireless'
alias iz='cd /home/SIFLOWER/jinke.liu/code/zte/Openwrt-master/package/siflower/bin/sfwifi_iface/src'
alias binz='cd /home/SIFLOWER/jinke.liu/code/zte/Openwrt-master/package/firmware/siflower-firmware/config/'

##### Use @openwrt-x2880-driver, vim a file with a brief filename no matter it is under umac or fullmac. eg: "vv rx.c"
function vv() {
    if [ -z "$1" ]; then
        echo "Usage: vv <filename> <line>, eg: vv rx.c 100"
        return 1
    fi

    local file_path=""

    if [ -f "src/umac/siwifi_$1" ]; then
        file_path="src/umac/siwifi_$1"
    elif [ -f "src/umac/fullmac/siwifi_$1" ]; then
        file_path="src/umac/fullmac/siwifi_$1"
    else
        echo "File not found: siwifi_$1"
        return 1
    fi

    if [ -n "$2" ]; then
        vim "$file_path" +$2
    else
        vim "$file_path"
    fi
}

# function cc() {
#     if [ -z "$1" ]; then
#         echo "Usage: cc <filename> <line>, eg: cc rx.c 100"
#         return 1
#     fi

#     local current_dir=$PWD
#     local file_path=""

#     if [[ "$current_dir" == *"Openwrt-master"* ]]; then
#         if [ -f "src/umac/siwifi_$1" ]; then
#             file_path="src/umac/siwifi_$1"
#         elif [ -f "src/umac/fullmac/siwifi_$1" ]; then
#             file_path="src/umac/fullmac/siwifi_$1"
#         else
#             echo "File not found: siwifi_$1"
#             return 1
#         fi
#     elif [[ "$current_dir" == *"openwrt-18.06"* ]]; then
#         if [ -f "src/bb_src/umac/siwifi_$1" ]; then
#             file_path="src/bb_src/umac/siwifi_$1"
#         elif [ -f "src/bb_src/umac/fullmac/siwifi_$1" ]; then
#             file_path="src/bb_src/umac/fullmac/siwifi_$1"
#         else
#             echo "File not found: siwifi_$1"
#             return 1
#         fi
#     else
#         echo "Current directory does not match any known patterns."
#     fi

#     if [ -n "$2" ]; then
#         code -g "$file_path":$2
#     else
#         code "$file_path"
#     fi
# }

##### The same as function vv, use @sf_smac
function v5() {
    if [ -z "$1" ]; then
        echo "Usage: v5 <filename> <line>, eg: vv rx.c 100"
        return 1
    fi

    local file_path=""

    if [ -f "src/bb_src/umac/siwifi_$1" ]; then
        file_path="src/bb_src/umac/siwifi_$1"
    elif [ -f "src/bb_src/umac/fullmac/siwifi_$1" ]; then
        file_path="src/bb_src/umac/fullmac/siwifi_$1"
    else
        echo "File not found: siwifi_$1"
        return 1
    fi

    if [ -n "$2" ]; then
        vim "$file_path" +$2
    else
        vim "$file_path"
    fi
}

##### 方便grep之后直接在vim中打开,同时定位到具体的行数,无需再输"+行号"
gg() {
    if [ -n "$1" ]; then
        file_path="${1%%:*}"  # 提取文件路径
        line_number="${1##*:}"  # 提取行号

        if [ -f "$file_path" ] && [ -n "$line_number" ]; then
            vim "+$line_number" "$file_path"
        else
            echo "Invalid format or file not found!"
        fi
    else
        echo "Usage: gg <file_path>:<line_number>"
    fi
}

#######################################################--- lmac ---#######################################################

alias code="/home/SIFLOWER/jinke.liu/tools/VSCode-linux-x64/bin/code"

alias wsw='cd ~/../sunwang.wang'

# 1.1 Transfer


## 1.1.1 Transfer FW

##### 传输编译生成的bin文件到from_local_to_public
alias tl='~/copy.sh > /dev/null 2>&1 \
            && md5sum ../target_bin/*'

alias tlv='~/copy.sh \
            && md5sum ../target_bin/*'

##### Change directory
alias 6='cd ~/code/6/wireless-sw-x2880/lmac_iram'
alias 5='cd ~/code/5/wireless-sw-sfax8/lmac'
alias cvte='cd ~/code/cvte/wireless-sw-sfax8/lmac'
alias mpw3='cd ~/code/mpw3/wireless-sw-x2880/lmac_iram'

##### 注意有俩tools文件夹
function by() {
    if [ $REPO -eq 3 ]; then
        ./make.sh
    elif [ $REPO -eq 2 ]; then
        ./install_a28fullmask.sh
    else
        echo "Not match: current directory does not match any conditions"
    fi
}
