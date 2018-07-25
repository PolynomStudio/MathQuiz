---------------------------------
-- Addon: MathQuiz
-- Author: Neoxx, Desertus (Nera'thor - EU)
---------------------------------

--[[
- Funktionen fangen mit einem großen Buchstaben an.
- Variablen fangen mit einem kleinen Buchstaben an.
- Funktionsinterene Variablen fangen mit einem '_' an.
- '' wird verwendet und ''''
]]

local L = LibStub('AceLocale-3.0'):GetLocale('MathQuiz', true);

local autorAddon = L['AUTOR_ADDON'];
local versionAddon = 'r7';

local difficulty = 3; -- default difficulty 3
local autoAntwortBoolean = false;
local antwortBoolean = false;

local message;
local author;
local a;
local b;
local c;
local d;

-- quizstatus 0 = kein Quiz, 1 = gestartet, 2 = warten auf Antwort, 3 = richtige Antwort
local quizStatus = 0;

function MQ_OnLoad()
	-- Registrierung des Chatbefehle
	SLASH_MATHEQUIZ1 = L['BEFEHL_MQ'], L['BEFEHL_MATHEQUIZ'];
	local function handler(msg)
		local command, rest = msg:match('^(%S*)%s*(.-)$');
		if (command == L['BEFEHL_START']) then
			MQ_Start();
		elseif (command == L['BEFEHL_STOPP']) then
			MQ_Stop();		
		elseif (command == L['BEFEHL_VERSION']) then
			DEFAULT_CHAT_FRAME:AddMessage(L['BEFEHL_VERSION_VAR_X'](versionAddon));	
		elseif (command == L['BEFEHL_AUTOR']) then
			DEFAULT_CHAT_FRAME:AddMessage(autorAddon);
		elseif (command == L['BEFEHL_LEVEL']) then
			local eingabe = tonumber(rest)
			if (eingabe ~= nil and eingabe >= 0) then
				MQ_Level_Funktion(eingabe);
			else
				DEFAULT_CHAT_FRAME:AddMessage(L['FEHLER_EINGABE_LEVEL']);
			end		
		--[[
		elseif (command == L['BEFEHL_AUTOANTWORT']) then
			MQ_Auto_Antwort_Funktion(string.upper(rest));
		elseif (command == L['BEFEHL_ANTWORT']) then
			MQ_Antwort_Funktion(string.upper(rest));
		]]	
		elseif (command == L['BEFEHL_BESTENLISTE']) then
			MQ_TopScores();
		elseif (command == L['BEFEHL_BESTENLISTE_BEREICH']) then
			if (tonumber(rest) ~= nil and tonumber(rest) >= 0) then
				settings.topScoreListNr = tonumber(rest);
				DEFAULT_CHAT_FRAME:AddMessage(L['BEFEHL_BESTENLISTE_BEREICH_VAR_X'](settings.topScoreListNr));
			else
				DEFAULT_CHAT_FRAME:AddMessage(L['EINGABE_INKORREKT'], 1.0, 0.0, 0.0);
			end
		elseif (command == L['BEFEHL_BESTENLISTE_RESET']) then
			MQ_ResetScore();			
		elseif (command == L['BEFEHL_ANTWORTZEIT']) then
			if (tonumber(rest) ~= nil and tonumber(rest) >= 0) then
				settings.timeToAnswer = tonumber(rest);
				DEFAULT_CHAT_FRAME:AddMessage(L['BEFEHL_ANTWORTZEIT_VAR_X'](settings.timeToAnswer));
			else
				DEFAULT_CHAT_FRAME:AddMessage(L['EINGABE_INKORREKT'], 1.0, 0.0, 0.0);
			end
		elseif (command == L['BEFEHL_WARTEZEIT']) then
			if (tonumber(rest) ~= nil and tonumber(rest) >= 0) then
				settings.timeBetweenQuestions = tonumber(rest);
				DEFAULT_CHAT_FRAME:AddMessage(L['BEFEHL_WARTEZEIT_VAR_X'](settings.timeBetweenQuestions));
			else
				DEFAULT_CHAT_FRAME:AddMessage(L['EINGABE_INKORREKT'], 1.0, 0.0, 0.0);
			end
		elseif (command == L['BEFEHL_AUSGABE']) then
			MQ_Ausgabe_Funktion(string.upper(rest));
		elseif (command == L['BEFEHL_AUSGABE_KANALNUMMER']) then
			if (tonumber(rest) ~= nil and tonumber(rest) >= 0) then
				settings.outputChannelId = tonumber(rest);
				DEFAULT_CHAT_FRAME:AddMessage(L['BEFEHL_AUSGABE_KANALNUMMER_VAR_X'](settings.outputChannelId));
			else
				DEFAULT_CHAT_FRAME:AddMessage(L['EINGABE_INKORREKT'], 1.0, 0.0, 0.0);
			end
		elseif (command == L['BEFEHL_AUSGABE_INFO']) then
			DEFAULT_CHAT_FRAME:AddMessage(L['BEFEHL_AUSGABEINFO_SAGEN']);
			DEFAULT_CHAT_FRAME:AddMessage(L['BEFEHL_AUSGABEINFO_SCHREIEN']);
			DEFAULT_CHAT_FRAME:AddMessage(L['BEFEHL_AUSGABEINFO_GILDE']);
			DEFAULT_CHAT_FRAME:AddMessage(L['BEFEHL_AUSGABEINFO_OFFIZIER']);
			DEFAULT_CHAT_FRAME:AddMessage(L['BEFEHL_AUSGABEINFO_GRUPPE']);
			DEFAULT_CHAT_FRAME:AddMessage(L['BEFEHL_AUSGABEINFO_RAID']);
			DEFAULT_CHAT_FRAME:AddMessage(L['BEFEHL_AUSGABEINFO_BG']);
			DEFAULT_CHAT_FRAME:AddMessage(L['BEFEHL_AUSGABEINFO_KANAL']);
		elseif (command == L['BEFEHL_EINSTELLUNGEN']) then
			DEFAULT_CHAT_FRAME:AddMessage(L['BEFEHL_EINSTELLUNGEN_VAR_X_Y_Z_X1'](settings.outputChannel, settings.timeToAnswer, settings.timeBetweenQuestions, settings.topScoreListNr));
		elseif (command == L['BEFEHL_EINSTELLUNGEN_RESET']) then
			MQ_ResetSettings();	
		else
			DEFAULT_CHAT_FRAME:AddMessage(L['INFO_CHATBEFEHLE']);
			DEFAULT_CHAT_FRAME:AddMessage(L['INFO_START_STOPP_1']);
			DEFAULT_CHAT_FRAME:AddMessage(L['INFO_START_STOPP_2']);
			DEFAULT_CHAT_FRAME:AddMessage(L['INFO_VERSION_1']);
			DEFAULT_CHAT_FRAME:AddMessage(L['INFO_VERSION_2']);
			DEFAULT_CHAT_FRAME:AddMessage(L['INFO_AUTOR_1']);
			DEFAULT_CHAT_FRAME:AddMessage(L['INFO_AUTOR_2']);	
			--[[
			DEFAULT_CHAT_FRAME:AddMessage(L['INFO_AUTOANTWORT_1']);
			DEFAULT_CHAT_FRAME:AddMessage(L['INFO_AUTOANTWORT_2']);
			DEFAULT_CHAT_FRAME:AddMessage(L['INFO_ANTWORT_1']);
			DEFAULT_CHAT_FRAME:AddMessage(L['INFO_ANTWORT_2']);
			]]	
			DEFAULT_CHAT_FRAME:AddMessage(L['INFO_BESTENLISTE_1']);
			DEFAULT_CHAT_FRAME:AddMessage(L['INFO_BESTENLISTE_2']);
			DEFAULT_CHAT_FRAME:AddMessage(L['INFO_BESTENLISTE_BEREICH_1']);
			DEFAULT_CHAT_FRAME:AddMessage(L['INFO_BESTENLISTE_BEREICH_2']);
			DEFAULT_CHAT_FRAME:AddMessage(L['INFO_BESTENLISTE_RESET_1']);
			DEFAULT_CHAT_FRAME:AddMessage(L['INFO_BESTENLISTE_RESET_2']);
			DEFAULT_CHAT_FRAME:AddMessage(L['INFO_ANTWORTZEIT_1']);
			DEFAULT_CHAT_FRAME:AddMessage(L['INFO_ANTWORTZEIT_2']);
			DEFAULT_CHAT_FRAME:AddMessage(L['INFO_WARTEZEIT_1']);
			DEFAULT_CHAT_FRAME:AddMessage(L['INFO_WARTEZEIT_2']);
			DEFAULT_CHAT_FRAME:AddMessage(L['INFO_AUSGABE_1']);
			DEFAULT_CHAT_FRAME:AddMessage(L['INFO_AUSGABE_2']);
			DEFAULT_CHAT_FRAME:AddMessage(L['INFO_AUSGABE_KANALNUMMER_1']);
			DEFAULT_CHAT_FRAME:AddMessage(L['INFO_AUSGABE_KANALNUMMER_2']);
			DEFAULT_CHAT_FRAME:AddMessage(L['INFO_AUSGABE_INFO_1']);
			DEFAULT_CHAT_FRAME:AddMessage(L['INFO_AUSGABE_INFO_2']);
			DEFAULT_CHAT_FRAME:AddMessage(L['INFO_EINSTELLUNGEN_1']);
			DEFAULT_CHAT_FRAME:AddMessage(L['INFO_EINSTELLUNGEN_2']);
			DEFAULT_CHAT_FRAME:AddMessage(L['INFO_EINSTELLUNGEN_RESET_1']);
			DEFAULT_CHAT_FRAME:AddMessage(L['INFO_EINSTELLUNGEN_RESET_2']);
			DEFAULT_CHAT_FRAME:AddMessage(L['INFO_LEVEL_1']);
			DEFAULT_CHAT_FRAME:AddMessage(L['INFO_LEVEL_2']);
		end
	end	
	
	SlashCmdList['MATHEQUIZ'] = handler;
	if (settings ~= nil) then
		settings = settings;
	else
		settings = {outputChannel = 'GUILD', topScoreListNr = 3, timeToAnswer = 15, timeBetweenQuestions = 5, outputChannelId = nil};
	end	
	
	if (scores ~= nil) then
		scores = scores;
	else
		scores = {};
	end
end

function MQ_Stop()
	if (quizStatus > 0) then
		quizStatus = 0;
		local arg8 = settings.outputChannelId;
		MatheQuizFrame:UnregisterEvent('CHAT_MSG_'..settings.outputChannel);
		MatheQuizFrame:UnregisterEvent('CHAT_MSG_PARTY_LEADER');
		MatheQuizFrame:UnregisterEvent('CHAT_MSG_RAID_LEADER');
		MatheQuizFrame:UnregisterEvent('CHAT_MSG_BATTLEGROUND_LEADER');
		SendChatMessage(L['MQ_STOP'], settings.outputChannel, nil, settings.outputChannelId);
		MatheQuizFrame:SetScript('OnUpdate', nil);
		MQ_TopScores();
	else
		DEFAULT_CHAT_FRAME:AddMessage(L['FEHLER_QUIZ_AUS'], 1.0, 0.0, 0.0);
	end
end

function MQ_Start()
	if (quizStatus == 0) then
		SendChatMessage(L['MQ_START_VAR_X_Y'](settings.timeBetweenQuestions, difficulty), settings.outputChannel, nil, settings.outputChannelId);
		quizStatus = 1;
		MatheQuizFrame:SetScript('OnUpdate', MQ_OnUpdate); 
		MatheQuizFrame.TimeSinceLastUpdate = 0;
	else
		DEFAULT_CHAT_FRAME:AddMessage(L['FEHLER_QUIZ_AN'], 1.0, 0.0, 0.0);
	end
end

function MQ_CreateQuestion()

	-- Festlegung welche Aufgabe (siehe unten) zu den einzelnen Schwierigkeitsgraden gehört
	difficulties = {};
	difficulties[1] = { 0, 1 };
	difficulties[2] = { 0, 1, 2, 3 };
	difficulties[3] = { 0, 1, 2, 3, 4, 5 };
	difficulties[4] = { 0, 1, 2, 3, 4, 5, 6, 7 };	

	-- Bestimmung von z bzw. des Aufgabentyps
	local z = difficulties[difficulty][math.random(1, table.getn(difficulties[difficulty]))];

	if (z == 0) then
		-- + 
		a = math.random(-200, 200);
		b = math.random(-200, 200);
		c = '+';
		d = a + b;
		b = MQ_Klammer_Funktion(b);
		m = a..c..b;
	elseif (z == 1) then
		-- -
		a = math.random(-200, 200);
		b = math.random(-200, 200);
		c = '-';
		d = a - b;
		b = MQ_Klammer_Funktion(b);
		m = a..c..b;
	elseif (z == 2) then
		-- *
		a = math.random(-20, 20);
		b = math.random(-20, 20);
		c = '*';
		d = a * b
		
		if (d == 0) then
			d = 0
		end
		
		k = MQ_Klammer_Funktion(b);
		m = a..c..k;
	elseif (z == 3) then
		-- /
		a = math.random(-1000, 1000);
		b = 2;
		c = '/';
		d = a / b;
		m = a..c..b;
	elseif (z == 4) then
		-- ^(1/2)
		a = MQ_Mathe_Wurzel();
		b = '(1/2) '..L['QUADRATWURZEL'];
		c = '^';
		d = math.sqrt (a);
		m = a..c..b;
	elseif (z == 5) then
		-- ^
		a = math.random(-20, 20);
		b = math.random(0, 2);
		c = '^';
		d = a^b;
		a = MQ_Klammer_Funktion(a);
		m = a..c..b;
	elseif (z == 6) then
		-- /
		a = math.random(-500, 500);
		b = MQ_Mathe_Divisor();
		c = '/';
		d = a / b;
		m = a..c..b
	elseif (z == 7) then
		-- (a + b) / e
		a = math.random(-200, 200);
		b = math.random(-200, 200);
		e = math.random(1, 2);
		c = '+';
		f = '/';
		d = (a + b) / e;
		b = MQ_Klammer_Funktion(b);
		-- e = MQ_Klammer_Funktion(e);
		m = '('..a..c..b..')'..f..e;
	elseif (z == 8) then -- Platzhalter bzw. noch nicht implementiert
		-- 42
		a = 42;
		b = 1;
		c = '/';
		d = a / b;
		m = a..c..b
	end
	
	local arg8 = settings.outputChannelId;
	MatheQuizFrame:RegisterEvent('CHAT_MSG_'..settings.outputChannel);
	if settings.outputChannel == 'PARTY' then
		MatheQuizFrame:RegisterEvent('CHAT_MSG_PARTY_LEADER');
	elseif settings.outputChannel == 'RAID' then
		MatheQuizFrame:RegisterEvent('CHAT_MSG_RAID_LEADER');
	elseif settings.outputChannel == 'BATTLEGROUND' then
		MatheQuizFrame:RegisterEvent('CHAT_MSG_BATTLEGROUND_LEADER');
	end
	
	SendChatMessage(L['MQ_FRAGE_VAR_X'](m), settings.outputChannel, nil, settings.outputChannelId);
	quizStatus = 2;
	
	if (antwortBoolean == true) then
		DEFAULT_CHAT_FRAME:AddMessage(L['MQ_ANTWORT_VAR_X'](d), 1.0, 0.5, 0.0);
	end
	
end

function MQ_OnUpdate(self, elapsed)
	if (quizStatus == 0) then
		return;
	elseif (quizStatus == 1) then
		MatheQuizFrame.TimeSinceLastUpdate = MatheQuizFrame.TimeSinceLastUpdate + elapsed;
		if (MatheQuizFrame.TimeSinceLastUpdate > settings.timeBetweenQuestions) then
			MQ_CreateQuestion();
			timeWarning = 0;
			MatheQuizFrame.TimeSinceLastUpdate = 0;
			if (autoAntwortBoolean == true) then
				SendChatMessage(d, settings.outputChannel, nil, settings.outputChannelId);
			end	
		else
			return;
		end
	elseif (quizStatus == 2) then
		MatheQuizFrame.TimeSinceLastUpdate = MatheQuizFrame.TimeSinceLastUpdate + elapsed;
		if ((MatheQuizFrame.TimeSinceLastUpdate > (settings.timeToAnswer / 2)) and (timeWarning == 0)) then
			SendChatMessage((settings.timeToAnswer / 2)..L['MQ_RESTZEIT'], settings.outputChannel, nil, settings.outputChannelId);
			timeWarning = 1;
		elseif (MatheQuizFrame.TimeSinceLastUpdate > settings.timeToAnswer) then
			SendChatMessage(L['MQ_ZEIT_UM_VAR_X'](d), settings.outputChannel, nil, settings.outputChannelId);
			quizStatus = 3;
		end
	elseif (quizStatus == 3) then
		quizStatus = 1;
		MatheQuizFrame.TimeSinceLastUpdate = 0;
	end
end

function MQ_TopScores()
	if not (settings.topScoreListNr == 0) then
		MQ_SortTopScore();
		local x = 1;
		SendChatMessage(L['MQ_BESTENLISTE'], settings.outputChannel, nil, settings.outputChannelId);
		if not (settings.topScoreListNr) then
			settings.topScoreListNr =  math.random(1, 5);
		end
		SendChatMessage('#################', settings.outputChannel, nil, settings.outputChannelId);
		if (scores[x] ~= nil) then
			SendChatMessage(L['MQ_BESTENLISTE_WINNER'](scores[x].name), settings.outputChannel, nil, settings.outputChannelId);
		else
			return;
		end 
		while x <= settings.topScoreListNr do
			if (scores[x] ~= nil) then
				SendChatMessage(scores[x].name..': '..scores[x].points, settings.outputChannel, nil, settings.outputChannelId);
				x = x + 1;
			else
				return;
			end 
		end
	end
end

function MQ_SortTopScore()
	table.sort(scores, function(a1,a2) return a1.points > a2.points end);
end
	
function MQ_EventHandler(event, ...)
	local message, author = ...;
	
	if (event == 'CHAT_MSG_'..settings.outputChannel or event == 'CHAT_MSG_PARTY_LEADER' or event == 'CHAT_MSG_RAID_LEADER' or event == 'CHAT_MSG_BATTLEGROUND_LEADER') then
		if(quizStatus == 2) then
			message = gsub(message, ',', '.');
			
			if (message == tostring(d)) then
				playerData = MQ_GetPlayerData(author);
				playerData.points = playerData.points + 1;
				SendChatMessage(L['MQ_ANTWORT_RICHTIG'](playerData.name, d, playerData.points), settings.outputChannel, nil, settings.outputChannelId);					
				MatheQuizFrame:UnregisterEvent('CHAT_MSG_'..settings.outputChannel);
				MatheQuizFrame:UnregisterEvent('CHAT_MSG_PARTY_LEADER');
				MatheQuizFrame:UnregisterEvent('CHAT_MSG_RAID_LEADER');
				MatheQuizFrame:UnregisterEvent('CHAT_MSG_BATTLEGROUND_LEADER');
				quizStatus = 3;
			end
		end
	end
end

function MQ_ResetScore()
	scores = {};
	DEFAULT_CHAT_FRAME:AddMessage(L['MQ_SCORE_RESET'], 1.0, 0.5, 0.0);
end

function MQ_ResetSettings()
	settings = {outputChannel = 'GUILD', topScoreListNr = 3, timeToAnswer = 15, timeBetweenQuestions = 5, outputChannelId = nil};
	DEFAULT_CHAT_FRAME:AddMessage(L['MQ_SETTINGS_RESET'], 1.0, 0.5, 0.0);
end
	
function MQ_GetPlayerData(playername)
	if (scores[1] ~= nil) then
		for i,v in ipairs(scores) do
			if (v.name == playername) then
				return v;
			end
		end		
		playerData = {name = playername, points = 0};
		table.insert(scores, playerData);
		return playerData;
	else 
		playerData = {name = playername, points = 0};
		table.insert(scores, playerData);
		return playerData;
	end
end

-- weitere Funktionen
function MQ_Mathe_Wurzel()
	local w = math.random(0, 20);
	return math.pow(w, 2);		
end

function MQ_Mathe_Divisor()
	local x = math.random(0, 3);
	if (x == 0) then
		return 4;
	elseif (x == 1) then
		return 5;
	elseif (x == 2) then
		return 8;
	elseif (x == 3) then
		return 10;
	end
end

function MQ_Level_Funktion(_level)
	-- _level = math.floor(_level); -- müsste überall bei Zahleneingabe nachgerüstet werden; Zahl ganzzahlig machen, wenn sie eventuell nicht ganzzahlig ist
	if (_level > 0 and _level <= 4) then
		difficulty = _level;
		DEFAULT_CHAT_FRAME:AddMessage(L['LEVEL_GESETZT_X'](difficulty));
	else
		DEFAULT_CHAT_FRAME:AddMessage(L['FEHLER_EINGABE_LEVEL']);		
	end	
end

function MQ_Auto_Antwort_Funktion(_autoAntwortString)
	if (_autoAntwortString == L['AN']) then
		autoAntwortBoolean = true;
		DEFAULT_CHAT_FRAME:AddMessage(L['AUTOANTWORT_MODUS_STATUS'](autoAntwortString), 0.0, 1.0, 0.0);
	elseif (_autoAntwortString == L['AUS']) then
		autoAntwortBoolean = false;
		DEFAULT_CHAT_FRAME:AddMessage(L['AUTOANTWORT_MODUS_STATUS'](autoAntwortString), 1.0, 0.5, 0.0);
	else
		DEFAULT_CHAT_FRAME:AddMessage(L['EINGABE_INKORREKT'], 1.0, 0.0, 0.0);	
	end
end	

function MQ_Antwort_Funktion(_antwortString)
	if (_antwortString == L['AN']) then
		antwortBoolean = true;
		DEFAULT_CHAT_FRAME:AddMessage(L['ANTWORT_MODUS_STATUS'](antwortString), 0.0, 1.0, 0.0);
	elseif (_antwortString == L['AUS']) then
		antwortBoolean = false;
		DEFAULT_CHAT_FRAME:AddMessage(L['ANTWORT_MODUS_STATUS'](antwortString), 1.0, 0.5, 0.0);
	else
		DEFAULT_CHAT_FRAME:AddMessage(L['EINGABE_INKORREKT'], 1.0, 0.0, 0.0);	
	end
end


function MQ_Ausgabe_Funktion(_ausgabe_Eingabe)
	if (_ausgabe_Eingabe == L['BEFEHL_AUSGABE_SAGEN']) then
		settings.outputChannel = 'SAY';
	elseif (_ausgabe_Eingabe == L['BEFEHL_AUSGABE_SCHREIEN']) then
		settings.outputChannel = 'YELL';
	elseif (_ausgabe_Eingabe == L['BEFEHL_AUSGABE_GILDE']) then
		settings.outputChannel = 'GUILD';
	elseif (_ausgabe_Eingabe == L['BEFEHL_AUSGABE_OFFIZIER']) then
		settings.outputChannel = 'OFFICER';
	elseif (_ausgabe_Eingabe == L['BEFEHL_AUSGABE_GRUPPE']) then
		settings.outputChannel = 'PARTY';
	elseif (_ausgabe_Eingabe == L['BEFEHL_AUSGABE_RAID']) then
		settings.outputChannel = 'RAID';
	elseif (_ausgabe_Eingabe == L['BEFEHL_AUSGABE_BG']) then
		settings.outputChannel = 'BATTLEGROUND';
	elseif (_ausgabe_Eingabe == L['BEFEHL_AUSGABE_KANAL']) then
		settings.outputChannel = 'CHANNEL';
	else
		DEFAULT_CHAT_FRAME:AddMessage(L['EINGABE_INKORREKT'], 1.0, 0.0, 0.0);
		return;
	end
	DEFAULT_CHAT_FRAME:AddMessage(L['BEFEHL_AUSGABE_VAR_X'](settings.outputChannel));
end

function MQ_Klammer_Funktion(_wert)
	if _wert < 0 then
		return '('.._wert..')';
	else
		return _wert;
	end
end