#!/bin/bash
# author: Emanuel Söllinger
# date: 2024-06-17
# description: Einfaches Claim-System fuer Verzeichnisse mittels Logfile. (Kleines Extra: alle aktuellen claims stehen auch in einem zentralen file)
# usage: . /pfad/zu/cwdunclaim.sh


# aktuelles verzeichnis ueber pwd ermitteln
targetDirectory=$(pwd) || {
	echo "Fehler: Konnte das aktuelle Verzeichnis nicht ermitteln."
	return 1
}

# logFile und ghostbusterboard.txt dateipfad
logFile="$targetDirectory/claim.log"
boardFile="/ldata/archive/exchange/emanuelsoellinger/ghostbusterboard/ghostbusterboard.txt"

currentUser=$(whoami)



# ist ein logFile vorhanden dann ist das Directory geclaimt und kann unclaimed werden - i.e. logFile wird entfernt
if [ ! -f "$logFile" ]; then
	echo "Fehler: Kein Claim-Logfile gefunden ('$logFile'). Directory kann nicht unclaimed werden."
	return 2
fi
rm "$logFile" || {
    echo "Fehler: Konnte '$logFile' nicht entfernen."
    return 3
}
echo "SUCCESS: $targetDirectory wurde erfolgreich unclaimed. Logfile wurde entfernt."


# extra: eintrag mit aktuellem verzeichnis aus dem ghostbusterboard loeschen
if [ ! -f "$boardFile" ]; then
	echo "Hinweis: ghostbusterboard.txt wurde nicht gefunden."
	return 4
fi

sed -i "\|Directory: $targetDirectory, User: .*, Status: Claimed at .*|d" "$boardFile" || {
    echo "Hinweis: Konnte Eintrag in '$boardFile' nicht entfernen."
    return 5
}
echo "SUCCESS: Eintrag in '$boardFile' wurde erfolgreich entfernt."
