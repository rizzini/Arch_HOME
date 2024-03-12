#!/bin/bash
AUR_AUTO_VOTE_PASSWORD="$(gpg --decrypt /home/lucas/Documentos/scripts/aur_vote.senha.gpg)"
export AUR_AUTO_VOTE_PASSWORD
aur-auto-vote lucasrizzini
