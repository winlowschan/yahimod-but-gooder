
SMODS.Sound({key = "whatsapp", path = "whatsapp.ogg",})

SMODS.Atlas {
    key = "whatsapp_seal",
    path = "whatsappseal.png",
    px = 71,
    py = 96
}

SMODS.Seal {
    name = "whatsapp_seal",
    key = "whatsapp_seal",
    badge_colour = HEX("00FF00"),
	config = { mult = 1, chips = 10, money = 1, x_mult = 1.1  },
    loc_txt = {
        -- Badge name (displayed on card description when seal is applied)
        label = 'Whatsapp Seal',
        -- Tooltip description
        name = 'Whatsapp Seal',
        text = {
            '{C:mult}+#1#{} Mult',
            '{C:chips}+#2#{} Chips',
            '{C:money}+$#3#{}',
            '{X:mult,C:white}X#4#{} Mult',
        }
    },


    sound = { sound = 'yahimod_whatsapp', per = 1, vol = 0.4 },

    loc_vars = function(self, info_queue)
        return { vars = {self.config.mult, self.config.chips, self.config.money, self.config.x_mult, } }
    end,
    atlas = "whatsapp_seal",
    pos = {x=0, y=0},

    -- self - this seal prototype
    -- card - card this seal is applied to
    calculate = function(self, card, context)
        -- main_scoring context is used whenever the card is scored
        
        if context.main_scoring and context.cardarea == G.play then
            return {
                G.E_MANAGER:add_event(Event({func = function()
                play_sound('yahimod_whatsapp')
                return true end })),
                
                message = "(1) New Message",
                mult = self.config.mult,
                chips = self.config.chips,
                dollars = self.config.money,
                x_mult = self.config.x_mult
            }
        end
    end,
}

SMODS.Atlas {
    key = "horse_seal",
    path = "horseseal.png",
    px = 71,
    py = 96
}

SMODS.Seal {
    name = "horse_seal",
    key = "horse_seal",
    badge_colour = HEX("795223"),
	config = { mult = -1, chips = -5, money = -1, x_mult = 0.9  },
    loc_txt = {
        -- Badge name (displayed on card description when seal is applied)
        label = 'Horse Seal',
        -- Tooltip description
        name = 'Horse Seal',
        text = {
            '{C:mult}#1#{} Mult',
            '{C:chips}#2#{} Chips',
            '{C:money}$#3#{}',
            '{X:mult,C:white}X#4#{} Mult',
        }
    },


    sound = { sound = 'yahimod_horse', per = 1.6, vol = 0.4 },

    loc_vars = function(self, info_queue)
        return { vars = {self.config.mult, self.config.chips, self.config.money, self.config.x_mult, } }
    end,
    atlas = "horse_seal",
    pos = {x=0, y=0},

    -- self - this seal prototype
    -- card - card this seal is applied to
    calculate = function(self, card, context)
        -- main_scoring context is used whenever the card is scored
        
        if context.main_scoring and context.cardarea == G.play then
            return {
                G.E_MANAGER:add_event(Event({func = function()
                play_sound('yahimod_horse')
                
                return true end })),

                message = "Neigh.",
                mult = self.config.mult,
                chips = self.config.chips,
                dollars = self.config.money,
                x_mult = self.config.x_mult
            }
        end
    end,
}

SMODS.Atlas {
    key = "bfdi_seal",
    path = "bfdiseal.png",
    px = 71,
    py = 96
}

SMODS.Seal {
    name = "bfdi_seal",
    key = "bfdi_seal",
    badge_colour = HEX("1fb0ab"),
	config = { },
    loc_txt = {
        -- Badge name (displayed on card description when seal is applied)
        label = 'BFDI Mouth',
        -- Tooltip description
        name = 'BFDI Mouth',
        text = {
            'Does nothing'
        }
    },

    loc_vars = function(self, info_queue)
        return { vars = {self.config.mult, self.config.chips, self.config.money, self.config.x_mult, } }
    end,
    atlas = "bfdi_seal",
    pos = {x=0, y=0},

}

SMODS.Atlas {
    key = "ifunny_seal",
    path = "ifunnyseal.png",
    px = 71,
    py = 96
}

SMODS.Seal {
    name = "ifunny_seal",
    key = "ifunny_seal",
    badge_colour = HEX("202020"),
	config = { },
    loc_txt = {
        -- Badge name (displayed on card description when seal is applied)
        label = 'iFunny watermark',
        -- Tooltip description
        name = 'iFunny watermark',
        text = {
            'Retriggers once',
            '{C:green}1 in 3{} chance to',
            'crop watermark out',
        }
    },

    loc_vars = function(self, info_queue)
        return { vars = {self.config.mult, self.config.chips, self.config.money, self.config.x_mult, } }
    end,
    atlas = "ifunny_seal",
    pos = {x=0, y=0},

    calculate = function(self, card, context)
        
        if context.cardarea == G.play and context.repetition then
            return {

                repetitions = 1,
                G.E_MANAGER:add_event(Event({func = function()
                if math.random(1,3) == 1 then 
                    card.seal = nil 
                    card_eval_status_text(card,'extra',nil,nil,nil,{message = "Cropped!"})
                    play_sound("cardFan2")
                end
                return true end })),
                
            }
        end
    end,

}

SMODS.Atlas {
    key = "swapper_seal",
    path = "swapperseal.png",
    px = 71,
    py = 96
}

SMODS.Seal {
    name = "swapper_seal",
    key = "swapper_seal",
    badge_colour = HEX("a544ff"),
	config = { },
    loc_txt = {
        -- Badge name (displayed on card description when seal is applied)
        label = 'Swapper Seal',
        -- Tooltip description
        name = 'Swapper Seal',
        text = {
            'When this card is scored,',
            'Swaps {C:blue}chips{} and {C:red}mult{}',
        }
    },

    atlas = "swapper_seal",
    pos = {x=0, y=0},

    calculate = function(self, card, context)
        
        if context.main_scoring and context.cardarea == G.play then

            local old_mult = mult 
            local old_chips = hand_chips
            mult = mod_mult(hand_chips)
            hand_chips = mod_chips(old_mult)

            return {
                message = "Swapped!"
            }
        end
    end,

}

----------------------------------------------
------------MOD CODE END----------------------
