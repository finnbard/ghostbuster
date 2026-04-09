#!/bin/bash
# author: Emanuel Soellinger
# date: 2026-03-19
# description: Einfaches Claim-System fuer Verzeichnisse mittels Lockfile. (Kleines Extra: alle aktuellen claims koennen ueber das zentrale ghostbusterboard file gefunden werden)
# usage: . /pfad/zu/cwdunclaim.sh


# aktuelles verzeichnis ueber pwd ermitteln
targetDirectory=$(pwd) || {
	echo "Fehler: Konnte das aktuelle Verzeichnis nicht ermitteln."
	return 1
}

# lockFile und ghostbusterboard.txt dateipfad
lockFile="$targetDirectory/claim.lock"
boardFile="/ldata/prod/common/bash/ghostbuster/ghostbusterboard.txt"


#variablen fuer farbige ausgabe
start="\e["
gruen="32m"
fettgruen="\e[1;$gruen"
reset="\e[0m"



# ist ein lockFile vorhanden dann ist das Directory geclaimt und kann unclaimed werden - i.e. lockFile wird entfernt
if [ ! -f "$lockFile" ]; then
	echo "Fehler: Kein Claim-Lockfile gefunden ('$lockFile'). Directory kann nicht unclaimed werden."
	return 2
fi
rm "$lockFile" || {
    echo "Fehler: Konnte '$lockFile' nicht entfernen."
    return 3
}
printf "$fettgruen""SUCCESS: $targetDirectory wurde erfolgreich unclaimed. Lockfile wurde entfernt.""$reset\n"


# extra: eintrag mit aktuellem verzeichnis aus dem ghostbusterboard loeschen
if [ ! -f "$boardFile" ]; then
	echo "Hinweis: ghostbusterboard.txt wurde nicht gefunden."
	return 4
fi

sed -i "\|Directory: $targetDirectory, User: .*, Status: Claimed at .*|d" "$boardFile" || {
    echo "Hinweis: Konnte Eintrag in '$boardFile' nicht entfernen."
    return 5
}
printf "$start$gruen""SUCCESS: Eintrag in '$boardFile' wurde erfolgreich entfernt.""$reset\n"
