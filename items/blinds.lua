SMODS.Atlas {
    key = "yahiblinds",
    path = "blindsatlas.png",
    px = 34,
    py = 34,
    frames = 1,
    atlas_table = 'ANIMATION_ATLAS'
}

SMODS.Atlas {
    key = "yahiblinds2",
    path = "blindsatlas2.png",
    px = 34,
    py = 34,
    frames = 1,
    atlas_table = 'ANIMATION_ATLAS'
}

SMODS.Blind {
    name = "boss_jimothy",
    key = "boss_jimothy",
    atlas = "yahiblinds",
    mult = 2,
    pos = { y = 1 },
    dollars = 10,
    loc_txt = {
        name = 'JIMOTHY',
        text = {
            'Debuffs all',
            'YAHIMOD cards',
        }
    },
    boss = {  min = 1 },
    boss_colour = HEX('3cc0c8'),

    recalc_debuff = function(self, card)
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].config.center.pools and G.jokers.cards[i].config.center.pools.Yahimodaddition then
                G.jokers.cards[i]:set_debuff(true)
            end
        end
    end,

    disable = function(self)
       for i = 1, #G.jokers.cards do
            G.jokers.cards[i]:set_debuff(false)
       end
    end,

    defeat = function(self)
       for i = 1, #G.jokers.cards do
            G.jokers.cards[i]:set_debuff(false)
       end
    end,
}

SMODS.Blind {
    name = "boss_horse",
    key = "boss_horse",
    atlas = "yahiblinds",
    mult = 2,
    pos = { y = 0 },
    dollars = 10,
    loc_txt = {
        name = 'THE HORSE',
        text = {
            'Fuck you',
        }
    },
    boss = {  min = 2 },
    boss_colour = HEX('795223'),

    debuff_hand = function(self)
        for i = 1, #G.play.cards do
            if G.play.cards[i].seal == nil then
                SMODS.juice_up_blind()
                G.play.cards[i].seal = "yahimod_horse_seal"
                play_sound("yahimod_horse")
                delay(0.3)
            end
        end
    end,

    defeat = function(self)
       if G.ARGS.chip_flames.real_intensity > 0.000001 then
            addHorse()
            G.FUNCS.overlay_menu{
                definition = create_UIBox_custom_video1("horsef","Hell Yeah"),
                config = {no_esc = true}
            }
       end
    end,


}

SMODS.Blind {
    name = "boss_vibe",
    key = "boss_vibe",
    atlas = "yahiblinds",
    pos = { y = 2 },
    dollars = 8,
    loc_txt = {
        name = 'VIBE',
        text = {
            'Sets game speed to x0.25'
        }
    },
    boss = {  min = 2 },
    boss_colour = HEX('bc25ec'),

    defeat = function(self)
        G.SETTINGS.GAMESPEED = G.GAME.normalgamespeed
        G.GAME.normalgamespeed = nil
    end,

    disable = function(self)
        G.SETTINGS.GAMESPEED = G.GAME.normalgamespeed
        G.GAME.normalgamespeed = nil
    end,
}

SMODS.Blind {
    name = "boss_chickenjockey",
    key = "boss_chickenjockey",
    atlas = "yahiblinds",
    pos = { y = 3 },
    dollars = 10,
    mult = 1,
    loc_txt = {
        name = 'CHICKEN JOCKEY',
        text = {
            'Smaller Blind Size',
            '-2 Hands - 2 Discards',
        }
    },
    boss = {  min = 2 },
    boss_colour = HEX('2fa44a'),

    

    set_blind= function(self)
        G.GAME.current_round.hands_left = G.GAME.current_round.hands_left - 2
        G.GAME.current_round.discards_left = G.GAME.current_round.discards_left - 2
    end,

    disable = function(self)
        G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + 2
        G.GAME.current_round.discards_left = G.GAME.current_round.discards_left + 2
    end,
        
}

SMODS.Blind {
    name = "boss_fish",
    key = "boss_fish",
    atlas = "yahiblinds",
    pos = { y = 4 },
    dollars = 6,
    mult = 2,
    loc_txt = {
        name = 'FISH!',
        text = {
            'FISH!',
        }
    },
    boss = {  min = 3 },
    boss_colour = HEX('e9f3f2'),

    
    debuff_hand = function(self)
    G.showfish = 175
    play_sound("yahimod_fish")
    end,

    set_blind= function(self)
        G.showfish = 175
        play_sound("yahimod_fish")
    end,

    disable = function(self)
        G.FUNCS.overlay_menu{
                definition = create_UIBox_custom_video1("nuuh","I understand."),
                config = {no_esc = true}
            }
    end,
        
}

SMODS.Blind {
    name = "boss_bastion",
    key = "boss_bastion",
    atlas = "yahiblinds",
    pos = { y = 5 },
    dollars = 8,
    mult = 1.5,
    loc_txt = {
        name = 'BASTION REMNANT',
        text = {
            "Played cards won't score",
            "unless if a gold card",
            "is held in hand",
        }
    },
    boss = {  min = 3 },
    boss_colour = HEX('ffd955'),

    
    debuff_hand = function(self)
        local _hasgold = false
        for i = 1, #G.hand.cards do
            if SMODS.has_enhancement(G.hand.cards[i], 'm_gold') then
                _hasgold = true
            end
        end
        if _hasgold ~= true and not G.GAME.blind.disabled then
            SMODS.juice_up_blind()
            return true
        end
    end,
        
}

SMODS.Blind {
    name = "boss_speedrun",
    key = "boss_speedrun",
    atlas = "yahiblinds",
    pos = { y = 6 },
    dollars = 8,
    mult = 1.5,
    loc_txt = {
        name = 'THE SPEEDRUN',
        text = {
            "Beat this blind in",
            "60 seconds or it's",
            "GAME OVER.",
        }
    },
    boss = {  min = 4 },
    boss_colour = HEX('a7ffa8'),

    
    calculate = function(self, card, context)
        if G.clockticking <= 0 then forceGameover() end
    end,

    set_blind = function(self)
        G.clockticking = 60
    end,
    
    debuff_hand = function(self)
        local _timesup = false
        if G.clockticking <= 0 then
            _timesup = true
        end
        if _timesup == true and not G.GAME.blind.disabled then
            return true
        end
    end,
        
}

SMODS.Blind {
    name = "boss_mechahorse",
    key = "boss_mechahorse",
    atlas = "yahiblinds",
    pos = { y = 7 },
    mult = 10,
    dollars = 30,
    loc_txt = {
        name = 'MECHA-HORSE',
        text = {
            'EXTREMELY LARGE BLIND SIZE',
            '(Fuck you 3000)',
        }
    },
    boss = { showdown = true },
    boss_colour = HEX('4f4f4f'),

    debuff_hand = function(self)
        for i = 1, #G.play.cards do
            if G.play.cards[i].seal == nil then
                SMODS.juice_up_blind()
                G.play.cards[i].seal = "yahimod_horse_seal"
                play_sound("yahimod_horse")
                delay(0.3)
            end
        end
    end,

    defeat = function(self)
       if G.ARGS.chip_flames.real_intensity > 0.000001 then
            addHorse()
       end
       G.FUNCS.overlay_menu{
                definition = create_UIBox_custom_video1("pizzatower","Hell Yeah"),
                config = {no_esc = true}
            }
    end,
}

SMODS.Blind {
    name = "boss_damndaniel",
    key = "boss_damndaniel",
    atlas = "yahiblinds",
    pos = { y = 8 },
    mult = 0.01,
    dollars = 1,
    loc_txt = {
        name = 'DAMN DANIEL',
        text = {
            'Damn Daniel!',
            'Back at it again with the white vans!',
        }
    },
    boss = {  min = 1 },
    boss_colour = HEX('456185'),

}

SMODS.Blind {
    name = "boss_poopwall",
    key = "boss_poopwall",
    atlas = "yahiblinds",
    pos = { y = 9 },
    dollars = 6,
    mult = 2,
    loc_txt = {
        name = 'THE POOP WALL',
        text = {
            'Playing your most played hand(s)',
            'crashes the game',
        }
    },
    boss = {  min = 3 },
    boss_colour = HEX('fff38d'),

    
    calculate = function(self, card, context)
        
        if context.cardarea == G.play and context.individual and context.other_card then
            
            local handname = context.scoring_name
            local handplayed = (G.GAME.hands[handname].played or 0)
            local mostplayed = 0

            for k, v in pairs(G.GAME.hands) do 
                if G.GAME.hands[k].played > mostplayed then mostplayed = G.GAME.hands[k].played end
            end

            if G.GAME.hands[handname].played >= mostplayed then crashGame() end
        end
    end,
        
}

function forceGameover()
    G.STATE = G.STATES.GAME_OVER
    G.STATE_COMPLETE = false
end

SMODS.Blind {
    name = "boss_thepip",
    key = "boss_thepip",
    atlas = "yahiblinds",
    pos = { y = 10 },
    dollars = 7,
    mult = 0.3,
    loc_txt = {
        name = 'THE PIP',
        text = {
            "Instantly lose",
            "if you don't play High Card",
        }
    },
    boss = {  min = 4 },
    boss_colour = HEX('9b477e'),

    
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual and context.other_card then
            local handname = context.scoring_name
            if handname ~= "High Card" then forceGameover() end
        end
    end,
        
}

SMODS.Blind {
    name = "boss_alcatraz",
    key = "boss_alcatraz",
    atlas = "yahiblinds",
    pos = { y = 11 },
    dollars = 5,
    mult = 2,
    loc_txt = {
        name = 'ALCATRAZ',
        text = {
            'Debuffs all',
            'Cat cards',
        }
    },
    boss = {  min = 1 },
    boss_colour = HEX('18977f'),

    recalc_debuff = function(self, card)
        for i = 1, #G.jokers.cards do
            if not G.GAME.blind.disabled and G.jokers.cards[i].config.center.pools and G.jokers.cards[i].config.center.pools.Cat then
                G.jokers.cards[i]:set_debuff(true)
            end
        end
    end,

    disable = function(self)
       for i = 1, #G.jokers.cards do
            G.jokers.cards[i]:set_debuff(false)
       end
    end,

    defeat = function(self)
       for i = 1, #G.jokers.cards do
            G.jokers.cards[i]:set_debuff(false)
       end
    end,
}

SMODS.Blind {
    name = "boss_e",
    key = "boss_e",
    atlas = "yahiblinds",
    pos = { y = 12 },
    dollars = 6,
    mult = 2,
    loc_txt = {
        name = 'E',
        text = {
            "Debuffs every Joker whose",
            "name doesn't have 'E'"
        }
    },
    boss = {  showdown = true },
    boss_colour = HEX('cc0d00'),

    recalc_debuff = function(self, card)
        for i = 1, #G.jokers.cards do
            local _card = G.jokers.cards[i]
            local _jn = string.lower(getJokerName(_card))
            if string.find(_jn,"e") == nil and getJokerName(_card) ~= "Luchador" and not G.GAME.blind.disabled then
                G.jokers.cards[i]:set_debuff(true)
            end
        end
    end,

    disable = function(self)
       for i = 1, #G.jokers.cards do
            G.jokers.cards[i]:set_debuff(false)
       end
    end,

    defeat = function(self)
       for i = 1, #G.jokers.cards do
            G.jokers.cards[i]:set_debuff(false)
       end
    end,
}

SMODS.Blind {
    name = "boss_sans",
    key = "boss_sans",
    atlas = "yahiblinds2",
    pos = { y = 0 },
    dollars = 5,
    mult = 2,
    boss = { min = 3 },
    loc_txt = {
        name = 'sans.',
        text = {
            "The easiest blind.",
        }
    },
    boss_colour = HEX('000000'),

}

SMODS.Sound({key = "slotmachine_ding", path = "slotmachine_ding.ogg",})


-- fragile check
userHasClickedBoss = function(x,y)
    if G.GAME.blind and not G.GAME.blind.disabled and G.GAME.blind.name == 'boss_fragile' and G.CONTROLLER.hovering.target and G.CONTROLLER.hovering.target.config.center ~= nil then
        if G.CONTROLLER.hovering.target.config.center.set == "Joker" then
            explodeCard(G.CONTROLLER.hovering.target)
        end
    end
    if G.GAME.blind and not G.GAME.blind.disabled and G.GAME.blind.name == 'boss_gambling' and G.CONTROLLER.hovering.target then
        play_sound("yahimod_slotmachine_ding")
    end
end

SMODS.Blind {
    name = "boss_fragile",
    key = "boss_fragile",
    atlas = "yahiblinds2",
    pos = { y = 1 },
    dollars = 5,
    mult = 2,
    boss = { min = 2 },
    loc_txt = {
        name = 'FRAGILE',
        text = {
            "Clicking on a joker destroys it",
        }
    },
    boss_colour = HEX('fae5c8'),

}

SMODS.Sound({key = "slotmachine", path = "slotmachine.ogg",})
SMODS.Sound({key = "jackpot", path = "jackpot.ogg",})

SMODS.Sound({
    key = "music_slotmachine", 
    path = "music_slotmachine.ogg",
    pitch = 1,
    volume = 0.6,
    select_music_track = function()
        if G.GAME.blind and not G.GAME.blind.disabled and G.GAME.blind.name == 'boss_gambling' then
		    return true end
	end,
})


SMODS.Blind {
    name = "boss_gambling",
    key = "boss_gambling",
    atlas = "yahiblinds2",
    pos = { y = 2 },
    dollars = 15,
    mult = 2,
    boss = { min = 1 },
    loc_txt = {
        name = "LET'S GO GAMBLING!",
        text = {
            "HIT THE SLOTS UP BIG BOY",
        }
    },
    boss_colour = HEX('fae5c8'),

    press_play = function(self)
        play_sound("yahimod_slotmachine")
    end,

    defeat = function(self)
       play_sound("yahimod_jackpot")
    end,

    disable = function(self)
        for i = 1, #G.hand.cards do
            G.hand.cards[i].ability.forced_selection = false
            G.hand:remove_from_highlighted(G.hand.cards[i])
        end
    end,

}

-- Chrome dino
SMODS.Blind {
    name = "boss_dino",
    key = "boss_dino",
    atlas = "yahiblinds2",
    pos = { y = 3 },
    dollars = 7,
    mult = 2,
    boss = { min = 1 },
    loc_txt = {
        name = "CHROME DINO",
        text = {
            "Play a minigame",
        }
    },

    boss_colour = HEX('ffffff'),

    recalc_debuff = function(self)
        dinoLoad()
    end,

    defeat = function(self)
        endDino()
    end,

    disable = function(self)
        endDino()
    end,

}

SMODS.Blind {
    name = "boss_chudjak",
    key = "boss_chudjak",
    atlas = "yahiblinds2",
    pos = { y = 4 },
    dollars = 5,
    mult = 2,
    boss = { min = 5 },
    loc_txt = {
        name = "CHUDJAK",
        text = {
            "Can only draw unmodified cards",
        }
    },
    boss_colour = HEX('ffffff'),

    drawn_to_hand = function(self)
        for i = 1, #G.hand.cards do
            local _discardthisone = false
            if G.hand.cards[i].seal ~= nil then _discardthisone = true end
            if G.hand.cards[i].edition ~= nil then _discardthisone = true end
            if G.hand.cards[i].ability.set ~= "Default" then _discardthisone = true end
            if _discardthisone == true then
                local _selected_card = G.hand.cards[i]
                G.hand:add_to_highlighted(_selected_card, true)
                G.FUNCS.discard_cards_from_highlighted(nil, true)
            end
        end
    end,

}