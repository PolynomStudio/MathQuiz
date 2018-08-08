MathQuiz = LibStub("AceAddon-3.0"):NewAddon("MathQuiz", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("MathQuiz", true)

local version = "@project-version@"

local options = {
    name = "MathQuiz",
    handler = MathQuiz,
    type = "group",
    args = {
        main = {
            name = L["General"],
            type = "group",
            args = {
                response_time = {
                    name = L["RESPONSE_TIME"],
                    desc = L["RESPONSE_TIME_DESC"],
                    type = "input",
                    set = nil,
                    get = nil,
                },
                idle_time = {
                    name = L["IDLE_TIME"],
                    desc = L["IDLE_TIME_DESC"],
                    type = "input",
                    set = nil,
                    get = nil,
                },
            }
        },
        info = {
            name = L["Info"],
            type = "group",
            args = {
                version = {
                    name = L["VERSION"],
                    desc = version,
                    type = "description",
                }
            }
        }
    },
}

local defaults = {
    profile = {
        settings = {
            channel = "guild",
            response_time = 15,
            idle_time = 2,
            score = {
                range = 3,
            },
        },
    },
}

local chatEventMappings = {
    guild = "CHAT_MSG_GUILD",
    party = {
        "CHAT_MSG_PARTY",
        "CHAT_MSG_PARTY_LEADER",
    },
    say = "CHAT_MSG_SAY",
}

MathQuiz.status = {
    channel = "party",
    numerOfQuestions = 0,
    start = false,
}

function MathQuiz:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("MathQuiz_DB", defaults, true)
    options.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
    LibStub("AceConfig-3.0"):RegisterOptionsTable("MathQuiz", options, {"mqc", "mathquizconfig"})

    local ACD = LibStub("AceConfigDialog-3.0")
    ACD:AddToBlizOptions("MathQuiz", "MathQuiz", nil, "main")
    ACD:AddToBlizOptions("MathQuiz", L["Info"], "MathQuiz", "info")
    ACD:AddToBlizOptions("MathQuiz", L["Profile"], "MathQuiz", "profile")

    self:RegisterChatCommand("mq", "ChatCommand")
    self:RegisterChatCommand("mathquiz", "ChatCommand")
end

function MathQuiz:OnEnable()
    -- Called when the addon is enabled
end

function MathQuiz:OnDisable()
    -- Called when the addon is disabled
end

function MathQuiz:ChatCommand(input)
    inputTrim = input:trim()

    if not input or inputTrim == "" then
        InterfaceOptionsFrame_OpenToCategory("MathQuiz")
        InterfaceOptionsFrame_OpenToCategory("MathQuiz")    -- fix for bug
    elseif inputTrim == "start" then
        self:Print(L["QUIZ_START"])
        self:StartQuiz()
    elseif inputTrim == "stop" then
        self:Print(L["QUIZ_STOP"])
        self:StopQuiz()
    else
        LibStub("AceConfigCmd-3.0").HandleCommand(MathQuiz, "mathquiz", "MathQuiz", input)
    end
end

function MathQuiz:StartQuiz()
    self.status.start = true
    self.status.numerOfQuestions = 0

    events = chatEventMappings[self.status.channel]

    if events then
        if type(events) == "table" then
            for _,event in pairs(events) do
                self:RegisterEvent(event, "NewChatMessage")
            end
        else
            self:RegisterEvent(events, "NewChatMessage")
        end
    end
end

function MathQuiz:StopQuiz()
    events = chatEventMappings[self.status.channel]

    if events then
        if type(events) == "table" then
            for _,event in pairs(events) do
                self:UnregisterEvent(event)
            end
        else
            self:UnregisterEvent(events)
        end
    end
end

function MathQuiz:NewChatMessage(event, message, author)
    --@debug@
    self:Print(event)
    self:Print(message)
    self:Print(author)
    --@end-debug@
end
