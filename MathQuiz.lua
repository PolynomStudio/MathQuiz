MathQuiz = LibStub("AceAddon-3.0"):NewAddon("MathQuiz", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("MathQuiz", true)

local options = {
    name = "MathQuiz",
    handler = MathQuiz,
    type = 'group',
}

local defaults = {
    profile = {
        settings = {
            level = 3,
            responsetime = 15,
            idletime = 2,
            score = {
                range = 3,
            }
        },
    },
}

function MathQuiz:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("MathQuiz_DB", defaults)
    options.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
    LibStub("AceConfig-3.0"):RegisterOptionsTable("MathQuiz", options, nil)

    self.db.RegisterCallback(self, "OnNewProfile", "InitializePresets")
    self.db.RegisterCallback(self, "OnProfileReset", "InitializePresets")
    self.db.RegisterCallback(self, "OnProfileChanged", "RefreshConfig")
    self.db.RegisterCallback(self, "OnProfileCopied", "RefreshConfig")

    local ACD = LibStub("AceConfigDialog-3.0")
    ACD:AddToBlizOptions("MathQuiz", "SimpleMacroBindings", nil, "main")
    ACD:AddToBlizOptions("MathQuiz", L["Templates"], "SimpleMacroBindings", "templates")
    ACD:AddToBlizOptions("MathQuiz", L["Profile"], "SimpleMacroBindings", "profile")

    self:RegisterChatCommand("mathquiz", "ChatCommand")
    self:RegisterChatCommand("mq", "ChatCommand")
end
