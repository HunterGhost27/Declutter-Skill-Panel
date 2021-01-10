--  =======
--  IMPORTS
--  =======

Ext.Require('Auxiliary.lua')

--  ===========================
--  GIVE FORGETINATOR TO PLAYER
--  ===========================

function AddForgetinator()
    if not Ext.OsirisIsCallable() then return end

    local player = Osi.CharacterGetHostCharacter()
    local check = math.max(Osi.ItemTemplateIsInPartyInventory(player, ForgetinatorTemplate, 1), Osi.ItemTemplateIsInPartyInventory(player, ForgetinatorSafetyOffTemplate, 1))
    if check == 0 then
        Osi.ItemTemplateAddTo(ForgetinatorTemplate, player, 1, 1)
        Debug:FPrint("Forgetinator added to host-character's inventory")
    end
end

ConsoleCommander:Register({
    ['Name'] = "AddForgetinator",
    ['Description'] = "Adds Forgetinator to Host-Character's Inventory",
    ['Context'] = "Server",
    ['Action'] = AddForgetinator
})

Ext.RegisterOsirisListener('SavegameLoaded', 4, 'after', function ()
    local exceptions = {
        ["TUT_Tutorial_A"] = true,
        ["FJ_FortJoy_Main"] = true
    }

    local host = Osi.CharacterGetHostCharacter()
    local region = Osi.GetRegion(host)

    if not exceptions[region] and Osi.IsGameLevel(region) then AddForgetinator() end
end)

--  ===================
--  TOGGLE FORGETINATOR
--  ===================

ConsoleCommander:Register({
    ['Name'] = "ToggleForgetinator",
    ['Description'] = "Toggles Forgetinator's Fire-Mode",
    ['Context'] = "Server",
    ['Action'] = function ()
        local player = Osi.CharacterGetHostCharacter()
        if Osi.ItemTemplateIsInCharacterInventory(player, ForgetinatorTemplate) > 0 then
            Osi.ItemTemplateRemoveFromUser(ForgetinatorTemplate, player, 1)
            Osi.ItemTemplateAddTo(ForgetinatorSafetyOffTemplate, player, 1, 1)
        elseif Osi.ItemTemplateIsInCharacterInventory(player, ForgetinatorSafetyOffTemplate) > 0 then
            Osi.ItemTemplateRemoveFromUser(ForgetinatorSafetyOffTemplate, player, 1)
            Osi.ItemTemplateAddTo(ForgetinatorTemplate, player, 1, 1)
        end
    end
})

--  ===================
--  CHARACTER USED ITEM
--  ===================

Ext.RegisterOsirisListener('CharacterUsedItemTemplate', 3, 'after', function (character, itemTemplate)
    if not Osi.CharacterIsPlayer(character) then return end
    local _, _, itemTemplate = itemTemplate:find(".*_(.-)$")
    if itemTemplate ~= ForgetinatorTemplate and itemTemplate ~= ForgetinatorSafetyOffTemplate then return end

    local char = Ext.GetCharacter(character)
    for _, skill in pairs(char:GetSkills()) do
        local slot = Osi.NRD_SkillbarFindSkill(character, skill)
        if itemTemplate == ForgetinatorTemplate then
            local memCost = Ext.StatGetAttribute(skill, "Memory Cost")
            if memCost ~= 0 then
                if char:GetSkillInfo(skill).IsActivated then
                    Osi.CharacterRemoveSkill(character, skill)
                    Osi.NRD_SkillBarClear(character, slot)
                end
            end
        elseif itemTemplate == ForgetinatorSafetyOffTemplate then
            if not slot then Osi.CharacterRemoveSkill(character, skill) end
        end
    end
    Osi.PlayEffect(character, "RS3_FX_Skills_Divine_BlindingRadiance_Cast_Root_01")
    Osi.ApplyStatus(character, "BLIND", 30.0, 1)
end)

--  ====================
--  CONTEXT MENU HANDLER
--  ====================

if Ext.IsModLoaded("b66d56c6-12f9-4abc-844f-0c30b89d32e4") then -- UI Components Library Loaded
    Ext.Require('Server/ContextMenu.lua')
end