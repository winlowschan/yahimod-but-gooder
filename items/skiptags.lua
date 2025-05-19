-- Tag Atlas
SMODS.Atlas{
    key = 'tagatlas',
    path = 'tagatlas.png',
    px = 32,
    py = 32,
}

SMODS.Tag{
    key = 'tag_yahimodrare',
    loc_txt= {
        name = 'RARE YAHIMOD Tag',
        text = { "Immediately grants you a",
                "{C:attention}YAHIMOD Joker{}", }},
    atlas = 'tagatlas',
    pos = { x = 0, y = 0 },
    min_ante = 4,


    apply = function(self, tag, context)
        tag:yep('+', G.C.DARK_EDITION, print() )

            local card = create_card("Yahimodaddition", G.Jokers, nil, nil, nil, nil, nil, 'yahiworld')
            card:add_to_deck()
            G.jokers:emplace(card)
            play_sound("yahimod_mariopaintmeow")

        tag.triggered = true
        return true
    end,
}

SMODS.Tag{
    key = 'tag_yahimodyoutube',
    loc_txt= {
        name = 'VIDEO Tag',
        text = { "Immediately plays an",
                "{C:attention}important video{}", }},
    atlas = 'tagatlas',
    pos = { x = 1, y = 0 },


    apply = function(self, tag, context)
        tag:yep('+', G.C.DARK_EDITION, print() )

           G.FUNCS.overlay_menu{
                definition = create_UIBox_custom_video1("twerknite","Hell Yeah"),
                config = {no_esc = true}
            }

        tag.triggered = true
        return true
    end,
}

SMODS.Tag{
    key = 'tag_yahimodcleanse',
    loc_txt= {
        name = 'Cleanse Tag',
        text = { "Rids your jokers and deck",
                "{C:attention}of all horses{}", }},
    atlas = 'tagatlas',
    pos = { x = 0, y = 1 },
    min_ante = 2,

    apply = function(self, tag, context)
        tag:yep('+', G.C.DARK_EDITION, print() )

        play_sound("yahimod_horsedeath")
            for _, card in ipairs(G.playing_cards) do
                if card.seal == "yahimod_horse_seal" then
                    card.seal = nil
                end
            end
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.name == "j_yahimod_horsewalksin" then
                    G.jokers.cards[i]:start_dissolve()
                    G.jokers.cards[i] = nil
                end
            end

        tag.triggered = true
        return true
    end,
}

SMODS.Tag{
    key = 'tag_yahimodwashee',
    loc_txt= {
        name = 'Washee Washee',
        text = { "Washee Washee", }},
    atlas = 'tagatlas',
    pos = { x = 1, y = 1 },

    apply = function(self, tag, context)
        tag:yep('+', G.C.DARK_EDITION, print() )

        G.washee = 1

        tag.triggered = true
        return true
    end,
}