-- these are funny functions for debug & bit purposes and probably aren't actually used in the main core of the mod. you can probably call these through DebugPlus if you feel Quirky


function everythingRedSteelKing()
	for _, card in ipairs(G.playing_cards) do
		card.base.value = "King"
		card.base.face_nominal = 0.4
		card.base.suit_nominal_original = 0.04
		card.nominal = 10
		card:set_seal('Red')
		card.config.card.value = "King"
		card:set_ability("m_steel")
	end
end

-- this one isn't funny, it's a tool! wow!!! you've been tricked into learning about bounding boxes!!
function BoundingBox(x1, y1, x2, y2, tx, ty)
	return	(x2 >= tx and y2 >= ty)
		and (x1 <= tx and y1 <= ty)
		or  (x1 >= tx and y2 >= ty)
		and (x2 <= tx and y1 <= ty)
end

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

-- neither is this one

function instantly_update_hand_text(witheffects)
	--G.hand_text_area.chips = hand_chips
	G.hand_text_area.chips:update(0)
	--G.hand_text_area.mult = mult
	G.hand_text_area.mult:update(0)
	local hand_UI = G.HUD:get_UIE_by_ID('hand_UI_count')
	hand_UI.config.object:update()
	G.HUD:recalculate()
	if witheffects == true then
		G.hand_text_area.chips:juice_up()
		G.hand_text_area.mult:juice_up()
	end
end

-- shake yo booty?
function shakeEverything(factor)
	G.ROOM.jiggle = G.ROOM.jiggle + factor
end

-- Used in homophobic cat
function isEven(number)
    local _even = true
    if number/2 == math.floor(number/2) then _even = false end
    return _even
end