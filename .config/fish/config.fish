abbr -a tarx 'tar -xzvf'
abbr -a cdp 'cd ~/projects/'
fish_vi_key_bindings default -s
set fish_greeting
alias vi='nvim'
alias vim='nvim'
alias ls='exa'
alias lsl='exa -la'
alias lsg='exa -la --git'
if status is-interactive
and not set -q TMUX
    exec tmux
end
if test "$TERM" = "dumb"
    function fish_title; end
end
