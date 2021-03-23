
--  ============
--  CONTEXT MENU
--  ============

Ext.RegisterListener('SessionLoaded', function ()
    UCL = Mods['S7_UI_Components_Library'] -- Import UI Components Library
    UCL.ContextMenu:QuickRegister({
        ["RootTemplate::" .. ForgetinatorTemplate] = {
            {
                ['actionID'] = 27301,
                ['clickSound'] = true,
                ['text'] = Color:Red("Turn Safeties OFF"),
                ['isDisabled'] = false,
                ['isLegal'] = true
            }
        },
        ["RootTemplate::" .. ForgetinatorSafetyOffTemplate] = {
            {
                ['actionID'] = 27302,
                ['clickSound'] = true,
                ['text'] = Color:Green("Turn Safeties ON"),
                ['isDisabled'] = false,
                ['isLegal'] = true
            }
        }
    })
end)
