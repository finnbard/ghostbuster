#!/bin/bash
# author: Emanuel Söllinger
# date: 2024-06-17
# description: Einfaches Claim-System fuer Verzeichnisse mittels Lockfile. (Kleines Extra: alle aktuellen claims koennen ueber das zentrale ghostbusterboard file gefunden werden)
# usage: . /pfad/zu/cdclaim.sh /pfad/zum/verzeichnis

# parameter
targetDirectory=$1

# startDirectory, lockFile und ghostbusterboard.txt dateipfad
startDirectory=$(pwd) || {
	echo "Fehler: Konnte das aktuelle Verzeichnis nicht ermitteln."
	return 1
}
lockFile="$targetDirectory/claim.lock"
boardFile="/ldata/archive/exchange/scripts_dev/ghostbuster/ghostbusterboard.txt"

#variablen fuer farbige ausgabe
rot="31m"
fettrot="\e[1;$rot"
reset="\e[0m"
trennzeile="==================================================================\n"



# pruefen ob ein parameter uebergeben wurde
if [ -z "$1" ]; then
	echo "Fehler: Bitte einen Pfad als Parameter angeben."
	return 2
fi

# zum gewuenschten pfad wechseln
cd "$targetDirectory" || {
	echo "Fehler: Konnte nicht in den Pfad '$targetDirectory' wechseln."
	return 3
}

# absoluten pfad nach cd verwenden, damit grep und lockfile konsistent sind
currentDirectory=$(pwd)
# $SUDO_USER verwenden, damit auch bei ctmagent der t1user eingetragen wird
currentUser="$SUDO_USER"

# das Directory claimen i.e. dort ein lockFile anlegen
# 1. schauen ob schon ein lockFile da ist
if [ -f "$lockFile" ]; then
	#2. wenn ja, dann schauen ob es ueber dieses script geclaimt wurde
	lastEntry=$(grep -F "Directory: $currentDirectory, User: $currentUser, Status: Claimed at " "$lockFile" | tail -n 1)
	#3. wenn ja, dann den Eintrag ausgeben und mit Fehlercode 0 beenden
	if [ -n "$lastEntry" ]; then
		printf "$fettrot$trennzeile"
		printf "Ghostbuster: \"HALT STOP! Ein Entwickler hat hier schon geclaimed!\"\n"
		printf "$trennzeile\n"
		printf "$lastEntry$reset\n"
		# zurueck zum Startverzeichnis wechseln
		cd "$startDirectory" || {
			echo "Fehler: Konnte nicht zurueck zu '$startDirectory' wechseln."
			return 4
		}
		return 0
	fi
fi




#3. wenn nein, dann lockFile anlegen und Eintrag schreiben
touch "$lockFile" || {
	echo "Fehler: Konnte '$lockFile' nicht anlegen."
	return 5
}
echo "Directory: $currentDirectory, User: $currentUser, Status: Claimed at $(date);" >> "$lockFile" || {
	echo "Fehler: Konnte nicht in '$lockFile' schreiben."
	return 6
}


# extra: infos in ghostbusterboard.txt schreiben
echo "Directory: $currentDirectory, User: $currentUser, Status: Claimed at $(date);" >> "$boardFile" || {
	echo "Fehler: Konnte nicht in '$boardFile' schreiben."
	return 7
}
