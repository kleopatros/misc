# Executed by Bash on startup for interactive non-login shells.

##
# Gets the current branch name.
# Returns:
#   The branch name.
git_branch() {
    git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Configure the primary prompt string displayed before each command.
# Based on https://draculatheme.com/terminal.
# PS1="\[\e[0;35m\]\D{%FT%T}\[\e[m\] "        # date and time
# PS1="\[\e[0;35m\]\t\[\e[m\] "               # time
PS1="\[\e[0;35m\]\u@\h:\[\e[m\]"            # user and host
PS1+="\[\e[1;35m\]\W\[\e[m\]"               # directory
PS1+="\[\e[0;36m\]\$(git_branch)\[\e[m\] "  # branch
PS1+="\[\e[0;31m\]$\[\e[m\] "               # prompt
export PS1;
