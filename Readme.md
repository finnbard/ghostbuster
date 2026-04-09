![alt text "Alles wird gut."](./emojilogo/ghostbusterboard-logo_v1-0-0.png "custom ghostbuster logo aus zwei emojis (https://emojipedia.org/ghost + https://emojipedia.org/prohibited) :)")

# Ghostbuster: Simples System zum claimen von Verzeichnissen.

**author**: Emanuel Soellinger  
**date**: 2026-03-19  
**description**: Simples System um Verzeichnisse mittels Lockfile zu claimen (== als "in Verwendung" markieren).
Dadurch soll verhindert werden, dass mehrere Entwickler gleichzeitig in einem Ordner arbeiten und sich dabei gegenseitig in die Quere kommen.
(Kleines Extra: alle aktuellen Claims koennen ueber das zentrale ghostbusterboard file gefunden werden)  
**usage**: ${. /pfad/zu/cdclaim.sh /pfad/zum/verzeichnis} und ${. /pfad/zu/cwdunclaim.sh}  
-- Der cdclaim-Befehl ist von der Logik her wie cd zu verwenden d.h. Aufruf mit: **cdclaim /relativer/oder/absoluter/Pfad/zum/Verzeichnis** -- **cwdunclaim** wird ohne Parameter aufgerufen!  

Einfachere Verwendung per Alias:  

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
