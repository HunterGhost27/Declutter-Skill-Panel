UCL = Mods['S7_UI_Components_Library'] -- Import UI Components Library

--  ============
--  CONTEXT MENU
--  ============

UCL.ContextMenu:Register({
    ["RootTemplate::" .. ForgetinatorTemplate] = {
        {
            ['actionID'] = 27301,
            ['clickSound'] = true,
            ['text'] = Color:Red("Turn Safties OFF"),
            ['isDisabled'] = false,
            ['isLegal'] = true
        }
    },
    ["RootTemplate::" .. ForgetinatorSafetyOffTemplate] = {
        {
            ['actionID'] = 27302,
            ['clickSound'] = true,
            ['text'] = Color:Green("Turn Safties ON"),
            ['isDisabled'] = false,
            ['isLegal'] = true
        }
    }
})