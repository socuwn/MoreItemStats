
local current_item_name = ""
local contrast = 150

GameTooltip:SetScript("OnUpdate", 
    function ()
        name, link = GameTooltip:GetItem()
        local agility = 0
        local intellect = 0
        local spirit = 0
        local stamina = 0
        local strength = 0
        local _, class_name, _ = UnitClass("player")
        local race_name = UnitRace("player");
        if name and name ~= current_item_name then
            current_item_name = name
            
            -- scan tooltip for stats
            for i=1, GameTooltip:NumLines() do 
                local font_string_left = _G["GameTooltipTextLeft"..i] 
                local font_string_right = _G["GameTooltipTextRight"..i] 
                local text = font_string_left:GetText()
                if     string.find(text, "Agility") then
                    agility = string.match(text, "%d+")
                elseif string.find(text, "Intellect") then
                    intellect = string.match(text, "%d+")
                elseif string.find(text, "Spirit") then
                    spirit = string.match(text, "%d+")
                elseif string.find(text, "Stamina") then
                    stamina = string.match(text, "%d+")
                elseif string.find(text, "Strength") then
                    strength = string.match(text, "%d+")
                end
            end

            --GameTooltip:AddLine("RATED", 0.7, 0.7, 0.7)
            if agility ~= 0 then
                r = 218/contrast
                g = 124/contrast
                b = 48/contrast
                -- Armor
                GameTooltip:AddLine("  armor: +" .. agility*2, r, g, b)

                -- Dodge
                if class_name == "ROGUE" then
                    GameTooltip:AddLine("  dodge: +" .. agility/14.5 .. "%", r, g, b)
                elseif class_name == "HUNTER" then
                    GameTooltip:AddLine("  dodge: +" .. agility/26 .. "%", r, g, b)
                else 
                    GameTooltip:AddLine("  dodge: +" .. agility/20 .. "%", r, g, b)    
                end

                -- Critical Strike
                if class_name == "ROGUE" then
                    GameTooltip:AddLine("  crit: +" .. agility/29 .. "%", r, g, b)
                elseif class_name == "HUNTER" then
                    GameTooltip:AddLine("  crit: +" .. agility/53 .. "%", r, g, b)
                elseif class_name == "DRUID" 
                or class_name == "PALADIN" 
                or class_name == "SHAMAN" 
                or class_name == "WARRIOR" then
                    GameTooltip:AddLine("  crit: +" .. agility/20 .. "%", r, g, b)
                end
                
                -- Ranged Attack Power
                if class_name == "HUNTER" then
                    GameTooltip:AddLine("  ranged AP: +" .. agility*2, r, g, b)
                elseif class_name == "ROGUE" or class_name == "WARRIOR" then
                    GameTooltip:AddLine("  ranged AP: +" .. agility, r, g, b)
                end

                -- Melee Attack Power
                if class_name == "DRUID" 
                or class_name == "HUNTER" 
                or class_name == "ROGUE" then
                    GameTooltip:AddLine("  melee AP: +" .. agility, r, g, b)
                end

            end

            if intellect ~= 0 then
                r = 57/contrast
                g = 106/contrast
                b = 177/contrast
                -- Spell Crit and Mana
                if     class_name == "DRUID" then
                    GameTooltip:AddLine("  mana: +" .. intellect*15, r, g, b)
                    GameTooltip:AddLine("  spell crit: +" .. intellect/60, r, g, b)
                elseif class_name == "MAGE" then
                    GameTooltip:AddLine("  mana: +" .. intellect*15, r, g, b)
                    GameTooltip:AddLine("  spell crit: +" .. intellect/59.5, r, g, b)
                elseif class_name == "PALADIN" then
                    GameTooltip:AddLine("  mana: +" .. intellect*15, r, g, b)
                    GameTooltip:AddLine("  spell crit: +" .. intellect/54, r, g, b)
                elseif class_name == "PRIEST" then
                    GameTooltip:AddLine("  mana: +" .. intellect*15, r, g, b)
                    GameTooltip:AddLine("  spell crit: +" .. intellect/59.2, r, g, b)
                elseif class_name == "SHAMAN" then
                    GameTooltip:AddLine("  mana: +" .. intellect*15, r, g, b)
                    GameTooltip:AddLine("  spell crit: +" .. intellect/59.5, r, g, b)
                elseif class_name == "WARLOCK" then
                    GameTooltip:AddLine("  mana: +" .. intellect*15, r, g, b)
                    GameTooltip:AddLine("  spell crit: +" .. intellect/60.6, r, g, b)
                end
            end

            if spirit ~= 0 then
                r = 107/contrast
                g = 76/contrast
                b = 154/contrast
                -- Mana per 2sec
                if class_name == "DRUID" then
                    GameTooltip:AddLine("  mana/2s: +" .. spirit/4.5 + 15, r, g, b)
                elseif class_name == "HUNTER" 
                or class_name == "PALADIN"
                or class_name == "WARLOCK" then
                    GameTooltip:AddLine("  mana/2s: +" .. spirit/5 + 15, r, g, b)
                elseif class_name == "MAGE" then
                    GameTooltip:AddLine("  mana/2s: +" .. spirit/4 + 15, r, g, b)
                elseif class_name == "SHAMAN" then
                    GameTooltip:AddLine("  mana/2s: +" .. spirit/5 + 17, r, g, b)
                end
            end

            if stamina ~= 0 then
                r = 62/contrast
                g = 150/contrast
                b = 81/contrast
                if race_name == "Tauren" then
                    GameTooltip:AddLine("  health: +" .. stamina*10.5, r, g, b)
                else
                    GameTooltip:AddLine("  health: +" .. stamina*10, r, g, b)
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
                    GameTooltip:AddLine("  melee AP: +" .. strength*2, r, g, b)
                else 
                    GameTooltip:AddLine("  melee AP: +" .. strength, r, g, b)
                end
                -- Block
                if class_name == "PALADIN" 
                or class_name == "SHAMAN" 
                or class_name == "WARRIOR" then
                    GameTooltip:AddLine("  block: +" .. strength/20, r, g, b)
                end
            end

            GameTooltip:Show()
        end
        current_item_name = name
    end
)
