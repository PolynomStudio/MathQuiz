local L = LibStub("AceLocale-3.0"):NewLocale("MathQuiz", "deDE");

if not L then
    return
end

L['AUTOR_ADDON'] = 'Nöxli (EU-Azshara), Desertus (EU-Eredar)'
L['EINGABE_INKORREKT'] = 'Die Eingabe ist inkorrekt.'
L['FEHLER_QUIZ_AN'] = 'Das Quiz läuft schon!'
L['FEHLER_QUIZ_AUS'] = 'Das Quiz muss erst gestartet werden!'
L['AN'] = 'AN'
L['AUS'] = 'AUS'
L['BEFEHL_MQ'] = '/mq'
L['BEFEHL_MATHEQUIZ'] = '/mathquiz'
L['BEFEHL_START'] = 'start'
L['BEFEHL_STOPP'] = 'stopp'
L['BEFEHL_VERSION'] = 'version'
L['BEFEHL_AUTOR'] = 'autor'
L['BEFEHL_AUTOANTWORT'] = 'autoantwort'
L['BEFEHL_ANTWORT'] = 'antwort'
L['BEFEHL_BESTENLISTE'] = 'bestenliste'
L['BEFEHL_BESTENLISTE_BEREICH'] = 'bestenliste.bereich'
L['BEFEHL_BESTENLISTE_RESET'] = 'bestenliste.reset'
L['BEFEHL_ANTWORTZEIT'] = 'antwortzeit'
L['BEFEHL_WARTEZEIT'] = 'wartezeit'
L['BEFEHL_AUSGABE'] = 'ausgabe'
L['BEFEHL_AUSGABE_INFO'] = 'ausgabe.info'
L['BEFEHL_AUSGABE_KANALNUMMER'] = 'ausgabe.kanalnummer'
L['BEFEHL_AUSGABEINFO_SAGEN'] = 'Ausgabe in "Sagen" möglich: Sagen'
L['BEFEHL_AUSGABEINFO_SCHREIEN'] = 'Ausgabe in "Schreien" möglich: Schreien'
L['BEFEHL_AUSGABEINFO_GILDE'] = 'Ausgabe in "Gilde" möglich: Gilde'
L['BEFEHL_AUSGABEINFO_OFFIZIER'] = 'Ausgabe in "Offizier" möglich: Offizier'
L['BEFEHL_AUSGABEINFO_GRUPPE'] = 'Ausgabe in "Gruppe" möglich: Gruppe'
L['BEFEHL_AUSGABEINFO_RAID'] = 'Ausgabe in "Schlachtzug" möglich: Schlachtzug'
L['BEFEHL_AUSGABEINFO_BG'] = 'Ausgabe in "Schlachtfeld" möglich: Schlachtfeld'
L['BEFEHL_AUSGABEINFO_KANAL'] = 'Ausgabe in nummerierten Kanälen (d.h. Handel, eigene Kanäle, ...) möglich: Kanal'
L['BEFEHL_AUSGABE_SAGEN'] = 'SAGEN'
L['BEFEHL_AUSGABE_SCHREIEN'] = 'SCHREIEN'
L['BEFEHL_AUSGABE_GILDE'] = 'GILDE'
L['BEFEHL_AUSGABE_OFFIZIER'] = 'OFFIZIER'
L['BEFEHL_AUSGABE_GRUPPE'] = 'GRUPPE'
L['BEFEHL_AUSGABE_RAID'] = 'SCHLACHTZUG'
L['BEFEHL_AUSGABE_BG'] = 'SCHLACHTFELD'
L['BEFEHL_AUSGABE_KANAL'] = 'KANAL'
L['BEFEHL_EINSTELLUNGEN'] = 'einstellungen'
L['BEFEHL_EINSTELLUNGEN_RESET'] = 'einstellungen.reset'
L['BEFEHL_LEVEL'] = 'level'

L['BEFEHL_VERSION_VAR_X'] = function(X)
	return 'Version von MatheQuiz: '..X..'!';
end

L['BEFEHL_BESTENLISTE_BEREICH_VAR_X'] = function(X)
	return 'Die Bestenliste hat nun den Bereich von '..X..'!';
end

L['BEFEHL_ANTWORTZEIT_VAR_X'] = function(X)
	return 'Die Teilnehmer haben nun '..X..' Sekunden zum Antworten!';
end

L['BEFEHL_WARTEZEIT_VAR_X'] = function(X)
	return 'Zwischen den Fragen sind es '..X..' Sekunden!';
end

L['BEFEHL_EINSTELLUNGEN_VAR_X_Y_Z_X1'] = function(X, Y, Z, X1)
	return 'Ausgabe: '..X..', Antwortzeit: '..Y..', Wartezeit: '..Z..', Bereich der Bestenliste: '..X1;
end

L['BEFEHL_AUSGABE_VAR_X'] = function(X)
	return 'Ausgabe im Kanal '..X..'!';
end

L['BEFEHL_AUSGABE_KANALNUMMER_VAR_X'] = function(X)
	return 'Ausgabe im Kanal mit der Nummer '..X..'!';
end

-- _1 ist für oben (Tipp /mq usw.), _2 ist für unten (--> usw.)
L['INFO_CHATBEFEHLE'] = 'Chatbefehle für MatheQuiz'
L['INFO_START_STOPP_1'] = 'Tippe /mq start|stopp'
L['INFO_START_STOPP_2'] = '  --> startet/stoppt das Quiz.'
L['INFO_VERSION_1'] = 'Tippe /mq version'
L['INFO_VERSION_2'] = '  --> zeigt die verwendete Version des Addons.'
L['INFO_AUTOR_1'] = 'Tippe /mq autor'
L['INFO_AUTOR_2'] = '  --> gibt Informationen zum Addon-Autor.'
L['INFO_AUTOANTWORT_1'] = 'Tippe /mq autoantwort <AN/AUS>'
L['INFO_AUTOANTWORT_2'] = '  --> schaltet die AutoAntwort-Funktion ein bzw. aus.'
L['INFO_ANTWORT_1'] = 'Tippe /mq antwort <AN/AUS>'
L['INFO_ANTWORT_2'] = '  --> schaltet die Antwort-Funktion ein bzw. aus.'
L['INFO_BESTENLISTE_1'] = 'Tippe /mq bestenliste'
L['INFO_BESTENLISTE_2'] = '  --> zeigt die Bestenliste.'
L['INFO_BESTENLISTE_BEREICH_1'] = 'Tippe /mq bestenliste.bereich <ZAHL>'
L['INFO_BESTENLISTE_BEREICH_2'] = '  --> passt den Bereich der Bestenliste an.'
L['INFO_BESTENLISTE_RESET_1'] = 'Tippe /mq bestenliste.reset'
L['INFO_BESTENLISTE_RESET_2'] = '  --> setzt die Bestenliste zurück.'
L['INFO_ANTWORTZEIT_1'] = 'Tippe /mq antwortzeit <ZAHL>'
L['INFO_ANTWORTZEIT_2'] = '  --> ändert die Antwortzeit.'
L['INFO_WARTEZEIT_1'] = 'Tippe /mq wartezeit <ZAHL>'
L['INFO_WARTEZEIT_2'] = '  --> ändert die Wartezeit zwischen den Fragen.'
L['INFO_AUSGABE_1'] = 'Tippe /mq ausgabe <KANALART>'
L['INFO_AUSGABE_2'] = '  --> setzt den Ausgabekanal (siehe auch /mq ausgabe.info).'
L['INFO_AUSGABE_KANALNUMMER_1'] = 'Tippe /mq ausgabe.kanalnummer <ZAHL>'
L['INFO_AUSGABE_KANALNUMMER_2'] = '  --> setzt die Nummer des Kanals (nur numerierte Kanäle).'
L['INFO_AUSGABE_INFO_1'] = 'Tippe /mq ausgabe.info'
L['INFO_AUSGABE_INFO_2'] = '  --> gibt Informationen zu den Kanalnamen.'
L['INFO_EINSTELLUNGEN_1'] = 'Tippe /mq einstellungen'
L['INFO_EINSTELLUNGEN_2'] = '  --> zeigt die aktuellen Einstellungen.'
L['INFO_EINSTELLUNGEN_RESET_1'] = 'Tippe /mq einstellungen.reset'
L['INFO_EINSTELLUNGEN_RESET_2'] = '  --> setzt alle Einstellungen zurück.'
L['INFO_LEVEL_1'] = 'Tippe /mq level 1-4 ein'
L['INFO_LEVEL_2'] = '  --> Setzt den Schwierigkeitsgrad der Fragen. 1 ist leicht und 4 ist schwer.'
L['FEHLER_EINGABE_LEVEL'] = 'Dieser Schwierigkeitsgrad ist nicht verfügbar. Erlaubte Schwierigkeitsstufen sind 1 bis 4.'
L['MQ_STOP'] = 'MatheQuiz gestoppt.'

L['LEVEL_GESETZT_X'] = function(X)
	return 'Schwierigkeitsstufe auf '..X..' gesetzt.';
end

L['MQ_START_VAR_X_Y'] = function(X, Y)
	return 'MatheQuiz (Schwierigkeitsstufe: '..Y..') startet in '..X..' Sekunden. Powered by Neoxx & Desertus!';
end

L['QUADRATWURZEL'] = '(INFO: Quadratwurzel!)'

L['MQ_FRAGE_VAR_X'] = function(X)
	return 'Was ist '..X..' ?';
end

L['MQ_ANTWORT_VAR_X'] = function(X)
	return 'Die Antwort ist: '..X;
end

L['MQ_RESTZEIT'] = ' Sekunden übrig!'

L['MQ_ZEIT_UM_VAR_X'] = function(X)
	return 'Die Zeit ist um! Die richtige Antwort ist '..X..'!';
end

L['MQ_BESTENLISTE'] = 'IQ Bestenliste'

L['MQ_BESTENLISTE_WINNER'] = function(X)
	return 'Der Gewinner ist '..X..'!';
end

L['MQ_ANTWORT_RICHTIG'] = function(X, Y, Z)
	return X..' liegt mit '..Y..' richtig! (IQ: '..Z..')';
end

L['MQ_SCORE_RESET'] = 'Bestenliste wurde zurückgesetzt!';

L['MQ_SETTINGS_RESET'] = 'Einstellungen wurden zurückgesetzt!'

L['EXPERIMENT_MODUS_STATUS'] = function(X)
	return 'Experiment-Modus ist '..X..'!';
end

L['AUTOANTWORT_MODUS_STATUS'] = function(X)
	return 'Autoantwort-Modus ist '..X..'!';
end

L['ANTWORT_MODUS_STATUS'] = function(X)
	return 'Antwort-Modus ist '..X..'!';
end
