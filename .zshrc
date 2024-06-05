#
# ~/.zshrc
#

# Enable colors and change prompt:
autoload -U colors && colors	# Load colors

setopt prompt_subst

# Define a function to update the prompt
update_prompt() {
    if [ -f ~/.config/zsh/.shell_prompt ]; then
        PROMPT=$(. ~/.config/zsh/.shell_prompt)
    else
        # fallback prompt
	PROMPT="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
    fi
}

update_prompt

chpwd() {
    update_prompt
}

setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.cache/.zsh_history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# PATH
scripts_path="$HOME/scripts/"
PATH=$PATH$( find $scripts_path -type d -not -path "*/.sync/*" -printf ":%p" )

alias rm="rm -i"
# Aliases
if [ -f ~/.config/zsh/.zsh_aliases ]; then
    . ~/.config/zsh/.zsh_aliases
fi

auto_completion_path="~/.config/zsh/.zsh-completions"
if [ -d $auto_completion_path ]; then
    fpath=($auto_completion_path $fpath)
fi


# Load syntax highlighting; should be last.
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null


# Load Angular CLI autocompletion.
source <(ng completion script)
