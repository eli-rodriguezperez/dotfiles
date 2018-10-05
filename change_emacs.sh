#!/usr/bin/bash

if [[ -d ".emacs.d_spacemacs" && -d ".emacs.d" ]]; then
    mv .emacs.d/ .emacs.d_vanillamacs/
    mv .emacs.d_spacemacs/ .emacs.d/
	echo "switched to spacemacs succesfully."
elif [[ -d ".emacs.d_vanillamacs" && -d ".emacs.d" ]]; then
    mv .emacs.d/ .emacs.d_spacemacs/
    mv .emacs.d_vanillamacs/ .emacs.d/
	echo "switched to vanilla emacs succesfully."
else
    echo "You do not have the environment properly setup."
fi
