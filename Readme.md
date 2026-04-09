![alt text "Alles wird gut."](./emojilogo/ghostbusterboard-logo_v1-0-0.png "custom ghostbuster logo aus zwei emojis (https://emojipedia.org/ghost + https://emojipedia.org/prohibited) :)")

# Ghostbuster: Simples System zum claimen von Verzeichnissen.

author: Emanuel Soellinger  
date: 2026-03-19  
description: Simples Claim-System fuer Verzeichnisse mittels Lockfile.  
(Kleines Extra: alle aktuellen claims koennen ueber das zentrale ghostbusterboard file gefunden werden)  
usage: ${. /pfad/zu/cdclaim.sh /pfad/zum/verzeichnis} und ${. /pfad/zu/cwdunclaim.sh}  
-- /pfad/zum/verzeichnis soll so aussehen: /ldata/prod/Verarbeitungsordner

alias cdclaim=". /ldata/prod/common/bash/ghostbuster/cdclaim.sh"  
alias cwdunclaim=". /ldata/prod/common/bash/ghostbuster/cwdunclaim.sh"

## Noch einfacher wird die Verwendung ueber dauerhafte Aliase:

1. In ~/.bashrc eintragen (bashrc ist einmal per User):  
echo 'alias cdclaim=". /ldata/prod/common/bash/ghostbuster/cdclaim.sh"' >> ~/.bashrc  
echo 'alias cwdunclaim=". /ldata/prod/common/bash/ghostbuster/cwdunclaim.sh"' >> ~/.bashrc

2. ~/.bashrc neu laden:  
source ~/.bashrc

=====================================  
Genaue Funktionsweise siehe .sh files  
=====================================  
