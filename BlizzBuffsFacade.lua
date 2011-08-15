
local LBF = LibStub("LibButtonFacade", true)
local LMB = LibStub("Masque", true) or (LibMasque and LibMasque("Button"))
local Stub = (LBF or LMB)
if not Stub then return end

local f = CreateFrame("Frame")
local db

local function SkinCallback(_, SkinID, Gloss, Backdrop, Group, _, Colors)
	if Group then
		db[Group].S = SkinID
		db[Group].G = Gloss
		db[Group].B = Backdrop
		db[Group].C = Colors
	end
end
	
local function OnEvent(self, event, addon)
	
	if not LMB then
		BlizzBuffsFacade = BlizzBuffsFacade or {}
		LBF:RegisterSkinCallback("Blizzard Buffs", SkinCallback)
		db = BlizzBuffsFacade
		
		db.Buffs = db.Buffs or {}
		db.Debuffs = db.Debuffs or {}
		db.TempEnchant = db.TempEnchant or {}
		
		local b = db.Buffs
		local d = db.Debuffs
		local t = db.TempEnchant
		
		LBF:Group("Blizzard Buffs", "Buffs"):Skin(b.S,b.G,b.B,b.C)
		LBF:Group("Blizzard Buffs", "Debuffs"):Skin(d.S,d.G,d.B,d.C)
		LBF:Group("Blizzard Buffs", "TempEnchant"):Skin(t.S,t.G,t.B,t.C)
	end
	
	for i=1, BUFF_MAX_DISPLAY do
		local buff = _G["BuffButton"..i]
		if buff then
			Stub:Group("Blizzard Buffs", "Buffs"):AddButton(buff)
		end
		if not buff then break end
	end
	
	for i=1, BUFF_MAX_DISPLAY do
		local debuff = _G["DebuffButton"..i]
		if debuff then
			Stub:Group("Blizzard Buffs", "Debuffs"):AddButton(debuff)
		end
		if not debuff then break end
	end
	
	for i=1, NUM_TEMP_ENCHANT_FRAMES do
		local TempEnchant = _G["TempEnchant"..i]
		if TempEnchant then
			Stub:Group("Blizzard Buffs", "TempEnchant"):AddButton(TempEnchant)
		end
	end
	
	f:SetScript("OnEvent", nil)
end


hooksecurefunc("CreateFrame", function (_, name, parent) --dont need to do this for TempEnchant enchant frames because they are hard created in xml
	if parent ~= BuffFrame or type(name) ~= "string" then return end
	if strfind(name, "^DebuffButton%d+$") then
		Stub:Group("Blizzard Buffs", "Debuffs"):AddButton(_G[name])
	elseif strfind(name, "^BuffButton%d+$") then
		Stub:Group("Blizzard Buffs", "Buffs"):AddButton(_G[name])
	end
end
)
	
f:SetScript("OnEvent", OnEvent)
f:RegisterEvent("PLAYER_ENTERING_WORLD")

