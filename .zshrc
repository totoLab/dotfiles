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
        PROMPT="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%(4~|%-1~/…/%2~|%3~)%{$fg[red]%}]%{$reset_color%}$%b "
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
PATH=$PATH:~/scripts/

alias rm="rm -i"
# Aliases
if [ -f ~/.config/zsh/.zsh_aliases ]; then
    . ~/.config/zsh/.zsh_aliases
fi

# Load syntax highlighting; should be last.
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
