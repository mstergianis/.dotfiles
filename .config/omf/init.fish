#!/usr/bin/fish

# C-x C-e functionality
if status --is-interactive
    bind \cx\ce edit_command_buffer
end

# M-w should prepend watch to the current or previous command
function watch_cmd --description 'Prepend `watch` to the current or previous command'
    set -l current (commandline)
    if [ -z "$current" ]
        set -l previous_command "$history[1]"
        commandline -r "watch $previous_command"
        return
    end

    if test "watch" = (string split ' ' --no-empty -- "$current")[1]
        # remove the prepending "watch "
        commandline -r (string sub -s 7 $current)
        return
    end

    set -l current_pos (commandline -C)
    commandline -C 0
    commandline -i "watch "
    commandline -C (math 6 + $current_pos)
end
bind \ew watch_cmd

function vim_cmd --description 'Prepend `vim` to the current or previous command'
    set -l current (commandline)
    if [ -z "$current" ]
        set -l previous_command "$history[1]"
        commandline -r "vim $previous_command"
        return
    end

    if test "vim" = (string split ' ' --no-empty -- "$current")[1]
        # remove the prepending "vim "
        commandline -r (string sub -s 5 $current)
        return
    end

    set -l current_pos (commandline -C)
    commandline -C 0
    commandline -i "vim "
    commandline -C (math 4 + $current_pos)
end
bind \ev vim_cmd

alias ls 'eza --color=auto'
if status --is-interactive
    abbr -ag la 'eza --color=auto -agl'
end

# emacs from the terminal
alias e  'emacsclient -nc -a emacs'
alias em 'emacsclient -n -a emacs'
alias et 'emacsclient -tty'
if status --is-interactive
    abbr -ag esta 'systemctl --user start emacs'
    abbr -ag esto 'systemctl --user stop emacs'
    abbr -ag estat 'systemctl --user status emacs'
end

# kubernetes
if status --is-interactive
    abbr -a -g k 'kubectl'
    abbr -a -g kctx 'kubectl config use-context'
    abbr -a -g t 'tanzu'
end

alias pbcopy 'wl-copy -n'
alias pbpaste 'wl-paste'
if status --is-interactive
    abbr -a -g pb 'pbcopy'
end

# vim
alias vim 'nvim'
export EDITOR='nvim'

# go
set -gx GOPATH "$HOME/go"
set -gx PATH $PATH "$GOPATH/bin"

# local bin
set -gx PATH $PATH "$HOME/.local/bin"
set -gx PATH $PATH "$HOME/.local/bin/git-duet"

# color in terminal is nice for emacs... but bad for ssh
# for ssh compatability good! colors bad
set -gx TERM "xterm-24bit"
if status --is-interactive
    alias ssh='TERM=xterm env ssh'
end

test -S /run/user/(id -u)/gcr/ssh && set -gx SSH_AUTH_SOCK /run/user/(id -u)/gcr/ssh

# ruby
set -gx PATH $PATH "$HOME/.gem/ruby/2.7.0/bin"

# python
alias python 'ipython'
alias py 'python'

# golang
alias grb 'go run build.go'

# aws vault
set -gx AWS_CONFIG_FILE $HOME/aws/olympus

# csp
if status --is-interactive
    abbr -a -g csp 'if ! lpass status -q &>/dev/null; lpass login "mstergianis@pivotal.io"; end; set -x CSP_TOKEN (lpass show --notes "tmc-dev/csp-stg-token"); set -x ACCESS_TOKEN (curl -s -X POST "https://console-stg.cloud.vmware.com/csp/gateway/am/api/auth/api-tokens/authorize?refresh_token=$CSP_TOKEN" | jq -r .access_token); set -x CSP_ORG_ID bc27608b-4809-4cac-9e04-778803963da2'
    abbr -a -g dcsp 'if ! lpass status -q &>/dev/null; lpass login "mstergianis@pivotal.io"; end; set -x CSP_TOKEN (lpass show --notes "tmc-dev/devconsole-stg-token"); set -x ACCESS_TOKEN (curl -s -X POST "https://console-stg.cloud.vmware.com/csp/gateway/am/api/auth/api-tokens/authorize?refresh_token=$CSP_TOKEN" | jq -r .access_token); set -x CSP_ORG_ID 28e4d497-53ac-4ef9-9544-4f938169a168'
    abbr -a -g avo 'aws-vault exec olympus --'
    abbr -a -g vmp 'if ! lpass status -q &>/dev/null; lpass login "mstergianis@pivotal.io"; end; echo -n (lpass show --password Business/vmware.com) | pbcopy;'
    abbr -a -g gt 'if ! lpass status -q &>/dev/null; lpass login "mstergianis@pivotal.io"; end; set -x GITLAB_API_TOKEN (lpass show --note infractl-gitlab-token);'
    abbr -a -g svk 'kubectl-cci login --token (pass show cci-api-token) --server https://api.mgmt.cloud.vmware.com/cci --persist-config=false > ~/.kube/sv.kubeconfig && kubectl --kubeconfig ~/.kube/sv.kubeconfig config use-context cci:calatrava-project:svc-devconsole-tapgui-dev'
    abbr -a -g ksv 'kubectl --kubeconfig ~/.kube/sv.kubeconfig'
    abbr -a -g kgc 'kubectl --kubeconfig ~/.kube/gc.kubeconfig'
end

# infractl env variables
set -gx AWS_VAULT_KEYCHAIN_NAME "mstergianis"
set -gx AWS_ASSUME_ROLE_TTL "1h"
set -gx AWS_CONFIG_FILE "$HOME/.aws/olympus"
set -gx AWS_SESSION_TTL "8h"

abbr gop 'set -x GOPRIVATE gitlab.eng.vmware.com'

# alias j to z
alias j 'z'

if status --is-interactive
    abbr -a -g ms 'sudo mount-stretch'
    abbr -a -g msi 'sudo mount 192.168.1.135:/mnt/stretchvol1'
    abbr -a -g umsr 'sudo umount -R /mnt/stretchvol1'
    abbr -a -g msu 'sudo umount -R /mnt/stretchvol1'
    abbr -a -g sp 'sudo pacman'
    abbr -a -g torrentpath 'realpath . | sed \'s/\/stretchvol1//\' | pbcopy -r'
    abbr -a -g g 'git'
    abbr -a -g gb 'git blame -w -C -C -C'
    abbr -a -g gpu 'git push -u origin (git rev-parse --abbrev-ref HEAD)'
    abbr -a -g gpf 'git push -u fork (git rev-parse --abbrev-ref HEAD)'
    abbr -a -g grao 'git remote add origin git@github.com/mstergianis/'
end

alias vimdiff 'nvim -d'
alias diff 'diff --color=auto'

set -gx DOCKER_BUILDKIT 1
if status --is-interactive
    abbr -a -g d 'docker'
end

# fly (concourse)
if status --is-interactive
    abbr -ag fr 'fly -t esback'
    abbr -ag ft 'fly -t tpe'
end

# base64
if status --is-interactive
    abbr -ag bs 'base64'
end

# grep
if status --is-interactive
    abbr -ag gr 'grep -r . -e'
end

# demo abbreviations (2021-09-01)
if status --is-interactive
    abbr -ag d1 'git clone -b plugin-author-demo git@gitlab.eng.vmware.com:project-star/pstar-backstage-poc.git && cp app-config.local.yaml ./pstar-backstage-poc/'
    abbr -ag d2 'yarn install && yarn create-plugin'
    abbr -ag d3 'et packages/app/package.json'
end

if status --is-interactive
    abbr -ag p 'pnpm'
end

# odpclients
if status --is-interactive
    abbr -ag odpctl '~/.odpcli/odpctl/odpctl'
    abbr -ag odpconfig 'vim ~/.odpcli/odpctl/etc/config.txt'
end

if status --is-interactive
    abbr -ag psh 'pass show -c'
end

if status --is-interactive
    abbr -ag fn 'find . -name \'\''
end

if status --is-interactive
    set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
    set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
    set -gx FZF_CTRL_T_OPTS "--preview 'bat -n --color=always {}"
end

# gke
if status --is-interactive
    set -gx USE_GKE_GCLOUD_AUTH_PLUGIN True
end

# vault token
if status --is-interactive
    set -x VAULT_ADDR https://tpe-vault-rock.eng.vmware.com/
end

if status --is-interactive
    abbr -ag jqdc 'jq \'.data[".dockerconfigjson"]\' -r'
    abbr -ag jqir 'jq \'.[0].RepoDigests[0]\' -r'
    abbr -ag jqvf 'jq -r \'.data["values.yaml"]\''
end

set -gx PATH $PATH $HOME/.krew/bin

alias krew='kubectl-krew'

source "/home/michael/.local/share/google/google-cloud-sdk/path.fish.inc"
bass source "/home/michael/.local/share/google/google-cloud-sdk/completion.bash.inc"

set -gx SEALED_SECRETS_CONTROLLER_NAMESPACE sealed-secrets-controller

set -gx GIT_DUET_CO_AUTHORED_BY 1

if status --is-interactive
    abbr -ag 'gpge' 'gpg --recipient Michael\ Stergianis -e'
end

if status --is-interactive
    abbr -ag rp 'realpath'
    abbr -ag omfe '$EDITOR ~/.config/omf/init.fish'
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

set -gx GBM_BACKEND nvidia-drm
set -gx __GLX_VENDOR_LIBRARY_NAME nvidia
set -gx ELECTRON_OZONE_PLATFORM_HINT auto

set -gx SYSTEMD_EDITOR vim

bass source "$HOME/.config/google-cloud-sdk/completion.bash.inc"

if status --is-interactive
    alias dotfiles '/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
    abbr -ag dot dotfiles
    abbr -ag ds 'dotfiles st'
end

if test -z $DISPLAY && test (tty) = /dev/tty1
   WLR_RENDERER=vulkan sway --unsupported-gpu
end
