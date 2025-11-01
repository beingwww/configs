# ============================================================================
# Fish Shell Configuration
# ============================================================================

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# ============================================================================
# Basic Settings
# ============================================================================
set -g -x fish_greeting ''

# ============================================================================
# PATH Configuration
# ============================================================================
set -gx PATH "$HOME/.cargo/bin" $PATH
set -gx PATH /usr/local/go/bin $PATH
set -gx PATH /home/wyl/ln/test/go/lemonade $PATH
set -gx PATH /home/wyl/tools/bin $PATH
set -gx PATH /home/wyl/go/bin $PATH

# ============================================================================
# Proxy Configuration
# ============================================================================
set -l NO_PROXY_BASE "localhost,127.0.0.1"
set -l NO_PROXY_EXTENDED "$NO_PROXY_BASE,.example.com,192.168.0.0/16,10.0.0.0/8,172.16.0.0/12,162.105.85.70"

alias ue188="set -gx https_proxy http://162.105.85.188:7890/; set -gx http_proxy http://162.105.85.188:7890/; set -gx no_proxy $NO_PROXY_BASE,162.105.85.227,0.0.0.0,192.168.155.110"
alias ue1882="set -gx https_proxy http://162.105.85.188:27890/; set -gx http_proxy http://162.105.85.188:27890/; set -gx no_proxy $NO_PROXY_BASE,162.105.85.227,0.0.0.0,192.168.155.110"
alias ue162="set -gx https_proxy http://162.105.85.162:7890/; set -gx http_proxy http://162.105.85.162:7890/; set -gx no_proxy $NO_PROXY_BASE"
alias uel="set -gx https_proxy http://127.0.0.1:7890/; set -gx http_proxy http://127.0.0.1:7890/; set -gx no_proxy $NO_PROXY_BASE"
alias ue="set -gx https_proxy http://162.105.85.188:7890/; set -gx http_proxy http://162.105.85.188:7890/; set -gx no_proxy $NO_PROXY_EXTENDED"
alias uet="set -gx https_proxy http://100.64.151.94:7890/; set -gx http_proxy http://100.64.151.94:7890/; set -gx no_proxy $NO_PROXY_BASE"
alias uem="set -gx https_proxy http://162.105.85.167:7890/; set -gx http_proxy http://162.105.85.167:7890/; set -gx no_proxy $NO_PROXY_BASE"
alias nue="set -e https_proxy; set -e http_proxy; set -e no_proxy"

# Enable proxy by default
ue

# ============================================================================
# Python Aliases
# ============================================================================
alias p=python3
alias ap=/home/wyl/anaconda3/bin/python3
alias pp=/home/wyl/ana310/bin/python3

# ============================================================================
# Editor Aliases
# ============================================================================
alias v=~/nvim/nvim.appimage
alias o=~/nvim.appimage
alias ov=~/nvim.appimage
alias pv=~/nvim.appimage
alias nv=~/nvim_config/nvim.appimage
alias nnv=~/nvim_config/nvim.appimage3
alias cv=/home/wyl/.config/clean_nvim/mnv.sh
alias vv=~/.config/modern-neovim/mnv.sh
alias jv=~/.config/jsnvim/mnv.sh
alias v.='v .'
alias l=vim

# ============================================================================
# Git Aliases
# ============================================================================
alias g=git
alias gm='git checkout master'
alias lg=lazygit

# ============================================================================
# Development Aliases
# ============================================================================
alias m='make -j 32'
alias r="m; and ./test"

# ============================================================================
# Tmux Aliases
# ============================================================================
alias t=tmux
alias to='tmux attach -t 1'

# ============================================================================
# File & Navigation Aliases
# ============================================================================
alias fd=fdfind
alias s=cat
alias b=batcat
alias c=clear
alias ...='cd ../..'
alias ....='cd ../../..'

# ============================================================================
# Tool Aliases
# ============================================================================
alias lnav=/home/wyl/tools/lnav-0.11.2/lnav
alias tor=transmission-cli

# ============================================================================
# System Aliases
# ============================================================================
alias h=history
alias j=jobs
alias k=kill
alias f=fg
alias e="sed -i '\$d' ~/.config/fish/config.fish; echo cd (pwd) >> ~/.config/fish/config.fish; exit"

# ============================================================================
# Kubernetes Helper Functions
# ============================================================================

# Helper function to get pod name
function _k8s_get_pod
    set -l pattern $argv[1]
    kubectl get pods -n hlps-test --field-selector=status.phase=Running \
        -o=jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}' |
        grep "^$pattern" |
        head -n1
end

# Helper function to validate and execute k8s command
function _k8s_exec
    set -l pattern $argv[1]
    set -l cmd $argv[2..-1]
    
    set -l pod_name (_k8s_get_pod $pattern)
    
    if test -z "$pod_name"
        echo "Error: No running pod found matching '$pattern' in namespace hlps-test." >&2
        return 1
    end
    
    eval $cmd
end

function go_external_k8s
    _k8s_exec hlps-control "kubectl -n hlps-test exec -it $pod_name -c hlps-external-service -- /bin/bash"
end

function go_log_external_k8s
    _k8s_exec hlps-control "kubectl -n hlps-test logs $pod_name -c hlps-external-service"
end

function go_control_k8s
    _k8s_exec hlps-control "kubectl -n hlps-test exec -it $pod_name -c hlps-control -- /bin/bash"
end

function go_core_k8s
    _k8s_exec hlps-core "kubectl -n hlps-test exec -it $pod_name -- /bin/bash"
end

function go_ue_k8s
    _k8s_exec hlps-ue "kubectl -n hlps-test exec -it $pod_name -- /bin/bash"
end

# ============================================================================
# Notes
# ============================================================================
# - 如果用 node,使用 nvm use 18
# - tmux-session 管理: tmux-session save / tmux-session restore
alias psg='ps aux | grep -v grep | grep -i -e VSZ -e'
alias ports='netstat -tulanp'
alias fishconfig='v ~/.config/fish/config.fish'


# 让 man 页面更易读
set -gx LESS_TERMCAP_mb \e'[1;32m'
set -gx LESS_TERMCAP_md \e'[1;32m'
set -gx LESS_TERMCAP_me \e'[0m'
set -gx LESS_TERMCAP_se \e'[0m'
set -gx LESS_TERMCAP_so \e'[01;33m'
set -gx LESS_TERMCAP_ue \e'[0m'
set -gx LESS_TERMCAP_us \e'[1;4;31m'

function mkcd
    mkdir -p $argv[1]; and cd $argv[1]
end

function backup
    cp $argv[1] $argv[1].bak.(date +%Y%m%d_%H%M%S)
end

# 简洁的提示符
function fish_prompt
    # 用户名
    set_color green
    echo -n $USER
    set_color normal
    echo -n '@'
    
    # 主机名 (devnew2 显示为 amd)
    set_color cyan
    set -l hostname_display (hostname)
    if test "$hostname_display" = "devnew2"
        echo -n "227"
    else
        echo -n $hostname_display
    end
    set_color normal
    echo -n ' '
    
    # 当前路径
    set_color brblue
    echo -n (prompt_pwd)
    set_color normal
    
    # Git 分支显示
    if git rev-parse --git-dir > /dev/null 2>&1
        set_color yellow
        echo -n ' ('(git branch 2>/dev/null | sed -n '/\* /s///p')')'
    end
    
    set_color normal
    echo -n ' ❯ '
end