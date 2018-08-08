local L = LibStub("AceLocale-3.0"):NewLocale("MathQuiz", "enUS", true, true)

if not L then
	return
end

L['AUTOR_ADDON'] = 'Nöxli (EU-Azshara), Desertus (EU-Eredar)'
L['EINGABE_INKORREKT'] = 'Incorrect input.'
L['FEHLER_QUIZ_AN'] = 'Quiz is already running!'
L['FEHLER_QUIZ_AUS'] = 'Quiz needs to be started first!'
L['AN'] = 'ON'
L['AUS'] = 'OFF'
L['BEFEHL_MQ'] = '/mq'
L['BEFEHL_MATHEQUIZ'] = '/mathequiz' -- bleibt so
L['BEFEHL_START'] = 'start'
L['BEFEHL_STOPP'] = 'stop'
L['BEFEHL_VERSION'] = 'version'
L['BEFEHL_AUTOR'] = 'author'
L['BEFEHL_AUTOANTWORT'] = 'autoanswer'
L['BEFEHL_ANTWORT'] = 'answer'
L['BEFEHL_BESTENLISTE'] = 'score'
L['BEFEHL_BESTENLISTE_BEREICH'] = 'score.range'
L['BEFEHL_BESTENLISTE_RESET'] = 'score.reset'
L['BEFEHL_ANTWORTZEIT'] = 'responsetime'
L['BEFEHL_WARTEZEIT'] = 'idletime'
L['BEFEHL_AUSGABE'] = 'output'
L['BEFEHL_AUSGABE_INFO'] = 'output.info'
L['BEFEHL_AUSGABE_KANALNUMMER'] = 'output.channel'
L['BEFEHL_AUSGABEINFO_SAGEN'] = 'Output in "Say" is possible: Say'
L['BEFEHL_AUSGABEINFO_SCHREIEN'] = 'Output in "Yell" is possible: Yell'
L['BEFEHL_AUSGABEINFO_GILDE'] = 'Output in "Guild" is possible: Guild'
L['BEFEHL_AUSGABEINFO_OFFIZIER'] = 'Output in "Officer" is possible: Officer'
L['BEFEHL_AUSGABEINFO_GRUPPE'] = 'Output in "Party" is possible: Party'
L['BEFEHL_AUSGABEINFO_RAID'] = 'Output in "Raid" is possible: Raid'
L['BEFEHL_AUSGABEINFO_BG'] = 'Output in "Battleground" is possible: Battleground'
L['BEFEHL_AUSGABEINFO_KANAL'] = 'Output in numbered channels (i.e. Trade, custom channels, ...) is possible: Channel'
L['BEFEHL_AUSGABE_SAGEN'] = 'SAY'
L['BEFEHL_AUSGABE_SCHREIEN'] = 'YELL'
L['BEFEHL_AUSGABE_GILDE'] = 'GUILD'
L['BEFEHL_AUSGABE_OFFIZIER'] = 'OFFICER'
L['BEFEHL_AUSGABE_GRUPPE'] = 'PARTY'
L['BEFEHL_AUSGABE_RAID'] = 'RAID'
L['BEFEHL_AUSGABE_BG'] = 'BATTLEGROUND'
L['BEFEHL_AUSGABE_KANAL'] = 'CHANNEL'
L['BEFEHL_EINSTELLUNGEN'] = 'settings'
L['BEFEHL_EINSTELLUNGEN_RESET'] = 'settings.reset'
L['BEFEHL_LEVEL'] = 'level'

L['BEFEHL_VERSION_VAR_X'] = function(X)
	return 'Version of MatheQuiz: '..X..'!';
end

L['BEFEHL_BESTENLISTE_BEREICH_VAR_X'] = function(X)
	return 'The score hat a range of '..X..' now!';
end

L['BEFEHL_ANTWORTZEIT_VAR_X'] = function(X)
	return 'The participants have '..X..' seconds for responses now!';
end

L['BEFEHL_WARTEZEIT_VAR_X'] = function(X)
	return 'There are '..X..' seconds between the questions now!';
end

L['BEFEHL_EINSTELLUNGEN_VAR_X_Y_Z_X1'] = function(X, Y, Z, X1)
	return 'Output: '..X..', Response time: '..Y..', Idle time: '..Z..', Score range: '..X1;
end

L['BEFEHL_AUSGABE_VAR_X'] = function(X)
	return 'Output in channel '..X..'!';
end

L['BEFEHL_AUSGABE_KANALNUMMER_VAR_X'] = function(X)
	return 'Output in channel number '..X..'!';
end

-- _1 ist für oben (Tipp /mq usw.), _2 ist für unten (--> usw.)
L['INFO_CHATBEFEHLE'] = 'Chat commands for MatheQuiz'
L['INFO_START_STOPP_1'] = 'Type /mq start|stop'
L['INFO_START_STOPP_2'] = '  --> starts/stops the quiz.'
L['INFO_VERSION_1'] = 'Type /mq version'
L['INFO_VERSION_2'] = '  --> shows the used version of the addon.'
L['INFO_AUTOR_1'] = 'Type /mq author'
L['INFO_AUTOR_2'] = '  --> shows information about the author.'
L['INFO_AUTOANTWORT_1'] = 'Type /mq autoanswer ON/OFF>'
L['INFO_AUTOANTWORT_2'] = '  --> Toggles auto-answering mode on/off.'
L['INFO_ANTWORT_1'] = 'Type /mq answer <ON/OFF>'
L['INFO_ANTWORT_2'] = '  --> Toggles answering mode on/off.'
L['INFO_BESTENLISTE_1'] = 'Type /mq score'
L['INFO_BESTENLISTE_2'] = '  --> shows the score.'
L['INFO_BESTENLISTE_BEREICH_1'] = 'Type /mq score.range <NUMBER>'
L['INFO_BESTENLISTE_BEREICH_2'] = '  --> sets the score range.'
L['INFO_BESTENLISTE_RESET_1'] = 'Type /mq score.reset'
L['INFO_BESTENLISTE_RESET_2'] = '  --> resets the score.'
L['INFO_ANTWORTZEIT_1'] = 'Type /mq responsetime <NUMBER>'
L['INFO_ANTWORTZEIT_2'] = '  --> sets the response time.'
L['INFO_WARTEZEIT_1'] = 'Type /mq idletime <NUMBER>'
L['INFO_WARTEZEIT_2'] = '  --> sets the idle time between questions.'
L['INFO_AUSGABE_1'] = 'Type /mq output <CHANNEL TYPE>'
L['INFO_AUSGABE_2'] = '  --> sets the output channel type (see /mq output.info).'
L['INFO_AUSGABE_KANALNUMMER_1'] = 'Type /mq output.channel <NUMBER>'
L['INFO_AUSGABE_KANALNUMMER_2'] = '  --> sets the number of the output channel (numerated channels only).'
L['INFO_AUSGABE_INFO_1'] = 'Type /mq output.info'
L['INFO_AUSGABE_INFO_2'] = '  --> shows information about channel names.'
L['INFO_EINSTELLUNGEN_1'] = 'Type /mq settings'
L['INFO_EINSTELLUNGEN_2'] = '  --> shows current settings.'
L['INFO_EINSTELLUNGEN_RESET_1'] = 'Type /mq settings.reset'
L['INFO_EINSTELLUNGEN_RESET_2'] = '  --> resets all settings.'
L['INFO_LEVEL_1'] = 'Type /mq level 1-4'
L['INFO_LEVEL_2'] = '  --> Sets the difficulty of the questions. 1 is easy and 4 is hard.'
L['FEHLER_EINGABE_LEVEL'] = 'That difficulty is not implemented. Available difficulties are 1 to 4.'
L['MQ_STOP'] = 'MatheQuiz stopped.'

L['LEVEL_GESETZT_X'] = function(X)
	return 'Difficulty set to '..X..'.';
end

L['MQ_START_VAR_X_Y'] = function(X, Y)
	return 'MatheQuiz (difficulty: '..Y..') is going to be started in '..X..' seconds. Powered by Neoxx & Desertus!';
end

L['QUADRATWURZEL'] = '(INFO: square root!)'

L['MQ_FRAGE_VAR_X'] = function(X)
	return 'What is '..X..' ?';
end

L['MQ_ANTWORT_VAR_X'] = function(X)
	return 'The answer is: '..X;
end

L['MQ_RESTZEIT'] = ' seconds remaining!'

L['MQ_ZEIT_UM_VAR_X'] = function(X)
	return 'Time is over! The correct answer is '..X..'!';
end

L['MQ_BESTENLISTE'] = 'IQ score'

L['MQ_BESTENLISTE_WINNER'] = function(X)
	return 'The winner is '..X..'!';
end

L['MQ_ANTWORT_RICHTIG'] = function(X, Y, Z)
	return X..' is right with '..Y..'! (IQ: '..Z..')';
end

L['MQ_SCORE_RESET'] = 'Scores have been reset!';

L['MQ_SETTINGS_RESET'] = 'Settings have been reset!'

L['EXPERIMENT_MODUS_STATUS'] = function(X)
	return 'Experimental mode is '..X..'!';
end

L['AUTOANTWORT_MODUS_STATUS'] = function(X)
	return 'Auto-answer mode is '..X..'!';
end

L['ANTWORT_MODUS_STATUS'] = function(X)
	return 'Answer-mode is '..X..'!';
end
