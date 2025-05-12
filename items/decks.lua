SMODS.Atlas{
    key = 'Decks',
    path = 'rsgdeck.png',
    px = 71,
    py = 95,
}

SMODS.Back({
    key = "rsg_deck",
    loc_txt = {
        name = "Resetting For A Beach Seed",
        text={
        "Start with an",
        "{C:attention}Open To Lan{}",
        },
    },
	
	config = { hands = 0, discards = 0, consumeables = 'c_opentolan'},
	pos = { x = 0, y = 0 },
	order = 1,
	atlas = "Decks",
    unlocked = true,

	apply = function(self)
        G.E_MANAGER:add_event(Event({
			func = function()
				if G.consumeables then
                    local card = create_card("Spectral", G.consumeables, nil, nil, nil, nil, "c_yahimod_opentolan", "yahimod_deck")
                    card:add_to_deck()
                    --card:start_materialize()
                    G.consumeables:emplace(card)
                    return true
                  end
			end,
		}))
	end,

	check_for_unlock = function(self, args)
		if args.type == "win_deck" then
            unlock_card(self)
        else
			unlock_card(self)
		end
	end,
})

SMODS.Back({
    key = "whatsapp_deck",
    loc_txt = {
        name = "Google Play",
        text={
        "Start with a",
        "{C:green}Dr. Whatsapp{}",
        },
    },
	
	config = { hands = 0, discards = 0, consumeables = 'c_opentolan'},
	pos = { x = 1, y = 0 },
	order = 1,
	atlas = "Decks",
    unlocked = true,

	apply = function(self)
        G.E_MANAGER:add_event(Event({
			func = function()
				if G.consumeables then
                    local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_yahimod_drwhatsapp", "yahimod_deck")
                    card:add_to_deck()
                    --card:start_materialize()
                    G.jokers:emplace(card)
                    return true
                  end
			end,
		}))
	end,

	check_for_unlock = function(self, args)
		if args.type == "win_deck" then
            unlock_card(self)
        else
			unlock_card(self)
		end
	end,
})

SMODS.Back({
    key = "mound_deck",
    loc_txt = {
        name = "The Mound",
        text={
        "+2 Joker Slots",
        "-2 Hands",
        },
    },
	
	config = { hands = -2, joker_slot = 2, consumeables = 'c_opentolan'},
	pos = { x = 2, y = 0 },
	order = 1,
	atlas = "Decks",
    unlocked = true,

	check_for_unlock = function(self, args)
		if args.type == "win_deck" then
            unlock_card(self)
        else
			unlock_card(self)
		end
	end,
})