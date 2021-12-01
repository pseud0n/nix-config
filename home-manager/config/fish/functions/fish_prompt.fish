set __fish_git_prompt_show_informative_status
set __fish_git_prompt_showcolorhints
set __fish_git_prompt_showupstream "informative"

set __fish_git_prompt_char_cleanstate '✔'
set __fish_git_prompt_char_conflictedstate '!'
set __fish_git_prompt_char_dirtystate  '~'
set __fish_git_prompt_char_invalidstate '⨯'
set __fish_git_prompt_char_stagedstate '…'
set __fish_git_prompt_char_stashstate '📦'
set __fish_git_prompt_char_stateseparator ' '
set __fish_git_prompt_char_untrackedfiles '🔍'
set __fish_git_prompt_char_upstream_ahead '↟'
set __fish_git_prompt_char_upstream_behind '↡'
set __fish_git_prompt_char_upstream_diverged '⑂'
set __fish_git_prompt_char_upstream_equal '⑃' 

function fish_prompt --description 'Write out the prompt'
    set laststatus $status

	set -l nix_shell_info (
	  if test -n "$IN_NIX_SHELL"
	    echo -n "❄︁"
	  end
	)

	set __fish_git_prompt_show_informative_status
	set __fish_git_prompt_showcolorhints
	set __fish_git_prompt_showupstream "informative"

	set git_info (__fish_git_prompt) # Includes whitespace

	if not test -z "$nix_shell_info" # If in nix shell
		set info  (set_color -o blue)" $nix_shell_info"(set_color -o normal)
		if not test -z "$git_info" # If in git repo
			set info "$info |$git_info" # Combine both if present
		end
	else
		if not test -z "$git_info"
			set info (set_color -o normal)"$git_info" # In git repo but not nix shell
		end
	end

	set info "$info " # add space if not empty string

    set_color -b normal
    printf '%s%s%s%s' $last_status (set_color -o yellow) (prompt_pwd) "$info" (set_color white)
    if test $laststatus -eq 0
        printf "%s" (set_color -o green)
    else
		printf "%s" (set_color -o red)
    end
	#●
	printf "∿ %s" (set_color normal)
end
