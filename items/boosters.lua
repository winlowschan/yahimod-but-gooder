-- Booster Atlas
SMODS.Atlas{
    key = 'boosteratlas',
    path = 'boosteratlas.png',
    px = 71,
    py = 96,
}

SMODS.Sound({
    key = "music_buysomethin", 
    path = "music_buysomethin.ogg",
    pitch = 1,
    volume = 0.6,
    select_music_track = function()
        if G.STATE == G.STATES.SMODS_BOOSTER_OPENED then
            if G.pack_cards
                and G.pack_cards.cards
                and G.pack_cards.cards[1]
                and G.pack_cards.cards[1].config
                and G.pack_cards.cards[1].config.center
                and G.pack_cards.cards[1].config.center.mod
                and G.pack_cards.cards[1].config.center.mod.id 
                and G.pack_cards.cards[1].config.center.mod.id == "Yahimod" then
		        return true 
            end
        end
	end,
})

-- Booster Pack 1
SMODS.Booster{
    key = 'booster_yahiworld',
    group_key = "k_yahimod_booster_group",
    atlas = 'boosteratlas', 
    pos = { x = 0, y = 0 },
    discovered = true,
    loc_txt= {
        name = 'YAHIMOD BOOSTER PACK',
        text = { "Pick {C:attention}#1#{} card out",
                "{C:attention}#2#{} YAHIMOD jokers!", },
        group_name = {"Pick somethin', will ya?"},
    },
    
    draw_hand = false,
    config = {
        extra = 3,
        choose = 1, 
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,

    weight = 1,
    cost = 5,
    kind = "YahiworldPack",
    
    create_card = function(self, card, i)
        ease_background_colour(HEX("ffac00"))
        return SMODS.create_card({
            set = "Yahimodaddition",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
        })
    end,
    select_card = 'jokers',

    in_pool = function() return true end
}

-- Booster Pack 2
SMODS.Booster{
    key = 'booster_yahiworld2',
    group_key = "k_yahimod_booster_group",
    atlas = 'boosteratlas', 
    pos = { x = 1, y = 0 },
    discovered = true,
    loc_txt= {
        name = 'YAHIMOD BOOSTER PACK',
        text = { "Pick {C:attention}#1#{} card out",
                "{C:attention}#2#{} YAHIMOD jokers!", },
        group_name = {"Pick somethin', will ya?"},
    },
    
    draw_hand = false,
    config = {
        extra = 3,
        choose = 1, 
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,
    weight = 1,
    cost = 5,
    kind = "YahiworldPack",
    
    create_card = function(self, card, i)
        ease_background_colour(HEX("ffac00"))
        return SMODS.create_card({
            set = "Yahimodaddition",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
        })
    end,
    select_card = 'jokers',

    in_pool = function() return true end
}

-- Booster Pack 3
SMODS.Booster{
    key = 'booster_yahiworld3',
    group_key = "k_yahimod_booster_group",
    atlas = 'boosteratlas', 
    pos = { x = 0, y = 1 },
    discovered = true,
    loc_txt= {
        name = 'WOULD YOU RATHER?',
        text = { "Pick {C:attention}#1#{} card out",
                "{C:attention}#2#{} YAHIMOD jokers!", },
        group_name = {"Pick somethin', will ya?"},
    },
    
    draw_hand = false,
    config = {
        extra = 2,
        choose = 1, 
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,
    weight = 1,
    cost = 3,
    kind = "YahiworldPack",
    
    create_card = function(self, card, i)
        ease_background_colour(HEX("ffac00"))
        return SMODS.create_card({
            set = "Yahimodaddition",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
        })
    end,
    select_card = 'jokers',

    in_pool = function() return true end
}

-- Booster Pack 4
SMODS.Booster{
    key = 'booster_yahiworld4',
    group_key = "k_yahimod_booster_group",
    atlas = 'boosteratlas', 
    pos = { x = 1, y = 1 },
    discovered = true,
    loc_txt= {
        name = 'JUMBO YAHIMOD PACK',
        text = { "Pick {C:attention}#1#{} card out",
                "{C:attention}#2#{} YAHIMOD jokers!", },
        group_name = {"Pick somethin', will ya?"},
    },
    
    draw_hand = false,
    config = {
        extra = 7,
        choose = 1, 
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,
    weight = 0.66,
    cost = 7,
    kind = "YahiworldPack",
    
    create_card = function(self, card, i)
        ease_background_colour(HEX("ffac00"))
        return SMODS.create_card({
            set = "Yahimodaddition",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
        })
    end,
    select_card = 'jokers',

    in_pool = function() return true end
}