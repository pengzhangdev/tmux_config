tmux_config
===========

tmux auto rename window : f(){ if [ "$PWD" != "$LPWD" ];then LPWD="$PWD"; tmux rename-window ${PWD//*\//}; fi }; export PROMPT_COMMAND=f;
