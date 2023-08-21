
ARTIFACT_SETS = {
    [ARTIFACT_SET_HAVEN] = {ARTIFACT_NECKLACE_OF_BRAVERY,ARTIFACT_CROWN_OF_COURAGE,ARTIFACT_LION_HIDE_CAPE},
    [ARTIFACT_SET_SYLVAN] = {ARTIFACT_UNICORN_HORN_BOW,ARTIFACT_TREEBORN_QUIVER},
    [ARTIFACT_SET_ACADEMY] = {ARTIFACT_ROBE_OF_MAGI,ARTIFACT_STAFF_OF_MAGI,ARTIFACT_CROWN_OF_MAGI,ARTIFACT_RING_OF_MAGI},
    [ARTIFACT_SET_DWARVEN] = {ARTIFACT_DWARVEN_MITHRAL_CUIRASS,ARTIFACT_DWARVEN_MITHRAL_GREAVES,ARTIFACT_DWARVEN_MITHRAL_HELMET,ARTIFACT_DWARVEN_MITHRAL_SHIELD},
    [ARTIFACT_SET_NECRO] = {ARTIFACT_SHAWL_OF_GREAT_LICH,ARTIFACT_RING_OF_DEATH,ARTIFACT_NECROMANCER_PENDANT},
    [ARTIFACT_SET_INFERNO] = {},
    [ARTIFACT_SET_DUNGEON] = {ARTIFACT_RUNIC_WAR_AXE,ARTIFACT_RUNIC_WAR_HARNESS},
    [ARTIFACT_SET_ORCS] = {ARTIFACT_OGRE_CLUB,ARTIFACT_OGRE_SHIELD},
    [ARTIFACT_SET_DRAGON]= {ARTIFACT_DRAGON_SCALE_ARMOR,ARTIFACT_DRAGON_SCALE_SHIELD,ARTIFACT_DRAGON_BONE_GRAVES,ARTIFACT_DRAGON_WING_MANTLE,ARTIFACT_DRAGON_TEETH_NECKLACE,ARTIFACT_DRAGON_TALON_CROWN,ARTIFACT_DRAGON_EYE_RING,ARTIFACT_DRAGON_FLAME_TONGUE},
    [ARTIFACT_SET_ENLIGHTEN] = {ARTIFACT_HELM_OF_ENLIGHTMENT,ARTIFACT_CHAIN_MAIL_OF_ENLIGHTMENT},
}

ARTIFACT_SETS_ACTIVATIONS = {
    [ARTIFACT_SET_HAVEN] = {[2]=ARTFSET_HAVEN_2PC, [4]=ARTFSET_HAVEN_4PC, [6]=ARTFSET_HAVEN_6PC, [8]=ARTFSET_HAVEN_8PC},
    [ARTIFACT_SET_SYLVAN] = {[2]=ARTFSET_SYLVAN_2PC, [4]=ARTFSET_SYLVAN_4PC, [6]=ARTFSET_SYLVAN_6PC, [8]=ARTFSET_SYLVAN_8PC},
    [ARTIFACT_SET_ACADEMY] = {[2]=ARTFSET_ACADEMY_2PC, [4]=ARTFSET_ACADEMY_4PC, [6]=ARTFSET_ACADEMY_6PC, [8]=ARTFSET_ACADEMY_8PC},
    [ARTIFACT_SET_DWARVEN] = {[2]=ARTFSET_DWARVEN_2PC, [4]=ARTFSET_DWARVEN_4PC, [6]=ARTFSET_DWARVEN_6PC, [8]=ARTFSET_DWARVEN_8PC},
    [ARTIFACT_SET_NECRO] = {[2]=ARTFSET_NECRO_2PC, [4]=ARTFSET_NECRO_4PC, [6]=ARTFSET_NECRO_6PC, [8]=ARTFSET_NECRO_8PC},
    [ARTIFACT_SET_INFERNO] = {[2]=ARTFSET_INFERNO_2PC, [4]=ARTFSET_INFERNO_4PC, [6]=ARTFSET_INFERNO_6PC, [8]=ARTFSET_INFERNO_8PC},
    [ARTIFACT_SET_DUNGEON] = {[2]=ARTFSET_DUNGEON_2PC, [4]=ARTFSET_DUNGEON_4PC, [6]=ARTFSET_DUNGEON_6PC, [8]=ARTFSET_DUNGEON_8PC},
    [ARTIFACT_SET_ORCS] = {[2]=ARTFSET_ORCS_2PC, [4]=ARTFSET_ORCS_4PC, [6]=ARTFSET_ORCS_6PC, [8]=ARTFSET_ORCS_8PC},
    [ARTIFACT_SET_DRAGON]= {[2]=ARTFSET_DRAGON_2PC, [4]=ARTFSET_DRAGON_4PC, [6]=ARTFSET_DRAGON_6PC, [8]=ARTFSET_DRAGON_8PC},
    [ARTIFACT_SET_ENLIGHTEN] = {[2]=ARTFSET_ENLIGHTEN_2PC, [4]=ARTFSET_ENLIGHTEN_4PC},
}

DAILY_ARTIFACT_ROUTINES = {}
WEEKLY_ARTIFACT_ROUTINES = {}
AFTERCOMBAT_ARTIFACT_ROUTINES = {}
LEVELUP_ARTIFACT_ROUTINES = {}


function ScanHeroArtifacts(hero)
    for i = 1,10 do
        local pieces = 0
        for _,artifact in ARTIFACT_SETS[i] do
            if HasArtifact(hero, artifact, 1) then
                pieces = pieces + 1
            end
        end
        SetHeroActiveSet(hero, pieces, ARTIFACT_SETS_ACTIVATIONS[i])
    end
end

function SetHeroActiveSet(hero, pieces, sets)
    local artfset = 0
    for n,v in sets do
        if pieces >= n then artfset = v end
    end
    if artfset ~= 0 then insert(HERO_ACTIVE_ARTIFACT_SETS[hero], artfset) end
end



HERO_ACTIVE_ARTIFACT_SETS = {
    -- haven
    [H_DUNCAN] = {},
    [H_DOUGAL] = {},
    [H_KLAUS] = {},
    [H_IRINA] = {},
    [H_ISABEL] = {},
    [H_LASZLO] = {},
    [H_NICOLAI] = {},
    [H_GODRIC] = {},
    [H_FREYDA] = {},
    [H_RUTGER] = {},
    [H_MAEVE] = {},
    [H_ELLAINE] = {},
    [H_ALARIC] = {},
    [H_GABRIELLE] = {},
    [H_ORLANDO] = {},
    [H_MARKAL] = {},
    -- preserve
    [H_WYNGAAL] = {},
    [H_ANWEN] = {},
    [H_TALANAR] = {},
    [H_OSSIR] = {},
    [H_FINDAN] = {},
    [H_JENOVA] = {},
    [H_GILRAEN] = {},
    [H_KYRRE] = {},
    [H_IVOR] = {},
    [H_MEPHALA] = {},
    [H_ALARON] = {},
    [H_DIRAEL] = {},
    [H_VINRAEL] = {},
    [H_YLTHIN] = {},
    [H_TIERU] = {},
    [H_GEM] = {},
    [H_ELLESHAR] = {},
    -- academy
    [H_HAVEZ] = {},
    [H_MINASLI] = {},
    [H_JOSEPHINE] = {},
    [H_RAZZAK] = {},
    [H_DAVIUS] = {},
    [H_RISSA] = {},
    [H_GURVILIN] = {},
    [H_JHORA] = {},
    [H_CYRUS] = {},
    [H_FAIZ] = {},
    [H_MAAHIR] = {},
    [H_NATHIR] = {},
    [H_NUR] = {},
    [H_GALIB] = {},
    [H_ZEHIR] = {},
    [H_THEODORUS] = {},
    [H_EMILIA] = {},
    -- fortress
    [H_INGVAR] = {},
    [H_ROLF] = {},
    [H_WULFSTAN] = {},
    [H_TAZAR] = {},
    [H_MAXIMUS] = {},
    [H_KARLI] = {},
    [H_HEDWIG] = {},
    [H_TOLGHAR] = {},
    [H_EBBA] = {},
    [H_ULAND] = {},
    [H_HAEGEIR] = {},
    [H_HELMAR] = {},
    [H_BRAND] = {},
    [H_ERLING] = {},
    [H_HANGVUL] = {},
    [H_BART] = {},
    [H_INGA] = {},
    -- necropolis
    [H_KASPAR] = {},
    [H_VLADIMIR] = {},
    [H_ORSON] = {},
    [H_ORNELLA2] = {},
    [H_LUCRETIA] = {},
    [H_XERXON] = {},
    [H_DEIRDRE] = {},
    [H_NAADIR] = {},
    [H_AISLINN] = {},
    [H_GIOVANNI] = {},
    [H_ARCHILUS] = {},
    [H_ZOLTAN] = {},
    [H_RAVEN] = {},
    [H_ARANTIR] = {},
    [H_THANT] = {},
    [H_SANDRO] = {},
    [H_VIDOMINA] = {},
    -- inferno
    [H_GRAWL] = {},
    [H_NEBIROS] = {},
    [H_MARBAS] = {},
    [H_HARKENRAZ] = {},
    [H_CALH] = {},
    [H_SHELTEM] = {},
    [H_ALASTOR] = {},
    [H_GROK] = {},
    [H_NYMUS] = {},
    [H_JEZEBETH] = {},
    [H_MALUSTAR] = {},
    [H_AGRAEL] = {},
    [H_BIARA] = {},
    [H_KHABELETH] = {},
    [H_ZYDAR] = {},
    [H_DELEB] = {},
    [H_CALID] = {},
    -- dungeon
    [H_SORGAL] = {},
    [H_KYTHRA] = {},
    [H_AGBETH] = {},
    [H_RANLETH] = {},
    [H_DARKSTORM] = {},
    [H_YRWANNA] = {},
    [H_VAYSHAN] = {},
    [H_THRALSAI] = {},
    [H_LETHOS] = {},
    [H_ERUINA] = {},
    [H_SYLSAI] = {},
    [H_SINITAR] = {},
    [H_SHADYA] = {},
    [H_RAELAG] = {},
    [H_YLAYA] = {},
    [H_SEPHINROTH] = {},
    [H_KASTORE] = {},
    -- stronghold
    [H_TELSEK] = {},
    [H_GORSHAK] = {},
    [H_GOTAI] = {},
    [H_AZAR] = {},
    [H_MATEWA] = {},
    [H_KUNYAK] = {},
    [H_KRAGH] = {},
    [H_KILGHAN] = {},
    [H_CRAGHACK] = {},
    [H_KRAAL] = {},
    [H_SHAKKARUKAT] = {},
    [H_KUJIN] = {},
    [H_SHIVA] = {},
    [H_HAGGASH] = {},
    [H_MUKHA] = {},
    [H_URGHAT] = {},
    [H_GARUNA] = {},
    [H_ZOULEIKA] = {},
    [H_ERIKA] = {},
}


-- print("Loaded artifact advmap routines")
ROUTINES_LOADED[12] = 1
