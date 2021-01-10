--  ======================
--  CONTEXT MENU RESPONDER
--  ======================

Ext.RegisterNetListener("S7UCL::ContextMenu", function (channel, payload)
    local payload = Ext.JsonParse(payload) or {}
    Destringify(payload)
    if payload.actionID == 27301 then
        local character = Osi.CharacterGetHostCharacter()
        if Osi.ItemTemplateIsInCharacterInventory(character, ForgetinatorTemplate) > 0 then
            Osi.ItemTemplateRemoveFromUser(ForgetinatorTemplate, character, 1)
            Osi.ItemTemplateAddTo(ForgetinatorSafetyOffTemplate, character, 1, 1)
        end
    end
    if payload.actionID == 27302 then
        local character = Osi.CharacterGetHostCharacter()
        if Osi.ItemTemplateIsInCharacterInventory(character, ForgetinatorSafetyOffTemplate) > 0 then
            Osi.ItemTemplateRemoveFromUser(ForgetinatorSafetyOffTemplate, character, 1)
            Osi.ItemTemplateAddTo(ForgetinatorTemplate, character, 1, 1)
        end
    end
end)