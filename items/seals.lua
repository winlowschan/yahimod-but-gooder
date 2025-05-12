
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
                card_eval_status_text(card,'extra',nil,nil,nil,{message = "(1) New Message"})
                return true end })),

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
                card_eval_status_text(card,'extra',nil,nil,nil,{message = "Neigh"})
                return true end })),

                mult = self.config.mult,
                chips = self.config.chips,
                dollars = self.config.money,
                x_mult = self.config.x_mult
            }
        end
    end,
}




----------------------------------------------
------------MOD CODE END----------------------
