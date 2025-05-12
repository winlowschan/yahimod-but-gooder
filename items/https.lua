-- Shamelessly stolen off Cryptid mod! Thank u devs i wouldn'tve figured out https requests in a lifetime

https = require "SMODS.https"
local member_fallback = 3
local succ, https = pcall(require, "SMODS.https")
local last_update_time = 0
local initial = true
local clientid = "gp762nuuoqcoxypju8c569th9wz7q5"

Yahimod.viewercount = member_fallback
if not succ then
	print("HTTP module could not be loaded. " .. tostring(https))
end

local function apply_discord_member_count(code, body, headers)
	if body then
		Yahimod.viewercount = string.match(body, '"approximate_member_count"%s*:%s*(%d+)') or Yahimod.viewercount
	end
end


