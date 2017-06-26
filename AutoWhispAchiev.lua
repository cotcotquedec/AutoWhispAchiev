--[[

  This is really a feature that i like from https://mods.curse.com/addons/wow/255086-lazy-group-finder
  So i forked it ;-). Thanks to Luuci for Hard Works
  But i need to it to be compatiblme with lastest instance
	
	Best regards,
	Cotcotquedec / Cøtcotquedec EU
]]

local achievementIDs = {

	-- Dungeons
	[473] = "11162 11185 11184 11183", -- Karazhan : Haut (Clé Mythic)
	[471] = "11162 11185 11184 11183", -- Karazhan : Bas (Clé Mythic)
	[459] = "11162 11185 11184 11183", -- Azshara (Clé Mythic)
	[460] = "11162 11185 11184 11183", -- Fourée sombrecoeur (Clé Mythic)
	[461] = "11162 11185 11184 11183", -- Salle des valeureux (Clé Mythic)
	[462] = "11162 11185 11184 11183", -- Repaire de neltharion (Clé Mythic)
	[463] = "11162 11185 11184 11183", -- Bastion du freux (Clé Mythic)
	[464] = "11162 11185 11184 11183", -- Caveau des gardiennes(Clé Mythic)
	[465] = "11162 11185 11184 11183", -- Gueule des ames (Clé Mythic)
	[466] = "11162 11185 11184 11183", -- Court of Stars(Clé Mythic)
	[467] = "11162 11185 11184 11183", -- Arcavia (Clé Mythic)
	
	-- Raids
	[479] = "11874 11790", -- Tomb of Sargeras (Normal)
	[478] = "11874 11790", -- Tomb of Sargeras (Heroic)
	[416] = "11195 10839", -- Nighthold (Heroic)
	[415] = "11195 10839", -- Nighthold (Normal)
	[457] = "11426 11394", -- Trial of valor (Heroic) 
	[456] = "11426 11394", -- Trial of valor (Normal)
	[414] = "11194 10820", -- Emerald Nightmare (Heroic)
	[413] = "11194 10820", -- Emerald Nightmare (Normal)
}


local AutoWhispAchievAddon = CreateFrame("Frame", "AutoWhispAchievAddon", UIParent)
local RegisteredEvents = {}
AutoWhispAchievAddon:SetScript("OnEvent", function (self, event, ...) if (RegisteredEvents[event]) then return RegisteredEvents[event](self, event, ...) end end)

function RegisteredEvents:ADDON_LOADED(event, addon, ...)
	if addon ~= "AutoWhispAchiev" then return end
end


function RegisteredEvents:LFG_LIST_APPLICATION_STATUS_UPDATED(event, applicationID, status)
	local _,activity,name,comment,_,ilvl,_,_,_,_,_,_,leader,members = C_LFGList.GetSearchResultInfo(applicationID)
    
	if (status == "applied") then
    -- AutoWhispAchievDebug(activity);
    if achievementIDs[activity] ~= nil then
      for achID in string.gmatch(achievementIDs[activity], '([^ ]+)') do
        local _,_,_,completed = GetAchievementInfo(tonumber(achID))
        if completed then
          SendChatMessage(GetAchievementLink(tonumber(achID)) ..  " by AutoWhispAchiev", "WHISPER", nil, leader)
          break
        end
      end
    end
	end
end

for k, v in pairs(RegisteredEvents) do
	AutoWhispAchievAddon:RegisterEvent(k)
end

function AutoWhispAchievDebug(message)
	DEFAULT_CHAT_FRAME:AddMessage("|cFFFFFFFFAWA Debug :|cFFFFFF00 " .. message)
end