----------------------------------------------------------------
--==============================================================

IDENTIFIER = 'S7_Forgetinator'

---@class MODINFO: ModInfo
---@field ModVersion string
---@field ModSettings table
MODINFO = Ext.GetModInfo('666193a1-7736-42cd-9a9c-6ecf99d422eb')

--  ========  AUX FUNCTIONS  ========
Ext.Require("AuxFunctions/Index.lua")
--  =================================

--==============================================================
----------------------------------------------------------------

--  =========
--  TEMPLATES
--  =========

ForgetinatorTemplate = "ce72091d-f834-4db0-a20a-e2f43b52b1d4"
ForgetinatorSafetyOffTemplate = "00c50d8a-39b9-49a3-a160-264191f72ddc"