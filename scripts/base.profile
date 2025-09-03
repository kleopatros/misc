# Executed on startup for interactive login shells.

ssh_agent_env=~/.ssh/agent.env

load_ssh_agent_env() {
  test -f "$ssh_agent_env" && . "$ssh_agent_env" >| /dev/null
}

start_ssh_agent() {
  umask 077
  ssh-agent >| "$ssh_agent_env"
  . "$ssh_agent_env" >| /dev/null
}

# Automatically run ssh-agent on startup and prompt for passphrases. The ssh-agent process runs
# until termination, logout, or shutdown.

load_ssh_agent_env

# Status: 0 = agent running with key; 1 = agent running without key; 2 = agent not running.
ssh_agent_status=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $ssh_agent_status = 2 ]; then
    start_ssh_agent
    ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $ssh_agent_status = 1 ]; then
    ssh-add
fi

unset ssh_agent_env
