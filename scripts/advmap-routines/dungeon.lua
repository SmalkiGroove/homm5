
function Routine_AddHeroAttackPairLevel()
    -- Attack - 1 per 2 level
    local hero = H_KYTHRA
    if mod(GetHeroLevel(hero), 2) == 0 then
        AddHero_StatAmount(player, hero, STAT_ATTACK, 1)
    end
end

function Routine_AddHeroSpellPowerPairLevel()
    -- Spellpower - 1 per 2 level
    local hero = H_SINITAR
    if mod(GetHeroLevel(hero), 2) == 0 then
        AddHero_StatAmount(player, hero, STAT_SPELL_POWER, 1)
    end
end

function Routine_AddHeroLevel()
    -- Level up every 5 levels
    local hero = H_SHADYA
    if mod(GetHeroLevel(hero), 5) == 0 then
        LevelUpHero(hero)
    end
end

function Routine_GainDragonArtifacts()
    -- Dragon artfacts set
    local hero = H_RAELAG
    if GetHeroLevel(hero) == 40 then
        GiveArtifact(hero, ARTIFACT_DRAGON_SCALE_ARMOR)
        GiveArtifact(hero, ARTIFACT_DRAGON_SCALE_SHIELD)
        GiveArtifact(hero, ARTIFACT_DRAGON_BONE_GRAVES)
        GiveArtifact(hero, ARTIFACT_DRAGON_WING_MANTLE)
        GiveArtifact(hero, ARTIFACT_DRAGON_TEETH_NECKLACE)
        GiveArtifact(hero, ARTIFACT_DRAGON_TALON_CROWN)
        GiveArtifact(hero, ARTIFACT_DRAGON_EYE_RING)
        GiveArtifact(hero, ARTIFACT_DRAGON_FLAME_TONGUE)
    end
end

function Routine_AddHeroRiders(player, hero)
    -- Riders - 1:4 - 2:10 - 3:17 - 4:24 - 5:30 ... 8:50
    AddHero_CreatureInTypes(player, hero, {CREATURE_RIDER,CREATURE_RAVAGER,CREATURE_BLACK_RIDER}, 0.15)
end

function Routine_GenerateGoldPerScout(player, hero)
    -- Gold - 1 per scout per 5 levels
    local mult = trunc(GetHeroLevel(hero) * 0.2)
    local army = GetHeroArmy(hero)
    local amount = 0
    for i = 1,7 do
        local cr = army[i]
        if cr and (cr == CREATURE_SCOUT or cr == CREATURE_ASSASSIN or cr == CREATURE_STALKER) then
            amount = amount + GetHeroCreatures(hero, cr)
        end
    end
    AddPlayer_Resource(player, hero, GOLD, amount * mult)
end

function Routine_AddHeroManticores(player, hero)
    -- Manticore - 1:4 - 2:12 - 3:20 - 4:27 ... 7:50
    AddHero_CreatureType(player, hero, CREATURE_MANTICORE, 0.13)
end

function Routine_ConvertOverflowManaToExp(player, hero)
    -- Mana excess to exp - excess * level * 10
    local cur_mana = GetHeroStat(hero, STAT_MANA_POINTS)
    local max_mana = 10 * GetHeroStat(hero, STAT_KNOWLEDGE)
    if HasHeroSkill(hero, PERK_INTELLIGENCE) then max_mana = round(1.5 * max_mana) end
    local diff = cur_mana - max_mana
    if diff > 0 then
        local amount = diff * GetHeroLevel(hero) * 10
        for i,h in GetPlayerHeroes(player) do
            AddHero_StatAmount(player, h, STAT_EXPERIENCE, amount)
        end
        ChangeHeroStat(hero, STAT_MANA_POINTS, -diff)
    end
end

function Routine_HeroCallMinotaurs(player, hero)
    -- Minotaurs - 2 * level transfered
    AddHero_CreatureFromDwelling(player, hero, TOWN_BUILDING_DWELLING_3, CREATURE_MINOTAUR_KING, 2.0)
end

function Routine_AddRecruitsMatrons(player, hero)
    -- Matrons - 0.33 * level recruits per week
    AddHero_TownRecruits(player, hero, TOWN_BUILDING_DWELLING_5, CREATURE_MATRON, 0.33)
end

function Routine_UpgradeToWitches(player, hero)
    -- Upgrade scouts recruits to blood witches and riders recruits to shadow witches
    local max_bloodwitch = GetHeroLevel(hero) * 2
    ChangeHero_TownRecruits(player, hero, TOWN_BUILDING_DWELLING_1, CREATURE_SCOUT, TOWN_BUILDING_DWELLING_2, CREATURE_WITCH, max_bloodwitch)
    local max_shadowwitch = trunc(GetHeroLevel(hero) * 0.5)
    ChangeHero_TownRecruits(player, hero, TOWN_BUILDING_DWELLING_4, CREATURE_RIDER, TOWN_BUILDING_DWELLING_5, CREATURE_MATRON, max_shadowwitch)
end


-----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------


LEVEL_UP_DUNGEON_HERO = {
    [H_SORGAL] = "NoneRoutine",
    [H_KYTHRA] = "Routine_AddHeroAttackPairLevel",
    [H_AGBETH] = "NoneRoutine",
    [H_RANLETH] = "NoneRoutine",
    [H_DARKSTORM] = "NoneRoutine",
    [H_YRWANNA] = "NoneRoutine",
    [H_VAYSHAN] = "NoneRoutine",
    [H_THRALSAI] = "NoneRoutine",
    [H_LETHOS] = "NoneRoutine",
    [H_ERUINA] = "NoneRoutine",
    [H_YRBETH] = "NoneRoutine",
    [H_SYLSAI] = "NoneRoutine",
    [H_SINITAR] = "Routine_AddHeroSpellPowerPairLevel",
    [H_SHADYA] = "Routine_AddHeroLevel",
    [H_RAELAG] = "Routine_GainDragonArtifacts",
    [H_YLAYA] = "NoneRoutine",
    [H_SEPHINROTH] = "NoneRoutine",
    [H_KASTORE] = "NoneRoutine",
}

LEARN_SKILL_DUNGEON_HERO = {
    [H_SORGAL] = "NoneRoutine",
    [H_KYTHRA] = "NoneRoutine",
    [H_AGBETH] = "NoneRoutine",
    [H_RANLETH] = "NoneRoutine",
    [H_DARKSTORM] = "NoneRoutine",
    [H_YRWANNA] = "NoneRoutine",
    [H_VAYSHAN] = "NoneRoutine",
    [H_THRALSAI] = "NoneRoutine",
    [H_LETHOS] = "NoneRoutine",
    [H_ERUINA] = "NoneRoutine",
    [H_YRBETH] = "NoneRoutine",
    [H_SYLSAI] = "NoneRoutine",
    [H_SINITAR] = "NoneRoutine",
    [H_SHADYA] = "NoneRoutine",
    [H_RAELAG] = "NoneRoutine",
    [H_YLAYA] = "NoneRoutine",
    [H_SEPHINROTH] = "NoneRoutine",
    [H_KASTORE] = "NoneRoutine",
}

START_TRIGGER_DUNGEON = {
    [H_SORGAL] = NoneRoutine,
    [H_KYTHRA] = NoneRoutine,
    [H_AGBETH] = NoneRoutine,
    [H_RANLETH] = NoneRoutine,
    [H_DARKSTORM] = NoneRoutine,
    [H_YRWANNA] = NoneRoutine,
    [H_VAYSHAN] = NoneRoutine,
    [H_THRALSAI] = NoneRoutine,
    [H_LETHOS] = NoneRoutine,
    [H_ERUINA] = NoneRoutine,
    [H_YRBETH] = NoneRoutine,
    [H_SYLSAI] = NoneRoutine,
    [H_SINITAR] = NoneRoutine,
    [H_SHADYA] = NoneRoutine,
    [H_RAELAG] = NoneRoutine,
    [H_YLAYA] = NoneRoutine,
    [H_SEPHINROTH] = NoneRoutine,
    [H_KASTORE] = NoneRoutine,
}

DAILY_TRIGGER_DUNGEON = {
    [H_SORGAL] = Routine_AddHeroRiders,
    [H_KYTHRA] = NoneRoutine,
    [H_AGBETH] = NoneRoutine,
    [H_RANLETH] = NoneRoutine,
    [H_DARKSTORM] = NoneRoutine,
    [H_YRWANNA] = NoneRoutine,
    [H_VAYSHAN] = Routine_GenerateGoldPerScout,
    [H_THRALSAI] = NoneRoutine,
    [H_LETHOS] = Routine_AddHeroManticores,
    [H_ERUINA] = NoneRoutine,
    [H_YRBETH] = NoneRoutine,
    [H_SYLSAI] = NoneRoutine,
    [H_SINITAR] = NoneRoutine,
    [H_SHADYA] = NoneRoutine,
    [H_RAELAG] = NoneRoutine,
    [H_YLAYA] = NoneRoutine,
    [H_SEPHINROTH] = Routine_ConvertOverflowManaToExp,
    [H_KASTORE] = NoneRoutine,
}

WEEKLY_TRIGGER_DUNGEON = {
    [H_SORGAL] = NoneRoutine,
    [H_KYTHRA] = NoneRoutine,
    [H_AGBETH] = NoneRoutine,
    [H_RANLETH] = NoneRoutine,
    [H_DARKSTORM] = Routine_HeroCallMinotaurs,
    [H_YRWANNA] = NoneRoutine,
    [H_VAYSHAN] = NoneRoutine,
    [H_THRALSAI] = NoneRoutine,
    [H_LETHOS] = NoneRoutine,
    [H_ERUINA] = Routine_AddRecruitsMatrons,
    [H_YRBETH] = NoneRoutine,
    [H_SYLSAI] = NoneRoutine,
    [H_SINITAR] = NoneRoutine,
    [H_SHADYA] = Routine_UpgradeToWitches,
    [H_RAELAG] = NoneRoutine,
    [H_YLAYA] = NoneRoutine,
    [H_SEPHINROTH] = NoneRoutine,
    [H_KASTORE] = NoneRoutine,
}


function DoDungeonRoutine_Start(player, hero)
    startThread(START_TRIGGER_DUNGEON[hero], player, hero)
end

function DoDungeonRoutine_Daily(player, hero)
    startThread(DAILY_TRIGGER_DUNGEON[hero], player, hero)
end

function DoDungeonRoutine_Weekly(player, hero)
    startThread(WEEKLY_TRIGGER_DUNGEON[hero], player, hero)
end

function DoDungeonRoutine_LevelUp(hero)
    Trigger(HERO_LEVELUP_TRIGGER, hero, LEVEL_UP_DUNGEON_HERO[hero])
    -- Trigger(HERO_ADD_SKILL_TRIGGER, hero, LEARN_SKILL_DUNGEON_HERO[hero])
end


-- print("Loaded Dungeon advmap routines")
ROUTINES_LOADED[DUNGEON] = 1
