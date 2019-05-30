--[[ OP cane -- by tehMugwump
-- You worked for it.  Now enjoy it! Increased walking speed. Chops! Hits like a spear.  Chester keeps up!

--]]
if GLOBAL.IsDLCEnabled(GLOBAL.PORKLAND_DLC) then
    PrefabFiles = {
        "DLC0003/OPcane",
    }
elseif GLOBAL.IsDLCEnabled(GLOBAL.CAPY_DLC) then
    PrefabFiles = {
        "DLC0002/OPcane",
    }
else
    PrefabFiles = {
        "vanilla/OPcane",
    }
end

TUNING.CANE_SPEED_MULT = TUNING.CANE_SPEED_MULT * 1.2 -- was 1.25 and not much an improvement considering the trouble to get.
TUNING.CANE_DAMAGE = TUNING.SPEAR_DAMAGE --equals the Spear


function Opcane_Quicken(inst)
    if inst.components.locomotor then

        inst.components.locomotor.walkspeed = 10
        inst.components.locomotor.runspeed = 15
    end
end

AddPrefabPostInit("chester", Opcane_Quicken)

if GLOBAL.IsDLCEnabled(GLOBAL.CAPY_DLC) then
    AddPrefabPostInit("packim", Opcane_Quicken)

    RECIPETABS = GLOBAL.RECIPETABS
    Recipe = GLOBAL.Recipe
    Ingredient = GLOBAL.Ingredient
    TECH = GLOBAL.TECH

    Recipe("cane", { Ingredient("obsidian", 3), Ingredient("goldnugget", 2), Ingredient("twigs", 4), Ingredient("ox_horn", 1) }, RECIPETABS.DRESS, TECH.OBSIDIAN_TWO)
end