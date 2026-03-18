#!/bin/bash
# author: Emanuel Söllinger
# date: 2024-06-17
# description: Einfaches Claim-System fuer Verzeichnisse mittels Logfile. (Kleines Extra: alle aktuellen claims stehen auch in einem zentralen file)
# usage: . /pfad/zu/cdclaim.sh /pfad/zum/verzeichnis


# parameter
targetDirectory=$1

# ghostbusterboard.txt dateipfad
boardFile="/ldata/archive/exchange/emanuelsoellinger/ghostbusterboard/ghostbusterboard.txt"

#variablen fuer farbige ausgabe
rot="31m"
fettrot="\e[1;$rot"
reset="\e[0m"
trennzeile="==================================================================\n"



# pruefen ob ein parameter uebergeben wurde
if [ -z "$1" ]; then
	echo "Fehler: Bitte einen Pfad als Parameter angeben."
	return 1
fi

# zum gewuenschten pfad wechseln
cd "$targetDirectory" || {
	echo "Fehler: Konnte nicht in den Pfad '$targetDirectory' wechseln."
	return 2
}

# absoluten pfad nach cd verwenden, damit grep und logfile konsistent sind
currentDirectory=$(pwd)
logFile="$currentDirectory/claim.log"
currentUser=$(whoami)

# das Directory claimen i.e. dort ein Logfile anlegen
# 1. schauen ob schon ein logFile da ist
if [ -f "$logFile" ]; then
	#2. wenn ja, dann schauen ob es ueber dieses script geclaimt wurde
	lastEntry=$(grep -F "Directory: $currentDirectory, User: " "$logFile" | tail -n 1)
	#3. wenn ja, dann den Eintrag ausgeben und mit Fehlercode 0 beenden
	if [ -n "$lastEntry" ]; then
		printf "$fettrot$trennzeile"
		printf "Ghostbuster: \"HALT STOP! Ein Entwickler hat hier schon geclaimed!\"\n"
		printf "$trennzeile\n"
		printf "$lastEntry$reset\n"
		return 0
	fi
fi

# 4. wenn nein, dann logFile anlegen und Eintrag schreiben
touch "$logFile" || {
	echo "Fehler: Konnte '$logFile' nicht anlegen."
	return 3
}
echo "Directory: $currentDirectory, User: $currentUser, Status: Claimed at $(date);" >> "$logFile" || {
	echo "Fehler: Konnte nicht in '$logFile' schreiben."
	return 4
}


# extra: infos in ghostbusterboard.txt schreiben
echo "Directory: $currentDirectory, User: $currentUser, Status: Claimed at $(date);" >> "$boardFile" || {
	echo "Fehler: Konnte nicht in '$boardFile' schreiben."
	return 5
}
