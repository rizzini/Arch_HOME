#!/bin/bash
export AUR_AUTO_VOTE_PASSWORD="$(gpg --decrypt /home/lucas/Documentos/scripts/aur_vote.senha.gpg)"
aur-auto-vote lucasrizzini
