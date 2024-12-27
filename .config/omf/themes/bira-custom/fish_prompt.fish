function __user_host
    set -l content
    if [ (id -u) = "0" ];
        echo -n (set_color --bold red)
    else
        echo -n (set_color --bold green)
    end
    echo -n $USER@(hostname|cut -d . -f 1) (set color normal)
end

function __current_path_abbreviations
    sed \
        -e "s!^$HOME!~!" \
        -e "s!~/workspace/!~/w/!" \
        -e "s!/gitlab.eng.vmware.com/!/glab.vmware/!" \
        -e "s!/github.com/!/ghub/!" \
        -e "s!/esback/!/es/!"
end

function __current_path
    set -l cwd (pwd | __current_path_abbreviations)
    echo -n (set_color --bold blue) $cwd (set_color normal)
end

function _git_branch_name
    echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
end

function _git_is_dirty
    echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
end

function __git_status
    if [ (_git_branch_name) ]
        set -l git_branch (_git_branch_name)

        if [ (_git_is_dirty) ]
            set git_info '<'$git_branch"*"'>'
        else
            set git_info '<'$git_branch'>'
        end

        echo -n (set_color yellow) $git_info (set_color normal)
    end
end

function _dotfiles_branch_name
    echo (command git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
end

function _dotfiles_is_dirty
    echo (command git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME status -s --ignore-submodules=dirty 2> /dev/null)
end
function __dotfiles_status
  if [ (_dotfiles_branch_name) ]
      set -l dotfiles_branch (_dotfiles_branch_name)

      if [ (_dotfiles_is_dirty) ]
          set dotfiles_info 'd<'$dotfiles_branch"*"'>'
      else
          set dotfiles_info 'd<'$dotfiles_branch'>'
      end

      echo -n (set_color red) $dotfiles_info (set_color normal)
  end
end

function __fish_mode
    switch $fish_bind_mode
        case default
            set_color --bold red
            echo -n 'N'
        case insert
            set_color --bold green
            echo -n 'I'
        case replace_one
            set_color --bold green
            echo -n 'R'
        case visual
            set_color --bold brmagenta
            echo -n 'V'
        case '*'
            set_color --bold red
            echo -n '?'
    end
    set_color normal
end

function fish_prompt
    echo -n (set_color white)"╭─"(set_color normal)
    __user_host
    __current_path
    __git_status
    __dotfiles_status
    # __fish_mode
    echo -e ''
    echo (set_color white)"╰─"(set_color --bold white)"\$ "(set_color normal)
end
