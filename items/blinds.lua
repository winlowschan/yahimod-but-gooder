SMODS.Atlas {
    key = "yahiblinds",
    path = "blindsatlas.png",
    px = 34,
    py = 34,
    frames = 1,
    atlas_table = 'ANIMATION_ATLAS'
}

SMODS.Blind {
    name = "boss_jimothy",
    key = "boss_jimothy",
    atlas = "yahiblinds",
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
    end,


}

SMODS.Blind {
    name = "boss_vibe",
    key = "boss_vibee",
    atlas = "yahiblinds",
    pos = { y = 2 },
    dollars = 8,
    loc_txt = {
        name = 'VIBE',
        text = {
            'Sets game speed to x0.25',
        }
    },
    boss = {  min = 2 },
    boss_colour = HEX('bc25ec'),

    defeat = function(self)
        G.SETTINGS.GAMESPEED = 4
    end,

    disable = function(self)
        G.SETTINGS.GAMESPEED = 4
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
    G.showfish = 400
    play_sound("yahimod_fish")
    end,

    set_blind= function(self)
        G.showfish = 400
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
                definition = create_UIBox_custom_video1("horsef","Hell Yeah"),
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