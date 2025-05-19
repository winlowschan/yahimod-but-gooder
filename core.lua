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

G.C.YAHIPURPLE = HEX("d342fe")
G.C.YAHIORANGE = HEX("ffd874")
G.C.mid_flash = 0
G.C.vort_time = 7
G.C.vort_speed = 0.4

-- from cryptid :}
local oldfunc = Game.main_menu
Game.main_menu = function(change_context)
	local ret = oldfunc(change_context)
	G.SPLASH_BACK:define_draw_steps({
			{
				shader = "splash",
				send = {
					{ name = "time", ref_table = G.TIMERS, ref_value = "REAL_SHADER" },
           			{name = 'vort_speed', val = G.C.vort_speed},
            		{name = 'colour_1', ref_table = G.C, ref_value = 'YAHIPURPLE'},
            		{name = 'colour_2', ref_table = G.C, ref_value = 'YAHIORANGE'},
            		{name = 'mid_flash', ref_table = G.C, ref_value = 'mid_flash'},
				},
			},
		})
	return ret
end


local mod_path = "" .. SMODS.current_mod.path
Yahimod.path = mod_path
Yahimod_config = SMODS.current_mod.config

SMODS.current_mod.optional_features = {
    retrigger_joker = true,
	post_trigger = true,
}

-- effect manager for particles etc

G.effectmanager = {}

--get twitch numbers

G.last_update_time = 0
function recheckTwitch(please)

    if ((os.time() - G.last_update_time) >= 90) or please == "please" then
        G.last_update_time = os.time()
        local json = require "json"
        local succ, https = pcall(require, "SMODS.https")
        local url = "https://gql.twitch.tv/gql"
        local options = {
        method = "POST",
        data = '[{"operationName":"VideoMetadata","variables":{"channelLogin":"Yahiamice","videoID":"0"},"extensions":{"persistedQuery":{"version":1,"sha256Hash":"45111672eea2e507f8ba44d101a61862f9c56b11dee09a15634cb75cb9b9084d"}}}]',
        headers = {
            ["Client-ID"] = "kimne78kx3ncx6brgo4mv6wki5h1ko",
            ["user-agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36",
            ["Content-Type"] = "application/json"
        }
        }

        local status, body, headers = https.request(url, options)
        G.twitchbodyjson = json.decode(body)
        G.yahifollowers = G.twitchbodyjson[1].data.user.followers.totalCount
        G.yahiviewers = 0
        if G.twitchbodyjson[1].data.user.stream then G.yahiviewers = G.twitchbodyjson[1].data.user.stream.viewersCount else print("Failed to parse yahi's viewer count! Maybe he's offline?") end
    else
		--print("Can't update! Wait " .. (90 - (os.time() - G.last_update_time)) .. " more seconds please...")
	end
end


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

--Load item files
local files = NFS.getDirectoryItems(mod_path .. "items")
for _, file in ipairs(files) do
	print("[YAHIMOD] Loading lua file " .. file)
	local f, err = SMODS.load_file("items/" .. file)
	if err then
		error(err) 
	end
	f()
end

--Load lib files
local files = NFS.getDirectoryItems(mod_path .. "libs/")
for _, file in ipairs(files) do
	print("[YAHIMOD] Loading lib file " .. file)
	local f, err = SMODS.load_file("libs/" .. file)
	if err then
		error(err) 
	end
	f()
end

--Load Localization file
local files = NFS.getDirectoryItems(mod_path .. "localization")
for _, file in ipairs(files) do
	print("[YAHIMOD] Loading localization file " .. file)
	local f, err = SMODS.load_file("localization/" .. file)
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
