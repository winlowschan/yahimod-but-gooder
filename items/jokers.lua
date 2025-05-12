--- STEAMODDED HEADER
--- MOD_NAME: Yahimod
--- MOD_ID: Yahimod
--- MOD_AUTHOR: Yahiamice
--- MOD_DESCRIPTION: hi
--- PREFIX: yahi
----------------------------------------------------------
----------- MOD CODE -------------------------------------

SMODS.Atlas{
    key = 'Jokers',
    path = 'Jokers.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'joker2',
    loc_txt= {
        name = 'Lazy Joker',
        text = { 'cba making a proper {C:attention} image for this',
                '{X:mult,C:white}X#1#{} Mult and {X:attention}$1{}' }
    },
    atlas = 'Jokers',
    rarity = 1,
    cost = 4,
    pools = {["Yahimodaddition"] = true},

    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {
        Xmult = 1.215
    }},

    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult}}
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,

    calculate = function(self,card,context)
        if context.joker_main then
            return{
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
                colour = G.C.MULT

            }
        end
    end,

    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
    calc_dollar_bonus = function(self,card)
        return 1
    end,
}

-- Marx
SMODS.Atlas{
    key = 'marx',
    path = 'marx.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'marx',
    loc_txt= {
        name = 'Marx',
        text = { "Gains {X:mult,C:white} X#1# {} Mult every time a",
                    "scored {C:attention}Lucky{} card {C:red}DOESN'T{} trigger",
                    "{C:inactive}Resets when a {}{C:attention}Lucky card{} {C:inactive}triggers{}",
                    "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",}
    },
    atlas = 'marx',
    rarity = 1,
    cost = 4,
    pools = { ["Cat"] = true, ["Yahimodaddition"] = true },
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {Xmult = 1, additional = 0.25}},
    enhancement_gate = 'm_lucky',

    loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
		return { vars = { center.ability.extra.additional , center.ability.extra.Xmult}  }
	end,

    calculate = function(self, card, context)
		if context.joker_main and (card.ability.extra.Xmult > 1) then
			return {
				message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.Xmult } }),
				Xmult_mod = card.ability.extra.Xmult
			}
		end
        if context.individual and context.cardarea == G.play and context.other_card.ability.name == 'Lucky Card' and not context.other_card.lucky_trigger then
            card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.additional
            return {
                message = "Unlucky!",
                colour = G.C.RED
            }
        end
        if context.individual and context.other_card.lucky_trigger then
            card.ability.extra.Xmult = 1
            return {
                message = ":p",
                colour = G.C.RED
            }
		end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- LCDirects
SMODS.Atlas{
    key = 'lcdirects',
    path = 'lcdirects.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'lcdirects',
    loc_txt= {
        name = 'LCDirects',
        text = { "Gains {X:mult,C:white} X#1# {} Mult every time a",
                    "Joker or playing card {C:red}is destroyed{}",
                    "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
                    "",
                    "{C:inactive}``WHAT AM I GONNA DO WITH HALF A MULT?!``{}"
    }},
    atlas = 'lcdirects',
    rarity = 2,
    cost = 5,
    pools = {["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 1},
    soul_pos = { x = 0, y = 0, extra = { x = 0, y = 0 } },
    config = { extra = {Xmult = 1, additional = 0.5}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.additional , center.ability.extra.Xmult}  }
	end,

    

    calculate = function(self, card, context)
		if context.joker_main and (card.ability.extra.Xmult > 1) then
			return {
				message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.Xmult } }),
				Xmult_mod = card.ability.extra.Xmult
			}
		end
        if context.remove_playing_cards then
            for k, val in ipairs(context.removed) do
                card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.additional
                return {
                    message = "BOOM!",
                    colour = G.C.RED
                }
            end
        end

        if G.hasajokerbeendestroyedthistick == true then
            G.hasajokerbeendestroyedthistick = false
            card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.additional
            return {
                message = "BOOM!",
                colour = G.C.RED 
            }
        end

        if context.using_consumeable then
            if context.consumeable.ability.name == 'Hex' or context.consumeable.ability.name == 'Ankh' then
                G.hasajokerbeendestroyedthistick = true
            end
            --print("LC" .. context.consumeable.ability.name)
        end

    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,


}

-- 21 kid
SMODS.Atlas{
    key = '21kid',
    path = '21kid.png',
    px = 71,
    py = 95,
}

SMODS.Sound({key = "nine", path = "nine.ogg",})
SMODS.Sound({key = "ten", path = "ten.ogg",})
SMODS.Sound({key = "twennyone", path = "twennyone.ogg",})

SMODS.Joker{
    key = '21kid',
    loc_txt= {
        name = '21 Kid',
        text = { "{X:mult,C:white} X#1# {} Mult if scored hand" ,
                    "contains a {C:attention}9{} and a {}{C:attention}10{}"}
    },
    atlas = '21kid',
    rarity = 1,
    cost = 4,
    pools = {["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {Xmult = 2.1}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.Xmult}  }
	end,

    calculate = function(self, card, context)
		if context.joker_main then
            local hasnine = false
            local hasten = false
            for i = 1, #context.scoring_hand do
				if context.full_hand[i]:get_id() == 9 then
                    hasnine = true
                end
                if context.full_hand[i]:get_id() == 10 then
                    hasten = true
                end
            end

            if hasnine == true and hasten == true then   
			return {
				message = "21!",
				Xmult_mod = card.ability.extra.Xmult,
                sound= "yahimod_twennyone",
			}
            end
		end
        if context.cardarea == G.play and context.individual and context.other_card then
            local rank = context.other_card:get_id()
			if rank == 9 then
				return {
                    sound = 'yahimod_nine',
                    message = '9!',
                }
			end
            if rank == 10 then
				return {
                    sound = 'yahimod_ten',
                    message = '10!',
                }
			end
		end

    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}
-- Jackblack
SMODS.Atlas{
    key = 'jackblack',
    path = 'jackblack.png',
    px = 70,
    py = 95,
}

SMODS.Joker{
    key = 'jackblack',
    loc_txt= {
        name = 'Jack Black',
        text = { "{X:mult,C:white} X#2# {} Mult for every",
                    "{C:attention}Jack{} in your full deck",
                    "{C:inactive}(Currently {X:mult,C:white} X#1# {C:inactive} Mult)",
    },},
    atlas = 'jackblack',
    rarity = 3,
    cost = 4,
    pools = {["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { 
        extra = 
        {Xmult = 2
        , additional = 0.5
        , currentquip = 0
        , Xquips = { 'I... am STEVE.', 'Chicken Jockey!', 'THE NETHER.', 'Flint and STEEL!!', "First we mine,\n then we craft.\nLet's MINECRAFT!", "Octagon!", "I will literally\n suck your dick \nright now.", "Frigigigigigigigigi-"  }
        }},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.Xmult, center.ability.extra.additional, center.ability.extra.currentquip, center.ability.extra.Xquips }}
	end,

    calculate = function(self, card, context)
        if G.playing_cards then                           
            local jackamount = G.playing_cards and calculate_jack_amount() or 0
            Xmult_mod = (card.ability.extra.additional * jackamount)
            card.ability.extra.Xmult = Xmult_mod
        end
        
        if context.joker_main then
            card.ability.extra.currentquip = card.ability.extra.currentquip + 1
            if card.ability.extra.currentquip > 8 then
                card.ability.extra.currentquip = 1
            end
            return 
                {
                Xmult = Xmult_mod,
                message = card.ability.extra.Xquips[card.ability.extra.currentquip]
                }
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Lydia Function

if not Yahimod then Yahimod = {} end
if not Yahimod.LydiaScale then Yahimod.LydiaScale = 1 end
local scie = SMODS.calculate_individual_effect
function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
	if (
	    key == "x_mult"
	    or key == "xmult"
	    or key == "Xmult"
	    or key == "x_mult_mod"
	    or key == "xmult_mod"
	    or key == "Xmult_mod"
	) and amount ~= 1
	then
        local islydiahere = false
        local _lydiacard = nil
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].ability.name == 'j_yahimod_lydia' then
                islydiahere = true
                _lydiacard = G.jokers.cards[i]
            end
        end
        if G.GAME.current_round.hands_left ~= 0 and islydiahere == true then
            Yahimod.LydiaScale = Yahimod.LydiaScale * amount
            card_eval_status_text(_lydiacard,'jokers',nil,nil,nil,{message = "Stored X" ..amount.."!"})
            amount = 1
        end
	end
	local ret = scie(effect, scored_card, key, amount, from_edition)
	return ret
	end

-- Lydia 

SMODS.Atlas{
    key = 'lydia',
    path = 'lydia.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'yahimod_lydia',
    loc_txt= {
        name = 'Lydia',
        text = { "Stores all your {X:mult,C:white}XMult{}" ,
                    "and unleashes it on the {C:attention}final hand{}",
                    "{C:inactive}(Stockpiled: {X:mult,C:white} X#1# {C:inactive} Mult)",}
    },
    atlas = 'lydia',
    rarity = 4,
    cost = 20,
    pools = {["Yahimodaddition"] = true},

    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    demicoloncompat = true,

    pos = {x=0, y= 0},
    soul_pos = { x = 0, y = 1, extra = { x = 0, y = 1 } },

    loc_vars = function(self, info_queue, center)
        return { vars = { Yahimod.LydiaScale }}
    end,

    calculate = function(self, card, context)
        if (G.GAME.current_round.hands_left == 0 and context.final_scoring_step and Yahimod.LydiaScale > 1) or context.forcetrigger then
            return {
                message = 'X' .. Yahimod.LydiaScale,
                xmult = Yahimod.LydiaScale
            }
        end
        if context.end_of_round and Yahimod.LydiaScale ~= 1 then
            Yahimod.LydiaScale = 1
        end
    end,

}
-- Lighttophat
SMODS.Atlas{
    key = 'lighttophat',
    path = 'lighttophat.png',
    px = 70,
    py = 95,
}

SMODS.Joker{
    key = 'lighttophat.png',
    loc_txt= {
        name = 'LightTophat',
        text = { "Once per round, duplicates",
                    "the first used {C:attention}consumable{}.",
                    "{C:inactive}(Must have room){}",
                    "#1#",
    },},
    atlas = 'lighttophat',
    rarity = 2,
    cost = 4,
    pools = {["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {active = true}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.active }  }
	end,
    active = true,

    calculate = function(self, card, context)
        card.ability.extra.active = active
		if
			context.using_consumeable
			and not context.consumeable.beginning_end
		then
			if active then
				local card = create_card('', G.consumeables, nil, nil, nil, nil, context.consumeable.config.center_key, 'lighttophat')
				card:add_to_deck()
				G.consumeables:emplace(card)
                active = false
                return{message = "Yep, that's going in the blackmail folder"}
			end
		end
        if context.end_of_round and active ~= true then
            active = true
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}
-- Spongebobinspace
SMODS.Atlas{
    key = 'spongebobinspace',
    path = 'spongebobinspace.png',
    px = 70,
    py = 95,
}

SMODS.Joker{
    key = 'spongebobinspace.png',
    loc_txt= {
        name = 'Spongebob In Space',
        text = { "Creates your most played hand's",
                    "{C:attention}planet card{} every blind",
                    "Creates a Black Hole on boss blind",
                    "{C:inactive}(Must have room){}",
    },},
    atlas = 'spongebobinspace',
    rarity = 3,
    cost = 11,
    pools = {["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {active = true}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.active }  }
	end,
    active = true,

    calculate = function(self, card, context)
        if context.setting_blind and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            local card_type = 'Planet'
            local _planet = 0
            for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                if v.config.hand_type == G.GAME.current_round.most_played_poker_hand then
                    _planet = v.key
                end
            end
            if G.GAME.blind:get_type() ~= 'Boss' then
                local card = create_card(nil, G.consumeables, nil, nil, nil, nil, _planet, 'spongebobinspace')
                card:add_to_deck()
                G.consumeables:emplace(card)
                active = false
                return{message = "AHHHHHHHHHHH!!!!!!"}
            else
                local card = create_card(nil, G.consumeables, nil, nil, nil, nil, 'c_black_hole', 'spongebobinspace')
                card:add_to_deck()
                G.consumeables:emplace(card)
                active = false
                return{message = "AHHHHHHHHHHH!!!!!!"}
            end
            
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}
-- Doorknob
SMODS.Sound({key = "horsedeath", path = "horsedeath.ogg",})

SMODS.Atlas{
    key = 'doorknob',
    path = 'doorknob.png',
    px = 70,
    py = 95,
}

SMODS.Joker{
    key = 'doorknob',
    loc_txt= {
        name = 'Doorknob',
        text = { "{X:mult,C:white}X#1#{} Mult",
                    "{C:red}-X#2# Mult{} every round",},},
    atlas = 'doorknob',
    rarity = 2,
    cost = 7,
    pools = {["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {Xmult = 3, loss = 0.5}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.Xmult, center.ability.extra.loss }  }
	end,


    
    calculate = function(self, card, context)
        if context.end_of_round and context.cardarea == G.jokers then
            if card.ability.extra.Xmult > (1 + card.ability.extra.loss) then
                card.ability.extra.Xmult = (card.ability.extra.Xmult - card.ability.extra.loss)
                return{message = "-" .. card.ability.extra.loss,}
            else
                card:start_dissolve({G.C.RED})
                return{
                    message = "-" .. card.ability.extra.loss,
                    sound = "yahimod_horsedeath",
                }
            end
        end

        if context.joker_main then
            return{
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
            }
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Deer
SMODS.Atlas{
    key = 'deer',
    path = 'deer.png',
    px = 70,
    py = 95,
}

SMODS.Joker{
    key = 'deer',
    loc_txt= {
        name = 'Deer',
        text = { "{C:red} +#1#{} Mult",
                    "{C:inactive}(Press {C:attention}Y{C:inactive} to summon deer)",
    },},
    atlas = 'deer',
    rarity = 1,
    cost = 2,
    pools = {["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {mult = 2}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.mult }  }
	end,

    calculate = function(self, card, context)
    if context.joker_main then
        return 
            {
            mult = card.ability.extra.mult,
            }
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Budgie
SMODS.Atlas{
    key = 'budgie',
    path = 'budgie.png',
    px = 70,
    py = 95,
}

SMODS.Joker{
    key = 'budgie',
    loc_txt= {
        name = 'Budgie',
        text = { "{C:red} +#1#{} Mult and {X:mult,C:white}X#2#{} Mult",
                    "when you play a {C:spades}Spade{}, {C:clubs}Club{} or {C:attention}King{}",
    },},
    atlas = 'budgie',
    rarity = 2,
    cost = 7,
    pools = {["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {mult = 3, Xmult = 1.15}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.mult, center.ability.extra.Xmult }  }
	end,

    calculate = function(self, card, context)
    if context.cardarea == G.play and context.individual and context.other_card then
        local _trigger = false
        if context.other_card:get_id() == 13 then _trigger = true end
        if context.other_card:is_suit('Clubs') then _trigger = true end
        if context.other_card:is_suit('Spades') then _trigger = true end
        if _trigger == true then
            return {
                mult = card.ability.extra.mult,
                Xmult_mod = card.ability.extra.Xmult,
                message = "That's buckets!",
            }
            end
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Glungus
SMODS.Atlas{
    key = 'glungus',
    path = 'glungus.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'glungus',
    loc_txt= {
        name = 'Glungus',
        text = { "Gains{C:red} +#2#{} Mult",
                    "every round",
                    "{C:inactive}(Currently {C:red}+#1# {C:inactive}Mult)",}
    },
    atlas = 'glungus',
    rarity = 1,
    cost = 4,
    pools = { ["Cat"] = true, ["Yahimodaddition"] = true },
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {mult = 2, additional = 2}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.mult, center.ability.extra.additional }  }
	end,

    calculate = function(self, card, context)
		if context.joker_main then
			return {
				message = "+".. card.ability.extra.mult,
				mult_mod = card.ability.extra.mult
			}
        end
        if context.setting_blind then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.additional
            return {
                message = "Upgrade!",
            }
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Penis
SMODS.Atlas{
    key = 'pe',
    path = 'pe.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'penis',
    loc_txt= {
        name = 'Penis',
        text = { "Gains{C:blue} +#2#{} Chips",
                    "every round",
                    "{C:inactive}(Currently {C:blue}+#1# {C:inactive}Chips)",}
    },
    atlas = 'pe',
    rarity = 1,
    cost = 4,
    pools = { ["Cat"] = true, ["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {chips = 10, additional = 10}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.chips, center.ability.extra.additional }  }
	end,

    calculate = function(self, card, context)
		if context.joker_main then
			return {
				message = "+".. card.ability.extra.chips,
				chip_mod = card.ability.extra.chips
			}
        end
        if context.setting_blind then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.additional
            return {
                message = "Upgrade!",
            }
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Greatest Golfer
SMODS.Atlas{
    key = 'greatestgolfer',
    path = 'greatestgolfer.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'greatestgolfer',
    loc_txt= {
        name = 'Greatest Golfer',
        text = { "{C:red}+#1#{} Mult",
                    "on the first hand of the round",
                    "Otherwise, {C:red}#2#{} Mult",}
    },
    atlas = 'greatestgolfer',
    rarity = 1,
    cost = 4,
    pools = {["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {mult = 15, negativemult = -2}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.mult, center.ability.extra.negativemult }  }
	end,

    calculate = function(self, card, context)
		if context.joker_main then
            if G.GAME.current_round.hands_played == 0 then
                return {
                    message = "+".. card.ability.extra.mult,
                    mult_mod = card.ability.extra.mult
                }
            else
                return {
                    message = "-".. card.ability.extra.negativemult,
                    mult_mod = card.ability.extra.negativemult
                }
            end
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}


-- Moonwalkingpig
SMODS.Atlas{
    key = 'moonwalkingpig',
    path = 'moonwalkingpig.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'moonwalkingpig',
    loc_txt= {
        name = 'Moonwalking Pig',
        text = { "If you beat the boss blind",
                    "without triggering {C:red}fire effects,",
                    "go back by {C:attention}1 Ante{}",
                    "{C:inactive}(Self-Destructs when triggered)",}
    },
    atlas = 'moonwalkingpig',
    rarity = 2,
    cost = 4,
    pools = {["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {triggered = false, chat = false}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.triggered, center.ability.extra.chat }  }
	end,

    calculate = function(self, card, context)
        if context.setting_blind then
            card.ability.extra.chat = false
        end
		if context.end_of_round and (G.GAME.blind:get_type() == 'Boss') and (card.ability.extra.triggered == false) then
            if G.ARGS.chip_flames.real_intensity < 0.000001 then
                ease_ante(-1)
                card_eval_status_text(card,'extra',nil,nil,nil,{message = "Hee-Hee!"})
                card:start_dissolve({G.C.RED})
                card.ability.extra.triggered = true
            else
                if card.ability.extra.chat == false then
                    card_eval_status_text(card,'extra',nil,nil,nil,{message = "Nah Nah!"})
                    card.ability.extra.chat = true
                end
            end
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Subway Surfers
SMODS.Atlas{
    key = 'subwaysurfers',
    path = 'subwaysurfers.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'subwaysurfers',
    loc_txt= {
        name = 'Subway Surfers',
        text = { "Randomly gains {C:blue}Chips{} ",
                    "and {C:red}Mult{} over time",
                    "Can randomly lose all {C:blue}Chips{} and {C:red}Mult{}",
                    "{C:inactive}(Currently {C:blue}#1#{C:inactive} Chips {C:red}#2#{C:inactive} Mult)",}
    },
    atlas = 'subwaysurfers',
    rarity = 3,
    cost = 10,
    pools = {["Yahimodaddition"] = true},

    pixel_size = { w = 71 , h = 96 },
    frame = 0,

    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {chips = 1, mult = 1}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.chips, center.ability.extra.mult }  }
	end,

    calculate = function(self, card, context)
		if context.joker_main then
			return {
				message = "New High Score!",
				chip_mod = card.ability.extra.chips,
                mult_mod = card.ability.extra.mult,
			}
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Sisyphus
SMODS.Atlas{
    key = 'sisyphus',
    path = 'sisyphus.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'sisyphus',
    loc_txt= {
        name = 'Sisyphean Joker',
        text = { "Gains{X:mult,C:white} X#2#{} Mult",
                    "every round",
                    "1 in 4 chance to reset",
                    "back to {X:mult,C:white}X1{} Mult",
                    "{C:inactive}(Currently {X:mult,C:white}X#1# {C:inactive}Mult)",}
    },
    atlas = 'sisyphus',
    rarity = 2,
    cost = 8,
    pools = {["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {xmult = 1.5, additional = 0.5}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.xmult, center.ability.extra.additional }  }
	end,

    calculate = function(self, card, context)
		if context.joker_main then
			return {
				message = "x".. card.ability.extra.xmult,
				Xmult_mod = card.ability.extra.xmult
			}
        end
        if context.setting_blind then
            if math.random(4) ~= 1 then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.additional
                return {
                    message = "Upgrade!",
                }
            else
                card.ability.extra.xmult = 1
                return {
                    message = "Rolled back!",
                    play_sound("timpani")
                }
            end
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- abuelita

SMODS.Sound({key = "nomus1", path = "nomusic1.ogg",})
SMODS.Sound({key = "nomus2", path = "nomusic2.ogg",})
SMODS.Sound({key = "nomus3", path = "nomusic3.ogg",})
SMODS.Sound({key = "whip", path = "whip.ogg",})


SMODS.Atlas{
    key = 'abuelita',
    path = 'abuelita.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'abuelita',
    loc_txt= {
        name = 'Abuelita',
        text = { "Smacks all boss blinds,",
                    "reducing their required",
                    "score by half.",
                    "{C:inactive}NO MUSIC!",}
    },
    atlas = 'abuelita',
    rarity = 2,
    cost = 5,
    pools = {["Yahimodaddition"] = true},

    config = { extra = {storedmusicvol = 0}},

    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    soul_pos = { x = 0, y = 1 },

    calculate = function(self, card, context)
        if context.setting_blind and (G.GAME.blind:get_type() == 'Boss') then
            G.GAME.blind.chips = G.GAME.blind.chips/2
            local _nomusic = {"yahimod_nomus1","yahimod_nomus2","yahimod_nomus3"}
            play_sound(_nomusic[math.random(#_nomusic)],math.random(0.9,1.1),0.5)
            play_sound("yahimod_whip",math.random(1.1,1.3),0.5)
            card.ability.extra.storedmusicvol = G.SETTINGS.SOUND.music_volume
            G.SETTINGS.SOUND.music_volume = 0
            return {
                
                message = "NO MUSIC!",
                
            }
        end
        if context.end_of_round and (G.GAME.blind:get_type() == 'Boss') then
           G.SETTINGS.SOUND.music_volume = card.ability.extra.storedmusicvol
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}


-- Roblox Madness
SMODS.Atlas{
    key = 'robloxmadness',
    path = 'robloxmadness.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'robloxmadness',
    loc_txt= {
        name = 'Roblox Madness',
        text = { "{C:blue}+#2#{} Chips {C:red}+#1#{} Mult",}
    },
    atlas = 'robloxmadness',
    rarity = 2,
    cost = 25,
    pools = {["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    

    pos = {x=0, y= 0},
    config = { extra = {mult = 25, chips = 150}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.mult, center.ability.extra.chips }  }
	end,

    calculate = function(self, card, context)
		if context.joker_main then
            return {
                message = "+".. card.ability.extra.mult .. " Mult" .. "& " .. card.ability.extra.chips .. " Chips",
                mult_mod = card.ability.extra.mult,
                chip_mod = card.ability.extra.chips,
                }
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Horse
SMODS.Sound({key = "horse", path = "horse.ogg",})

SMODS.Atlas{
    key = 'horse',
    path = 'horse.png',
    px = 71,
    py = 95,
}

G.truehorsetext = { "{C:green}>be me",
        "{C:green}>playing Balatro",
        "{C:green}>reroll shop",
        "{C:green}>horse walks in",
        "{C:green}>he takes up an entire Joker slot",
        "{C:green}>wtf.jpeg",
        "{C:green}>i try to sell him",
        "{C:green}>fails",
        "{C:green}>huh.lua",
        "{C:green}>he neighs and then exclaims",
        "{C:green}in perfect english:",
        "{C:red}''You won't be able to shake me off",
        "{C:red}until (#2#/#3#) rounds later.''",
        "{C:green}>he's {X:mult,C:white}X#1#{C:green} mult",
        "{C:green}>what the fuck",
    }

G.fakehorsetext = { "hi im a horsey",}


SMODS.Joker{
    key = 'horsewalksin',
    loc_txt = {
        name = 'HORSE',
        text = { G.truehorsetext ,
    },},
    atlas = 'horse',
    rarity = 2,
    cost = 1,
    pools = {["Yahimodaddition"] = true},


    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    hidden = true,
    

    pos = {x=0, y= 0},
    soul_pos = {x=0, y= 1},
    config = { extra = {negativeXmult = 0.75, round = 0, maxround = 3}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.negativeXmult, center.ability.extra.round, center.ability.extra.maxround}}
	end,


    calculate = function(self, card, context)
		if context.joker_main then
            return {
                color = G.C.RED,
                message = "X".. card.ability.extra.negativeXmult,
                Xmult_mod = card.ability.extra.negativeXmult,
                }
            end
        if context.setting_blind and not context.blueprint then
            local _msg = "Neigh!"
            card.ability.extra.round = card.ability.extra.round + 1
            if card.ability.extra.round >= card.ability.extra.maxround then 
                _msg = "...Neigh?" 
                card.ability.eternal = nil 
            end
            return {
                message = _msg,
                sound = "yahimod_horse",
            }
        end
        if context.selling_self then
            play_sound("yahimod_horsedeath")
        end
    end,
}

SMODS.Joker{
    key = 'horsebait',
    loc_txt = {
        name = 'Horse',
        text = { G.fakehorsetext ,
    },},
    atlas = 'horse',
    rarity = 2,
    cost = 1,
    pools = {["Yahimodaddition"] = true},


    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x=0, y= 0},
    soul_pos = {x=0, y= 1},
    config = { extra = {trigger = false}},

    
    add_to_deck = function(self, card, from_debuff)
        addHorse()
        card:start_dissolve({G.C.RED})
        card = nil
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- fortnite y free fire

SMODS.Atlas{
    key = 'fortnitebabagee',
    path = 'fortnitebabagee.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'fortnitebabagee',
    loc_txt= {
        name = 'Fortnite y Babagee?',
        text = { "Randomly copies the",
                    "joker to its left",
                    "or the joker to its right.",}
    },
    atlas = 'fortnitebabagee',
    rarity = 2,
    cost = 7,
    config = { extra = {chosenside = 1}},
    pools = {["Yahimodaddition"] = true},

    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x=0, y= 0},

    calculate = function(self, card, context)
        if context.joker_main or context.final_scoring_step or context.before or context.end_of_round or context.setting_blind or context.discard or context.buying_card or context.selling_card or context.reroll_shop then
            card.ability.extra.chosenside = math.random(1,2)
        end
        for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then _selfid = i end
            end
        _lr = card.ability.extra.chosenside
        if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= self then
            
            if _lr == 1 then
                if context.other_card == G.jokers.cards[_selfid-1] then
                    return {
                        message = "Fortnite!",
                        repetitions = 1,
                        card = card,
                    }
                else
                    return nil, true end
            end
            if _lr == 2 then
                if context.other_card == G.jokers.cards[_selfid+1] then
                    return {
                        message = "Babagee!",
                        repetitions = 1,
                        card = card,
                    }
                else
                    return nil, true end
            end
		end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Koda
SMODS.Atlas{
    key = 'koda',
    path = 'koda.png',
    px = 71,
    py = 95,
}

SMODS.Joker{
    key = 'koda',
    loc_txt= {
        name = 'Koda',
        text = { "{C:dark_edition}+#1#{} Joker Slot",
                    "{C:inactive}''mrreow''",}
    },
    atlas = 'koda',
    rarity = 1,
    cost = 3,
    pools = { ["Cat"] = true,["Yahimodaddition"] = true },
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {jokerslots = 1}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.jokerslots }  }
	end,

    add_to_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.jokerslots
    end,

    remove_from_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.jokerslots
	end,


    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Bean
SMODS.Atlas{
    key = 'bean',
    path = 'bean.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'bean',
    loc_txt= {
        name = 'Bean',
        text = { "Triggers one of the following:",
                    "{C:blue}+#1#{} Chips",
                    "OR {C:red}+#2#{} Mult",}
    },
    atlas = 'bean',
    rarity = 1,
    cost = 4,
    pools = { ["Cat"] = true, ["Yahimodaddition"] = true },
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {chipamt = 30, multamt = 6}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.chipamt, center.ability.extra.multamt, }  }
	end,

    calculate = function(self, card, context)
    if context.joker_main then
        if math.random(1,2) == 1 then
            return {
                color = G.C.BLUE,
                message = "+".. card.ability.extra.chipamt,
                chip_mod = card.ability.extra.chipamt
            }
        else
            return {
                color = G.C.RED,
                message = "+".. card.ability.extra.multamt,
                mult_mod = card.ability.extra.multamt
            }
        end
    end
end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}   

-- Leo
SMODS.Atlas{
    key = 'leo',
    path = 'leo.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'leo',
    loc_txt= {
        name = 'Leo',
        text = { "{C:blue}+#1#{} Chips",
                    "for every {C:attention}vowel in the",
                    "name of the card to its right",
                    "{C:inactive}Currently {C:blue}+#2#{} Chips",}
    },
    atlas = 'leo',
    rarity = 2,
    cost = 5,
    pools = { ["Cat"] = true, ["Yahimodaddition"] = true },
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {chipamt = 10, chiptotal = 0}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.chipamt, center.ability.extra.chiptotal }  }
	end,

    calculate = function(self, card, context)
    for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then _selfid = i end
    end
    if G.jokers.cards[_selfid+1] then
        local _cname = G.jokers.cards[_selfid+1].config.center.name
        if string.find(_cname,"j_") then _cname = G.jokers.cards[_selfid+1].config.center.loc_txt.name end

        _, nvow = string.gsub(_cname, "[AEIOUaeiou]", "")
        card.ability.extra.chiptotal = nvow * card.ability.extra.chipamt
    else
        card.ability.extra.chiptotal = 0
    end
        
    if context.joker_main then
        if math.random(1,20) == 1 then
            local card = create_card(nil, G.consumeables, nil, nil, nil, nil, "c_yahimod_puke", 'leo')
            card:add_to_deck()
            G.consumeables:emplace(card)
        end
            return {
                color = G.C.BLUE,
                message = "+".. card.ability.extra.chiptotal,
                chip_mod = card.ability.extra.chiptotal
            }
    end
end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}   

-- Tree

SMODS.Sound({key = "woodbreaking", path = "woodbreaking.ogg",})
SMODS.Sound({key = "woodbroke", path = "woodbroke.ogg",})

SMODS.Atlas{
    key = 'tree',
    path = 'tree.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'tree',
    loc_txt= {
        name = 'Tree',
        text = { "The supplement of",
                    "every Minecraft playthrough.",}
    },
    atlas = 'tree',
    rarity = 1,
    cost = 2,
    pools = { ["Yahimodaddition"] = true },
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {damage = 0}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.damage}  }
	end,

    calculate = function(self, card, context)
    if context.cry_press then
        if card.states.hover.is == true then
            card.ability.extra.damage = card.ability.extra.damage + 1
            local _treecardcenter = G.P_CENTERS.j_yahimod_tree
            _treecardcenter.pos.x = 1+math.floor(card.ability.extra.damage/5)
            card:juice_up(0.3,0.5)

            if card.ability.extra.damage > 2*5 then
                for i = 1, 4 do
                    local card = create_card("j_yahimod_oaklog", G.jokers, nil, nil, nil, nil, "j_yahimod_oaklog", 'tree')
                    card:add_to_deck()
                    G.jokers:emplace(card)
                end
                card:start_dissolve({G.C.RED})
                G.P_CENTERS.j_yahimod_tree.pos.x = 0
                play_sound("yahimod_woodbroke")
            else
                play_sound("yahimod_woodbreaking")
            end
        end

    end
end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}   

-- Oak Log
SMODS.Atlas{
    key = 'oaklog',
    path = 'oaklog.png',
    px = 70,
    py = 95,
}

SMODS.Joker{
    key = 'oaklog',
    loc_txt= {
        name = 'Oak Log',
        text = { "{C:red} +#1#{} Planks",
    },},
    atlas = 'oaklog',
    rarity = 1,
    cost = 2,
    pools = {["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    hidden = true,

    pos = {x=0, y= 0},
    config = { extra = {mult = 4}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.mult }  }
	end,

    calculate = function(self, card, context)
    if context.joker_main then
        return 
            {
            mult = card.ability.extra.mult,
            }
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Toasterball

SMODS.Atlas{
    key = 'toasterball',
    path = 'toasterball.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'toasterball',
    loc_txt= {
        name = 'Toasterball',
        text = { "If you have {C:attention}2 Toasterball",
                    "jokers, retriggers",
                    "all jokers inbetween them",}
    },
    atlas = 'toasterball',
    rarity = 2,
    cost = 7,
    pools = {["Yahimodaddition"] = true},

    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x=0, y= 0},

    add_to_deck = function(self, card, from_debuff)
        toastercount = 0
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].config.center_key == "j_yahimod_toasterball" then
                toastercount = toastercount + 1
            end
        end
        if toastercount > 1 then
            G.FUNCS.overlay_menu{
                definition = create_UIBox_custom_video1("nuuh","I understand."),
                config = {no_esc = true}
            }
            card:start_dissolve()
            ease_dollars(7)
        end
    end,

    calculate = function(self, card, context)

        selfid = 0
        toastercount = 0
        othertoaster = 1

        -- get my id
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then selfid = i end
        end

        -- make sure there's exactly 2 toasters
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].config.center_key == "j_yahimod_toasterball" then
                toastercount = toastercount + 1
            end
        end

        -- get other toasterball id if it exists
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] ~= card and G.jokers.cards[i].config.center_key == "j_yahimod_toasterball" then
                othertoaster = i
            end
        end

        --print(selfid..")toastercount:"..toastercount)
        --print(selfid..")othertoaster:"..othertoaster)

        if toastercount == 2 and selfid < othertoaster and context.retrigger_joker_check and not context.retrigger_joker then
            
            local _tempid = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == context.other_card then _tempid = i end
            end

                if _tempid > selfid and _tempid < othertoaster then
                    return {
                            message = "BALL!",
                            repetitions = 1,
                            card = card,
                        }
		    end
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Joel
SMODS.Atlas{
    key = 'joel',
    path = 'joel.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'joel',
    loc_txt= {
        name = 'Joel',
        text = { "{X:mult,C:white}X#1#{} Mult",
                    "for every {C:attention}cat joker",
                    "in your possession",
                    "Currently {X:mult,C:white}X#2#{} Mult",}
    },
    atlas = 'joel',
    rarity = 2,
    cost = 5,
    pools = { ["Cat"] = true, ["Yahimodaddition"] = true },
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {xmult = 1, xmulttotal=1}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.xmult, center.ability.extra.xmulttotal, }  }
	end,

    calculate = function(self, card, context)
    catcount = 0
    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].config.center.pools and G.jokers.cards[i].config.center.pools.Cat then
            catcount = catcount + 1
        end
    end
    card.ability.extra.xmulttotal = catcount * card.ability.extra.xmult
    if context.joker_main then
        return {
            color = G.C.RED,
            message = "x".. card.ability.extra.xmulttotal,
            Xmult_mod = card.ability.extra.xmulttotal
        }
    end
end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}  

SMODS.Sound({key = "piglinhmm", path = "piglinhmm.ogg",})

-- Piglin
SMODS.Atlas{
    key = 'piglin',
    path = 'piglin.png',
    px = 70,
    py = 95,
}

SMODS.Joker{
    key = 'piglin',
    loc_txt= {
        name = 'Piglin',
        text = { "Creates a {C:attention}random consumable{}",
                    "if your first hand contains",
                    "a scoring {C:attention}gold card{}",
    },},
    atlas = 'piglin',
    rarity = 2,
    cost = 7,
    pools = {["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    enhancement_gate = 'm_gold',

    pos = {x=0, y= 0},
    config = { extra = {mult = 3, Xmult = 1.15}},

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
		return { vars = { center.ability.extra.mult, center.ability.extra.Xmult }  }
	end,

    calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual and context.other_card and G.GAME.current_round.hands_played == 0 then
            if SMODS.has_enhancement(context.other_card, 'm_gold') then 
                    
                    return{
                    G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    blocking = false,
                    delay = 0,
                    func = function()
                        message = "Hmm..."
                        play_sound("yahimod_piglinhmm")
                        local cardgen = create_card("Consumeables", G.Consumeables, nil, nil, nil, nil, nil, 'piglin')
                        cardgen:add_to_deck()
                        G.consumeables:emplace(cardgen)
                        return true
                    end,
                    }))
                    }

                    
                end
           
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- Dr Whatsapp
SMODS.Atlas{
    key = 'drwhatsapp',
    path = 'drwhatsapp.png',
    px = 70,
    py = 95,
}

SMODS.Joker{
    key = 'drwhatsapp',
    loc_txt= {
        name = 'Dr. Whatsapp',
        text = { "Retriggers all {C:green}Whatsapp Seals{} twice",
                    "If your first hand contains",
                    "{C:attention}only{} one card, applies",
                    "a {C:green}Whatsapp Seal{} to it",
    },},
    atlas = 'drwhatsapp',
    rarity = 3,
    cost = 9,
    pools = {["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x=0, y= 0},

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if context.other_card.seal == "yahimod_whatsapp_seal" then 
                    return {
                        message = localize("k_again_ex"),
                        repetitions = 2,
                        card = card,
                    }
            end
        end

        if context.cardarea == G.play and context.individual and #G.play.cards == 1 and G.GAME.current_round.hands_played == 0 then
            context.other_card.seal = "yahimod_whatsapp_seal"
            return {
                        message = "Whatsapp-ified!",
                        card = card,
                        sound = "yahimod_whatsapp",
                        }
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- gatowhatsapp
SMODS.Atlas{
    key = 'gatowhatsapp',
    path = 'gatowhatsapp.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'gatowhatsapp',
    loc_txt= {
        name = 'Gato Whatsapp',
        text = { "Sell this card to apply",
                    "a {C:green}whatsapp seal",
                    "to two random cards",
                    "in your hand",}
    },
    atlas = 'gatowhatsapp',
    rarity = 1,
    cost = 4,
    pools = { ["Cat"] = true, ["Yahimodaddition"] = true },
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},

    calculate = function(self, card, context)
    if context.selling_self then
        local _eligiblecards = {}
        for i = 1, #G.hand.cards do
            if G.hand.cards[i].seal == nil then
                table.insert(_eligiblecards,i)
            end
        end
        if #_eligiblecards >= 2 then
            local _pickedid = math.random(#_eligiblecards)
            local _picked1 = _eligiblecards[_pickedid]
            table.remove(_eligiblecards,_pickedid)
            local _picked2 = _eligiblecards[math.random(#_eligiblecards)]
            play_sound("yahimod_whatsapp")
            G.hand.cards[_picked1].seal = "yahimod_whatsapp_seal"
            G.hand.cards[_picked2].seal = "yahimod_whatsapp_seal"
        else
            return{
                message = "How the fuck do you want me to do this"
            }
        end
    end
end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}  

-- Yahicard
SMODS.Atlas{
    key = 'yahicard',
    path = 'yahicard.png',
    px = 150/2,
    py = 200/2,
}

SMODS.Joker{
    key = 'yahicard',
    loc_txt= {
        name = 'Yahiamice',
        text = { "Rerolls become {C:attention}free",
                    "Sets your shop slots to {C:attention}9",
                    "The more you reroll, the more likely",
                    "{C:dark_edition}Negative{} cards show up",
                    "{C:inactive}(Currently{} {C:dark_edition}#2#% odds)",
    },},
    atlas = 'yahicard',
    rarity = 3,
    cost = 24,
    pools = {["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    pos = {x=0, y= 0},
    config = { extra = {oldshopsize = 3, buffedodds = 0}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.oldshopsize, center.ability.extra.buffedodds }  }
	end,

    add_to_deck = function(self, card, from_debuff)
        G.GAME.current_round.free_rerolls = 2
        card.ability.extra.oldshopsize = G.GAME.shop.joker_max
        G.GAME.current_round.free_rerolls = 2
        G.GAME.shop.joker_max = 9
        if G.shop then
            G.shop:recalculate()
            G.shop_jokers.T.w = 6*1.02*G.CARD_W
            G.shop_jokers.T.h = 1.05*G.CARD_H
        end
    end,

    remove_from_deck = function(self, card, from_debuff)
		G.GAME.shop.joker_max = card.ability.extra.oldshopsize
	end,


    
    calculate = function(self, card, context)
        

        if context.end_of_round then
            card.ability.extra.buffedodds = 0
        end

        if context.starting_shop then
            G.GAME.current_round.free_rerolls = 2
            G.GAME.shop.joker_max = 9
            G.shop:recalculate()
            G.shop_jokers.T.w = 6*1.02*G.CARD_W
            G.shop_jokers.T.h = 1.05*G.CARD_H
        end


        if context.store_joker_create then
            print("shopjoker created!")

        end


        G.GAME.current_round.free_rerolls = 2
        if context.reroll_shop then
            G.GAME.shop.joker_max = 9
            G.shop:recalculate()
            G.GAME.current_round.free_rerolls = 2
            card.ability.extra.buffedodds = card.ability.extra.buffedodds + 0.3
            for i = 1, #G.shop_jokers.cards do
                if math.random(0,100) < card.ability.extra.buffedodds then
                    G.shop_jokers.cards[i]:set_edition({negative = true}, true)
                end
                if math.random(0,500) < card.ability.extra.buffedodds then
                    G.shop_jokers.cards[i]:set_edition({yahimod_evil = true}, true)
                end
            end
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,

    
}

-- Cantaloupe

SMODS.Sound({key = "cantaloupe", path = "cantaloupe.ogg",})
SMODS.Atlas{
    key = 'cantaloupe',
    path = 'cantaloupe.png',
    px = 70,
    py = 95,
}

SMODS.Joker{
    key = 'cantaloupe',
    loc_txt= {
        name = 'Cantaloupe',
        text = { "{C:red} +#1#{} Mult",
    },},
    atlas = 'cantaloupe',
    rarity = 2,
    cost = 6,
    pools = {["Yahimodaddition"] = true},
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {mult = 25}},

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.mult }  }
	end,

    calculate = function(self, card, context)
    if context.joker_main then
        G.showcantaloupe = 530
        play_sound("yahimod_cantaloupe")
        return 
            {
            mult = card.ability.extra.mult,
            
            
            }
        end
    end,
    
    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}

-- doudou
SMODS.Atlas{
    key = 'doudou',
    path = 'doudou.png',
    px = 71,
    py = 96,
}

SMODS.Joker{
    key = 'doudou',
    loc_txt= {
        name = 'Doudou',
        text = { "+#1# Mult for every other",
                    "a {C:attention}Cat Joker",
                    "in your possession",
                    "{C:inactive}Currently {C:red}#2#Mult"}
    },
    atlas = 'doudou',
    rarity = 1,
    cost = 4,
    pools = { ["Cat"] = true, ["Yahimodaddition"] = true },
    
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,

    pos = {x=0, y= 0},
    config = { extra = {mult = 3, multtotal =0 }},
    

    calculate = function(self, card, context)
    catcount = 0
    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].config.center.pools and G.jokers.cards[i].config.center.pools.Cat then
            catcount = catcount + 1
        end
    end
    card.ability.extra.multtotal = catcount * card.ability.extra.mult
    if context.joker_main then
        return {
            color = G.C.RED,
            message = "+".. card.ability.extra.multtotal,
            Xmult_mod = card.ability.extra.multtotal
        }
    end
end,

    check_for_unlock = function(self, args)
        if args.type == 'test' then --not a real type, just a joke
            unlock_card(self)
        end
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
}  



local yahimodkeypress = love.keypressed
function love.keypressed(key)
    --print(key)
    if key == "y" then
        local isdeerhere = false
        local deerid = 0
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].ability.name == 'j_yahimod_deer' then
                isdeerhere = true
                deerid = i
            end
        end
        if (isdeerhere == true) then
            if #G.jokers.cards < G.jokers.config.card_limit then
                if math.random(1,500) == 1 then
                    card_eval_status_text(G.jokers.cards[deerid],'extra',nil,nil,nil,{message = "Wait a minute."})
                    addHorse()
                else
                    local card = create_card('Joker', G.Jokers, nil, nil, nil, nil, 'j_yahimod_deer', 'deer')
                    card.sell_cost = 0
                    card:add_to_deck()
                    G.jokers:emplace(card)
                    play_sound("timpani")
                end
            else
                card_eval_status_text(G.jokers.cards[deerid],'extra',nil,nil,nil,{message = localize('k_no_room_ex')})
            end
        end
    end
    if key == "return" and G.CONTROLLER.hovering.target.config.center ~= nil then
        local _element = G.CONTROLLER.hovering.target
        local _set = false
        if (_element.config.center.set == "Joker") then 
            _set = true 
            end
        if (_element.config.center.set == "Tarot" ) then 
            _set = true
            end
        if (_element.config.center.set == "Planet") then 
            _set = true
            end
        if (_element.config.center.set == "Spectral") then 
            _set = true
            end
        
        if (G.opentolan_canspawn == true) and _element and _set == true then
            local card = create_card('',G.Jokers, nil, nil, nil, nil, _element.config.center.key, 'opentolan')
            card.sell_cost = 0
            card:add_to_deck()
            G.jokers:emplace(card)
            G.opentolan_phase_ex = 2
            G.opentolan_phase = Yahimod.ticks
            play_sound("timpani")
            G.opentolan_canspawn = false
            
        end
    end
    return (yahimodkeypress(key))
end

local ctrup = Controller.update
function Controller:update(dt)
    ctrup(self,dt)

end

local upd = Game.update
function Game:update(dt)
    upd(self, dt)


    -- tick based events
    if Yahimod.ticks == nil then Yahimod.ticks = 0 end
        Yahimod.ticks = Yahimod.ticks + 1

    if math.fmod(Yahimod.ticks,8) == 0 then
        if G.GAME.blind and G.GAME.blind.chip_text and tonumber(G.GAME.blind.chip_text) ~= tonumber(G.GAME.blind.chips) then
            local _chipvalue = number_format(tostring(G.GAME.blind.chips):gsub(",",""))
            local _chiptext = number_format(tostring(G.GAME.blind.chip_text):gsub(",",""))

            local _diff = ((_chipvalue) - (_chiptext))
            G.GAME.blind.chip_text = math.floor(_chiptext + _diff/20)
            if math.abs(_diff) < _chipvalue*0.02 then G.GAME.blind.chip_text = _chipvalue end
            play_sound("generic1", math.random(1.5,2.0), 0.35)
        end
    end
        -- tick based events
    if G.GAME.blind and not G.GAME.blind.disabled and G.GAME.blind.name == 'boss_vibe' then
        G.SETTINGS.GAMESPEED = 0.25
    end

    if G.jokers then
        -- yahijoker presence
        local _yahiexists = false
        for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].ability.name == "j_yahimod_yahiamice" then _yahiexists = true end
        if _yahiexists == true then
            for i = 1, #G.shop_jokers.cards[i] do
                local _xid = 1 + math.fmod(i-1,3)
                local _yid = math.floor(i-1/3)-1
                if i < 4 and i > 6 then
                    print(i)
                    G.shop_jokers.cards[i].CT.x = G.shop_jokers.cards[_xid].CT.x
                    G.shop_jokers.cards[i].CT.y = G.shop_jokers.cards[4].CT.y - _yid * G.shop_jokers.cards[4].CT.h
                    end
                end
            end
        end

            --speedrun boss blind
            if math.fmod(Yahimod.ticks,240) == 0 and G.GAME.blind and G.GAME.blind.name == 'boss_speedrun' then
                if G.clockticking >= 1 then
                    G.clockticking = G.clockticking - 1
                    play_sound("generic1",2,0.5)
                    end
                end

        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].getting_sliced == true and not G.hasajokerbeendestroyedthistick == true then
                G.hasajokerbeendestroyedthistick = true
                return {
                    print("found a joker being destroyed! adding Mult")
                }
            end

            

            -- horse needs eternal sticker
            if G.jokers.cards[i].ability.name == 'j_yahimod_horsewalksin' then
                local _horse = G.jokers.cards[i]
                local _horsec = G.P_CENTERS.j_yahimod_horsewalksin
                if _horse.ability.extra.round < _horse.ability.extra.maxround and _horse.ability.eternal ~= true then
                    _horse.ability.eternal = true
                end
            end
            -- subway surfers increase
            if G.jokers.cards[i].ability.name == 'j_yahimod_subwaysurfers' then
                local _subcard = G.jokers.cards[i]

                if math.fmod(Yahimod.ticks,35) == 0 then
                    local _subcardcenter = G.P_CENTERS.j_yahimod_subwaysurfers
                    _subcardcenter.frame = _subcardcenter.frame + 1
                    local _fr = _subcardcenter.frame
                    _subcardcenter.pos.x = math.fmod(_fr,16)
                    _subcardcenter.pos.y = math.floor(_fr/16)
                    if _subcardcenter.frame > 253 then _subcardcenter.frame = 0 end
                end

                if math.random(1,80) == 1 then 
                    G.jokers.cards[i].ability.extra.chips = G.jokers.cards[i].ability.extra.chips +1
                end
                if math.random(1,160) == 1 then 
                    G.jokers.cards[i].ability.extra.mult = G.jokers.cards[i].ability.extra.mult +1
                end
                if math.random(1,5000) == 1 then 
                    G.jokers.cards[i].ability.extra.chips = 0
                    G.jokers.cards[i].ability.extra.mult = 0
                    card_eval_status_text(G.jokers.cards[i],'extra',nil,nil,nil,{message = "Uh oh!"})
                    play_sound("timpani")
                end
            end

        end
    end
end

-- card creation override

--function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
--    if card and card.ability.name == "yahimod_horsewalksin" then
--		card:
--	end
--    return card
--end




local drawhook = love.draw
function love.draw()
    drawhook()
    function loadThatFuckingImage(fn)
        local full_path = (Yahimod.path 
        .. fn)
        local file_data = assert(NFS.newFileData(full_path),("Epic fail"))
        local tempimagedata = assert(love.image.newImageData(file_data),("Epic fail 2"))
        return (assert(love.graphics.newImage(tempimagedata),("Epic fail 3")))
    end
    

    local _xscale = 2*love.graphics.getWidth()/1920
    local _yscale = 2*love.graphics.getHeight()/1080


    --if Video:isplaying(Yahimod.nuuh) then
    --    love.graphics.draw(Yahimod.nuuh,0,0,0,_xscale/2,_yscale/2)
    --end


    -- boss blind speedrun
    if G.GAME.blind and G.GAME.blind.name == 'boss_speedrun' then
        love.graphics.setColor(1, 1, 1, 1) 
        love.graphics.print("00:"..G.clockticking, 1124, 371,0,3,3)
    end
    

    -- fish
    if G.showfish and (G.showfish > 0) then
        --love.graphics.print("ticks:" .. Yahimod.ticks, 500, 35)
        if Yahimod.fishpng == nil then Yahimod.fishpng = loadThatFuckingImage("fishondafloo.png") end
        love.graphics.setColor(1, 1, 1, 1) 
        love.graphics.draw(Yahimod.fishpng, 0*_xscale, 0*_yscale,0,_xscale*2,_yscale*2)
        G.showfish = G.showfish - 1
    end

    -- cantaloupe
    if G.showcantaloupe and (G.showcantaloupe > 0) then
        if Yahimod.cantaloupe == nil then Yahimod.cantaloupe = loadThatFuckingImage("cantaloupescreen.png") end
        love.graphics.setColor(1, 1, 1, 1) 
        love.graphics.draw(Yahimod.cantaloupe, 0*_xscale, 0*_yscale,0,_xscale*2,_yscale*2)
        G.showcantaloupe = G.showcantaloupe - 1   
    end

    -- cat
    if G.showlaughingcat and (G.showlaughingcat > 0) then
        --love.graphics.print("ticks:" .. Yahimod.ticks, 500, 35)
        if G.showlaughingcat == 800 then play_sound("yahimod_catlaughing") addHorse() end
        if G.showlaughingcat < 800 then
            if Yahimod.catlaughingpng == nil then Yahimod.catlaughingpng = loadThatFuckingImage("catlaughing.png") end
            love.graphics.setColor(1, 1, 1, 1) 
            love.graphics.draw(Yahimod.catlaughingpng, 0*_xscale, 0*_yscale,0,_xscale*2,_yscale*2)
            G.showlaughingcat = G.showlaughingcat - 1
        else
            if Yahimod.youwinpng == nil then Yahimod.youwinpng = loadThatFuckingImage("youwin.png") end
            love.graphics.setColor(1, 1, 1, 1) 
            love.graphics.draw(Yahimod.youwinpng, 875*_xscale/2, 90*_xscale/2,0,_xscale/2,_yscale/2)
            G.showlaughingcat = G.showlaughingcat - 1
            
        end
    end

    if (G.opentolan_canspawn == true) then
        --love.graphics.print("ticks:" .. Yahimod.ticks, 500, 35)
        if Yahimod.horsepng == nil then Yahimod.horsepng = loadThatFuckingImage("horsepng.png") end
        if Yahimod.mcchat1 == nil then Yahimod.mcchat1 = loadThatFuckingImage("assets/mcchat/line1.png") end
        if Yahimod.mcchat2 == nil then Yahimod.mcchat2 = loadThatFuckingImage("assets/mcchat/line2.png") end
        
        
        local _graph = Yahimod.mcchat1
        if math.fmod((Yahimod.ticks - G.opentolan_phase),2000) <= 1000 then 
            _graph = Yahimod.mcchat1 
        else
            _graph = Yahimod.mcchat2
        end

        
        
        love.graphics.setColor(1, 1, 1, 1) 
        love.graphics.draw(_graph, 1*_xscale, 350*_yscale,0,_xscale,_yscale)
    end
    if (G.opentolan_canspawn ~= true) and G.opentolan_phase_ex == 2 then

        local alphatemp = 2 - (Yahimod.ticks - G.opentolan_phase)/1000
        if Yahimod.mcchat3 == nil then Yahimod.mcchat3 = loadThatFuckingImage("assets/mcchat/line3.png") end
        love.graphics.setColor(1, 1, 1, alphatemp)
        love.graphics.draw(Yahimod.mcchat3, 1*_xscale, 350*_yscale,0,_xscale,_yscale)
        if alphatemp == 0 then
            G.opentolan_phase_ex = 0
        end
    end
end

function addHorse()
    local card = create_card('Joker', G.Jokers, nil, nil, nil, nil, 'j_yahimod_horsewalksin', 'deer')
    card.sell_cost = 4
    card:add_to_deck()
    G.jokers:emplace(card)
    play_sound("yahimod_horse")
end

function calculate_jack_amount()
    local count = 0
    for _, card in ipairs(G.playing_cards) do
        local rank = card.base.value
        if rank == "Jack" then
            count = count + 1
        end
    end
    return count
end

-- from cryptid/items/misc_joker.lua
local lcpref = Controller.L_cursor_press
function Controller:L_cursor_press(x, y)
    lcpref(self, x, y)
    if G and G.jokers and G.jokers.cards and not G.SETTINGS.paused then
        SMODS.calculate_context({ cry_press = true })
    end
end

--for i = 1, #G.jokers.cards do
--    if G.jokers.cards[i].getting_sliced == true then
--
--        G.hasajokerbeendestroyedthistick = true
--    end
--end

----------------------------------------------------------
----------- MOD CODE END ----------------------------------