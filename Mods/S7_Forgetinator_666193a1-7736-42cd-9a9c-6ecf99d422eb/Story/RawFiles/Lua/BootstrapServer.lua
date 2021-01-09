--  =======
--  IMPORTS
--  =======

Ext.Require('Auxiliary.lua')

--  ===========================
--  GIVE FORGETINATOR TO PLAYER
--  ===========================

Ext.RegisterOsirisListener('SavegameLoaded', 4, 'after', function ()
    local exceptions = {
        ["TUT_Tutorial_A"] = true,
        ["FJ_FortJoy_Main"] = true
    }

    local player = Osi.CharacterGetHostCharacter()
    local check = math.max(Osi.ItemTemplateIsInPartyInventory(player, ForgetinatorTemplate, 1), Osi.ItemTemplateIsInPartyInventory(player, ForgetinatorSafetyOffTemplate, 1))
    if check == 0 then Osi.ItemTemplateAddTo(ForgetinatorTemplate, player, 1, 1) end
end)

--  ===================
--  CHARACTER USED ITEM
--  ===================

Ext.RegisterOsirisListener('CharacterUsedItemTemplate', 3, 'after', function (character, itemTemplate)
    if not Osi.CharacterIsPlayer(character) then return end
    if itemTemplate ~= ForgetinatorTemplate and itemTemplate ~= ForgetinatorSafetyOffTemplate then return end

    local char = Ext.GetCharacter(character)
    for i, skill in pairs(char:GetSkills()) do
        local memCost = Ext.StatGetAttribute(skill, "Memory Cost")
        if memCost ~= 0 then
            if itemTemplate == ForgetinatorTemplate then
                if char:GetSkillInfo(skill).IsActivated then Osi.CharacterRemoveSkill(character, skill) end
            elseif itemTemplate == ForgetinatorSafetyOffTemplate then
                if not char:GetSkillInfo(skill).IsActivated then Osi.CharacterRemoveSkill(character, skill) end
            end
        end
    end
    Osi.ApplyStatus(character, "BLIND", 30.0, 1)
end)