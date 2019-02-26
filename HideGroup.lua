HideGroup = HideGroup or {}
local HG = HideGroup
local EM = GetEventManager()

HG.name = "HideGroup"
HG.version = "1.0"

local function hideMembers(enable)
	if enable == true then
		SetCrownCrateNPCVisible(true)
		SetSetting(SETTING_TYPE_NAMEPLATES, NAMEPLATE_TYPE_GROUP_MEMBER_NAMEPLATES, tostring(NAMEPLATE_CHOICE_NEVER))
		SetSetting(SETTING_TYPE_NAMEPLATES, NAMEPLATE_TYPE_GROUP_MEMBER_HEALTHBARS, tostring(NAMEPLATE_CHOICE_NEVER))
	else
		SetCrownCrateNPCVisible(false)
		SetSetting(SETTING_TYPE_NAMEPLATES, NAMEPLATE_TYPE_GROUP_MEMBER_NAMEPLATES, tostring(HG.savedVariables.GroupMemberNameplates))
		SetSetting(SETTING_TYPE_NAMEPLATES, NAMEPLATE_TYPE_GROUP_MEMBER_HEALTHBARS, tostring(HG.savedVariables.GroupMemberHealthBars))
	end
end

local function sCommand(opt)
	if opt == "true" or opt == "1" then
		hideMembers(true)
	else
		hideMembers(false)
	end
end

function HG.init(e, addon)
	if addon ~= HG.name then return end
	EM:UnregisterForEvent(HG.name.."Load", EVENT_ADD_ON_LOADED)
	HG.defaults = {
		["GroupMemberNameplates"] = GetSetting(SETTING_TYPE_NAMEPLATES, NAMEPLATE_TYPE_GROUP_MEMBER_NAMEPLATES),
		["GroupMemberHealthBars"] = GetSetting(SETTING_TYPE_NAMEPLATES, NAMEPLATE_TYPE_GROUP_MEMBER_HEALTHBARS),
	}
	HG.savedVariables = ZO_SavedVars:New("HideGroupSavedVars", 1, nil, HG.defaults, GetWorldName())
	SLASH_COMMANDS["/hidegroup"] = sCommand
end

EM:RegisterForEvent(HG.name.."Load", EVENT_ADD_ON_LOADED, HG.init)
