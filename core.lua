--- STEAMODDED HEADER
--- MOD_NAME: Yahimod
--- MOD_ID: Yahimod
--- MOD_AUTHOR: Yahiamice
--- MOD_DESCRIPTION: hi
--- PREFIX: yahi
----------------------------------------------------------
----------- MOD CODE -------------------------------------

-- shoutouts cryptid & mathisfun --

if not Yahimod then
	Yahimod = {}
end



local mod_path = "" .. SMODS.current_mod.path
Yahimod.path = mod_path
Yahimod_config = SMODS.current_mod.config

SMODS.current_mod.optional_features = {
    retrigger_joker = true,
	post_trigger = true,
}

-- Cat joker pool
SMODS.ObjectType({
	key = "Cat",
	default = "j_reserved_parking",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
		-- insert base game food jokers
		self:inject_card(G.P_CENTERS.j_lucky_cat)
	end,
})

-- Yahimod joker pool
SMODS.ObjectType({
	key = "Yahimodaddition",
	default = "j_reserved_parking",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
		-- insert base game food jokers
	end,
})


--Yahimod.nuuhstream = love.graphics.newVideoStream( Yahimod.path .. "nuuh.ogv" )
--Yahimod.nuuh = love.graphics.newVideo( Yahimod.nuuhstream )

--Load Library Files
local files = NFS.getDirectoryItems(mod_path .. "items")
for _, file in ipairs(files) do
	print("[YAHIMOD] Loading lua file " .. file)
	local f, err = SMODS.load_file("items/" .. file)
	if err then
		error(err) 
	end
	f()
end





--Load misc stuff so i only hook things once
--local hook = love.load
--function love.load()
--	hook()
--		local full_path = (Yahimod.path 
--		.."assets/" 
--		.. G.SETTINGS.GRAPHICS.texture_scaling 
--		.. "x/"
--		.. "horse.png")
--	file_data = assert(NFS.newFileData(full_path),("Epic fail"))
--	Yahimod.horsepngimagedata = assert(love.image.newImageData(file_data),("Epic fail 2"))
--	Yahimod.horsepng = assert(love.graphics.newImage(Yahimod.horsepngimagedata),("Epic fail 3"))
--
--end

----------------------------------------------------------
----------- MOD CODE END ----------------------------------
