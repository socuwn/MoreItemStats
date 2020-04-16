
local current_name = ""
local contrast = 150

local STATS = {
    "Agility",
    "Intellect",
    "Spirit",
    "Stamina",
    "Strength"
}

-- Stat match helper
function stat_match(stat, str)
    -- generate stat patterns
    local STAT_PATTERNS = {
        "[-+]?(%d+) " .. stat,
        "(%d+) " .. stat,
        "[-+]?(%d+) to all stats",
        stat .. " [-+]?(%d+)",
        stat .. " by (%d+)"
    }
    for i, s in pairs(STATS) do
        STAT_PATTERNS[#STAT_PATTERNS+1] = "(%d+) " .. s .. " and " .. stat
    end

    -- search for match
    for i, pattern in pairs(STAT_PATTERNS) do
        match = string.match(str, pattern)
        if match then
            return match
        end
    end
    return nil
end

-- Clear current item on show
GameTooltip:SetScript("OnShow", 
    function ()
        current_name = ""
    end
)

-- Clear current item on show
GameTooltip:SetScript("OnHide", 
    function ()
        current_name = ""
    end
)
-- Main functionality
GameTooltip:SetScript("OnUpdate", 
    function ()
        local valid = false
        local agility = 0
        local intellect = 0
        local spirit = 0
        local stamina = 0
        local strength = 0
        local _, class_name, _ = UnitClass("player")
        local race_name = UnitRace("player")

        item_name, item_link = GameTooltip:GetItem()
        spell_name, spell_rank = GameTooltip:GetSpell()

        if (item_link and item_name ~= current_name) then
            valid = true
            current_name = item_name
        elseif (spell_name and spell_name ~= current_name) then
            valid = true
            current_name = spell_name
        end

        if valid then
            valid = false
            -- scan tooltip for stats
            for i = 2, GameTooltip:NumLines() do 
                local font_string_left = _G["GameTooltipTextLeft"..i] 
                local font_string_right = _G["GameTooltipTextRight"..i] 
                local text = font_string_left:GetText()

                if stat_match("Agility", text) then
                    agility = agility + stat_match("Agility", text)
                end
                if stat_match("Intellect", text) then
                    intellect = intellect + stat_match("Intellect", text)
                end
                if stat_match("Spirit", text) then
                    spirit = spirit + stat_match("Spirit", text)
                end
                if stat_match("Stamina", text) then
                    stamina = stamina + stat_match("Stamina", text)
                end
                if stat_match("Strength", text) then
                    strength = strength + stat_match("Strength", text)
                end
            end

            if agility ~= 0 then
                r = 218/contrast
                g = 124/contrast
                b = 48/contrast
                -- Armor
                GameTooltip:AddLine("  armor:         +" .. agility*2, r, g, b)

                -- Dodge
                if class_name == "ROGUE" then
                    
                    GameTooltip:AddLine("  dodge:         +" .. string.format("%0.2f", agility/14.5) .. "%", r, g, b)
                elseif class_name == "HUNTER" then
                    GameTooltip:AddLine("  dodge:         +" .. string.format("%0.2f", agility/26) .. "%", r, g, b)
                else 
                    GameTooltip:AddLine("  dodge:         +" .. string.format("%0.2f", agility/20) .. "%", r, g, b)    
                end

                -- Critical Strike
                if class_name == "ROGUE" then
                    GameTooltip:AddLine("  crit:          +" .. string.format("%0.2f", agility/29) .. "%", r, g, b)
                elseif class_name == "HUNTER" then
                    GameTooltip:AddLine("  crit:          +" .. string.format("%0.2f", agility/53) .. "%", r, g, b)
                elseif class_name == "DRUID" 
                or class_name == "PALADIN" 
                or class_name == "SHAMAN" 
                or class_name == "WARRIOR" then
                    GameTooltip:AddLine("  crit:          +" .. string.format("%0.2f", agility/20) .. "%", r, g, b)
                end
                
                -- Ranged Attack Power
                if class_name == "HUNTER" then
                    GameTooltip:AddLine("  ranged AP:     +" .. string.format("%d", agility*2), r, g, b)
                elseif class_name == "ROGUE" or class_name == "WARRIOR" then
                    GameTooltip:AddLine("  ranged AP:     +" .. string.format("%d", agility), r, g, b)
                end

                -- Melee Attack Power
                if class_name == "DRUID" 
                or class_name == "HUNTER" 
                or class_name == "ROGUE" then
                    GameTooltip:AddLine("  melee AP:      +" .. string.format("%d", agility), r, g, b)
                end

            end

            if intellect ~= 0 then
                r = 57/contrast
                g = 106/contrast
                b = 177/contrast
                -- Spell Crit and Mana
                if     class_name == "DRUID" then
                    GameTooltip:AddLine("  mana:          +" .. string.format("%d", intellect*15), r, g, b)
                    GameTooltip:AddLine("  spell crit:    +" .. string.format("%0.2f", intellect/60) .. "%", r, g, b)
                elseif class_name == "MAGE" then
                    GameTooltip:AddLine("  mana:          +" .. string.format("%d", intellect*15), r, g, b)
                    GameTooltip:AddLine("  spell crit:    +" .. string.format("%0.2f", intellect/59.5) .. "%", r, g, b)
                elseif class_name == "PALADIN" then
                    GameTooltip:AddLine("  mana:          +" .. string.format("%d", intellect*15), r, g, b)
                    GameTooltip:AddLine("  spell crit:    +" .. string.format("%0.2f", intellect/54) .. "%", r, g, b)
                elseif class_name == "PRIEST" then
                    GameTooltip:AddLine("  mana:          +" .. string.format("%d", intellect*15), r, g, b)
                    GameTooltip:AddLine("  spell crit:    +" .. string.format("%0.2f", intellect/59.2) .. "%", r, g, b)
                elseif class_name == "SHAMAN" then
                    GameTooltip:AddLine("  mana:          +" .. string.format("%d", intellect*15), r, g, b)
                    GameTooltip:AddLine("  spell crit:    +" .. string.format("%0.2f", intellect/59.5) .. "%", r, g, b)
                elseif class_name == "WARLOCK" then
                    GameTooltip:AddLine("  mana:          +" .. string.format("%d", intellect*15), r, g, b)
                    GameTooltip:AddLine("  spell crit:    +" .. string.format("%0.2f", intellect/60.6) .. "%", r, g, b)
                end
            end

            if spirit ~= 0 then
                r = 107/contrast
                g = 76/contrast
                b = 154/contrast
                -- Mana per 2sec
                if class_name == "DRUID" then
                    GameTooltip:AddLine("  mana/s:        +" .. string.format("%0.2f", (spirit/4.5 + 15)/2), r, g, b)
                elseif class_name == "HUNTER" 
                or class_name == "PALADIN"
                or class_name == "WARLOCK" then
                    GameTooltip:AddLine("  mana/s:        +" .. string.format("%0.2f", (spirit/5 + 15)/2), r, g, b)
                elseif class_name == "MAGE" then
                    GameTooltip:AddLine("  mana/s:        +" .. string.format("%0.2f", (spirit/4 + 15)/2), r, g, b)
                elseif class_name == "SHAMAN" then
                    GameTooltip:AddLine("  mana/s:        +" .. string.format("%0.2f", (spirit/5 + 17)/2), r, g, b)
                end
            end

            if stamina ~= 0 then
                r = 62/contrast
                g = 150/contrast
                b = 81/contrast
                if race_name == "Tauren" then
                    GameTooltip:AddLine("  health:        +" .. string.format("%d", stamina*10.5), r, g, b)
                else
                    GameTooltip:AddLine("  health:        +" .. string.format("%d", stamina*10), r, g, b)
                end
            end

            if strength ~= 0 then
                r = 204/contrast
                g = 37/contrast
                b = 41/contrast
                -- Melee Attack Power
                if class_name == "DRUID" 
                or class_name == "PALADIN" 
                or class_name == "SHAMAN" 
                or class_name == "WARRIOR" then
                    GameTooltip:AddLine("  melee AP:      +" .. string.format("%d", strength*2), r, g, b)
                else 
                    GameTooltip:AddLine("  melee AP:      +" .. string.format("%d", strength), r, g, b)
                end
                -- Block
                if class_name == "PALADIN" 
                or class_name == "SHAMAN" 
                or class_name == "WARRIOR" then
                    GameTooltip:AddLine("  block damage:  +" .. string.format("%0.2f", strength/20), r, g, b)
                end
            end

            -- Call show to resize tooltip frame after adding lines
            GameTooltip:Show()
        end
    end
)
