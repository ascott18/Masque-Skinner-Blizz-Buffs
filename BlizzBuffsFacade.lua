
local LMB = LibStub("Masque", true) or (LibMasque and LibMasque("Button"))
if not LMB then return end

local f = CreateFrame("Frame")

local function NULL()
end

local function OnEvent(self, event, addon)
	for i=1, BUFF_MAX_DISPLAY do
		local buff = _G["BuffButton"..i]
		if buff then
			LMB:Group("Blizzard Buffs", "Buffs"):AddButton(buff)
		end
		if not buff then break end
	end
	
	for i=1, BUFF_MAX_DISPLAY do
		local debuff = _G["DebuffButton"..i]
		if debuff then
			LMB:Group("Blizzard Buffs", "Debuffs"):AddButton(debuff)
		end
		if not debuff then break end
	end
	
	for i=1, NUM_TEMP_ENCHANT_FRAMES do
		local TempEnchant = _G["TempEnchant"..i]
		--_G["TempEnchant"..i.."Border"].SetTexture = NULL
		if TempEnchant then
			LMB:Group("Blizzard Buffs", "TempEnchant"):AddButton(TempEnchant)
		end
		_G["TempEnchant"..i.."Border"]:SetVertexColor(.75, 0, 1)
	end
	
	f:SetScript("OnEvent", nil)
end


hooksecurefunc("CreateFrame", function (_, name, parent) --dont need to do this for TempEnchant enchant frames because they are hard created in xml
	if parent ~= BuffFrame or type(name) ~= "string" then return end
	if strfind(name, "^DebuffButton%d+$") then
		LMB:Group("Blizzard Buffs", "Debuffs"):AddButton(_G[name])
	elseif strfind(name, "^BuffButton%d+$") then
		LMB:Group("Blizzard Buffs", "Buffs"):AddButton(_G[name])
	end
end
)
	
f:SetScript("OnEvent", OnEvent)
f:RegisterEvent("PLAYER_ENTERING_WORLD")

