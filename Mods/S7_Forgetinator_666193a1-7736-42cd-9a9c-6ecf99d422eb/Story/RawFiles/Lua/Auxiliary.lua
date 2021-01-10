--  ------------------------------------------------------------
ModInfo = Ext.GetModInfo('666193a1-7736-42cd-9a9c-6ecf99d422eb')
IDENTIFIER = "S7_Forgetinator"
--  ------------------------------------------------------------

--  =====  AUXILIARY FUNCTIONS  ======
Ext.Require("Functions/Auxiliary.lua")
--  ==================================

--  ===============
--  MOD INFORMATION
--  ===============

local modInfoTable = {
    ["Author"] = ModInfo.Author,
    ["Name"] = ModInfo.Name,
    ["UUID"] = ModInfo.UUID,
    ["Version"] = ModInfo.Version,
    ["PublishedVersion"] = ModInfo.PublishVersion,
    ["ModVersion"] = "0.0.0.0"
}

CENTRAL = LoadFile("S7Central.json") or {} --  Holds Global Settings and Information
if CENTRAL[IDENTIFIER] == nil then CENTRAL[IDENTIFIER] = Rematerialize(modInfoTable) end

--  =========  UPDATER  =========
Ext.Require("Shared/Updater.lua")
--  =============================

--- Initialize CENTRAL
---@param ref table Reference table
---@param tar table Target table
local function initCENTRAL(ref, tar)
    for field, value in pairs(ref) do
        if type(value) == 'table' then initCENTRAL(value, tar[field]) end
        if ModInfo[field] then tar[field] = Rematerialize(ModInfo[field])
        else if not tar[field] then tar[field] = Rematerialize(value) end end
    end
end

initCENTRAL(modInfoTable, CENTRAL[IDENTIFIER])
CENTRAL[IDENTIFIER]["ModVersion"] = ParseVersion(ModInfo.Version, "string")
SaveFile("S7Central.json", CENTRAL)

--  =========
--  TEMPLATES
--  =========

ForgetinatorTemplate = "S7_Forgetinator_ce72091d-f834-4db0-a20a-e2f43b52b1d4"
ForgetinatorSafetyOffTemplate = "S7_Forgetinator_SafetyOFF_00c50d8a-39b9-49a3-a160-264191f72ddc"