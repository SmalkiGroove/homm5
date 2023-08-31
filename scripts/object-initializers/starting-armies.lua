

function ReplaceStartingArmy(hero)
	-- print("Starting army for hero "..hero)
	if STARTING_ARMIES[hero] and STARTING_ARMIES[hero][1] then
		AddHeroCreatures(hero, CREATURE_WOLF, 1, 6) sleep(1)
		local k, units, amounts = GetHeroArmySummary(hero)
		for i = 1,k do
			-- print("Remove hero creature type : "..units[i].." - "..amounts[i])
			RemoveHeroCreatures(hero, units[i], amounts[i])
		end
		for i = 1,7 do
			if STARTING_ARMIES[hero][i] then
				-- print("Add hero creature type "..STARTING_ARMIES[hero][i][1].." - "..STARTING_ARMIES[hero][i][2])
				AddHeroCreatures(hero, STARTING_ARMIES[hero][i][1], STARTING_ARMIES[hero][i][2], i-1)
			end
		end
		sleep(1) RemoveHeroCreatures(hero, CREATURE_WOLF, 1)
	end
end



INIT_T1X = 100
INIT_T1 = 80
INIT_T2X = 50
INIT_T2 = 40
INIT_T3X = 30
INIT_T3 = 20
INIT_T4X = 13
INIT_T4 = 10
INIT_T5X = 7
INIT_T5 = 5
INIT_T6X = 3
INIT_T6 = 2
INIT_T7 = 1

STARTING_ARMIES = {
    -- haven
    [H_DUNCAN] = { {CREATURE_PEASANT,INIT_T1}, {CREATURE_ARCHER,INIT_T2}, {CREATURE_FOOTMAN,INIT_T3} },
    [H_DOUGAL] = { {CREATURE_ARCHER,INIT_T2X}, {CREATURE_ARCHER,INIT_T2X} },
    [H_KLAUS] = { {CREATURE_ARCHER,INIT_T2}, {CREATURE_FOOTMAN,INIT_T3}, {CREATURE_CAVALIER,INIT_T6} },
    [H_IRINA] = { {CREATURE_GRIFFIN,INIT_T4}, {CREATURE_GRIFFIN,INIT_T4} },
    [H_ISABEL] = { {CREATURE_PEASANT,INIT_T1}, {CREATURE_SERAPH,INIT_T7} },
    [H_LASZLO] = { {CREATURE_FOOTMAN,INIT_T3X}, {CREATURE_VINDICATOR,INIT_T3} },
    [H_NICOLAI] = { {CREATURE_ARCHER,INIT_T2}, {CREATURE_FOOTMAN,INIT_T3}, {CREATURE_PRIEST,INIT_T5} },
    [H_GODRIC] = { {CREATURE_PEASANT,INIT_T1}, {CREATURE_ARCHER,INIT_T2}, {CREATURE_FOOTMAN,INIT_T3} },
    [H_FREYDA] = { {CREATURE_PEASANT,INIT_T1}, {CREATURE_ARCHER,INIT_T2}, {CREATURE_FOOTMAN,INIT_T3} },
    [H_RUTGER] = { {CREATURE_PEASANT,INIT_T1}, {CREATURE_PEASANT,INIT_T1}, {CREATURE_CAVALIER,INIT_T6} },
    [H_MAEVE] = { {CREATURE_PEASANT,INIT_T1}, {CREATURE_ARCHER,INIT_T2}, {CREATURE_GRIFFIN,INIT_T4} },
    [H_ELLAINE] = { {CREATURE_PEASANT,INIT_T1}, {CREATURE_PEASANT,INIT_T1}, {CREATURE_PEASANT,INIT_T1} },
    [H_ALARIC] = { {CREATURE_MILITIAMAN,INIT_T1}, {CREATURE_MARKSMAN,INIT_T2} },
    [H_GABRIELLE] = { {CREATURE_SWORDSMAN,INIT_T3}, {CREATURE_ZEALOT,INIT_T5} },
    [H_ORLANDO] = { {CREATURE_PEASANT,INIT_T1X}, {CREATURE_ARCHER,INIT_T2X}, {CREATURE_FOOTMAN,INIT_T3X} },
    [H_MARKAL] = { {CREATURE_PEASANT,INIT_T1}, {CREATURE_ARCHER,INIT_T2}, {CREATURE_FOOTMAN,INIT_T3} },
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
    [H_KASPAR] = { {CREATURE_SKELETON,INIT_T1}, {CREATURE_WALKING_DEAD,INIT_T2}, {CREATURE_MANES,INIT_T3} },
    [H_VLADIMIR] = { {CREATURE_SKELETON,INIT_T1}, {CREATURE_WALKING_DEAD,INIT_T2}, {CREATURE_MANES,INIT_T3} },
    [H_ORSON] = { {CREATURE_WALKING_DEAD,INIT_T2}, {CREATURE_WALKING_DEAD,INIT_T2}, {CREATURE_WALKING_DEAD,INIT_T2} },
    [H_ORNELLA2] = { {CREATURE_SKELETON,INIT_T1}, {CREATURE_WALKING_DEAD,INIT_T2}, {CREATURE_LICH,INIT_T5} },
    [H_LUCRETIA] = { {CREATURE_VAMPIRE,INIT_T4}, {CREATURE_VAMPIRE,INIT_T4} },
    [H_XERXON] = { {CREATURE_SKELETON,INIT_T1}, {CREATURE_MANES,INIT_T3}, {CREATURE_BLACK_KNIGHT,INIT_T7} },
    [H_DEIRDRE] = { {CREATURE_SKELETON,INIT_T1}, {CREATURE_WALKING_DEAD,INIT_T2}, {CREATURE_BANSHEE,INIT_T7} },
    [H_NAADIR] = { {CREATURE_MANES,INIT_T3X}, {CREATURE_MANES,INIT_T3X} },
    [H_AISLINN] = { {CREATURE_SKELETON,INIT_T1}, {CREATURE_WALKING_DEAD,INIT_T2}, {CREATURE_MANES,INIT_T3} },
    [H_GIOVANNI] = { {CREATURE_SKELETON,INIT_T1}, {CREATURE_WALKING_DEAD,INIT_T2}, {CREATURE_MANES,INIT_T3} },
    [H_ARCHILUS] = { {CREATURE_SKELETON,INIT_T1}, {CREATURE_WALKING_DEAD,INIT_T2}, {CREATURE_MANES,INIT_T3} },
    [H_ZOLTAN] = { {CREATURE_GHOST,INIT_T3X}, {CREATURE_LICH_MASTER,INIT_T5X} },
    [H_RAVEN] = { {CREATURE_SKELETON,INIT_T1}, {CREATURE_SKELETON,INIT_T1}, {CREATURE_WALKING_DEAD,INIT_T2} },
    [H_ARANTIR] = { {CREATURE_SKELETON,INIT_T1X}, {CREATURE_WALKING_DEAD,INIT_T2X}, {CREATURE_MANES,INIT_T3X} },
    [H_THANT] = { {CREATURE_MUMMY,INIT_T5}, {CREATURE_MUMMY,INIT_T5}, {CREATURE_MUMMY,INIT_T5} },
    [H_SANDRO] = { {CREATURE_SKELETON,INIT_T1}, {CREATURE_WALKING_DEAD,INIT_T2}, {CREATURE_MANES,INIT_T3}, {CREATURE_VAMPIRE,INIT_T4} },
    [H_VIDOMINA] = { {CREATURE_WALKING_DEAD,INIT_T2X}, {CREATURE_HORROR_DRAGON,INIT_T6} },
    -- inferno
    [H_GRAWL] = { {CREATURE_HELL_HOUND,INIT_T3X}, {CREATURE_HELL_HOUND,INIT_T3X} },
    [H_NEBIROS] = { {CREATURE_FAMILIAR,INIT_T1}, {CREATURE_DEMON,INIT_T2}, {CREATURE_HELL_HOUND,INIT_T3} },
    [H_MARBAS] = { {CREATURE_FAMILIAR,INIT_T1}, {CREATURE_DEMON,INIT_T2}, {CREATURE_HELL_HOUND,INIT_T3} },
    [H_HARKENRAZ] = { {CREATURE_FAMILIAR,INIT_T1}, {CREATURE_FAMILIAR,INIT_T1}, {CREATURE_FAMILIAR,INIT_T1} },
    [H_CALH] = { {CREATURE_FAMILIAR,INIT_T1}, {CREATURE_DEMON,INIT_T2}, {CREATURE_HELL_HOUND,INIT_T3} },
    [H_SHELTEM] = { {CREATURE_FAMILIAR,INIT_T1}, {CREATURE_DEMON,INIT_T2}, {CREATURE_HELL_HOUND,INIT_T3} },
    [H_ALASTOR] = { {CREATURE_FAMILIAR,INIT_T1}, {CREATURE_DEMON,INIT_T2}, {CREATURE_SUCCUBUS,INIT_T4} },
    [H_GROK] = { {CREATURE_FAMILIAR,INIT_T1}, {CREATURE_HELL_HOUND,INIT_T3}, {CREATURE_NIGHTMARE,INIT_T5} },
    [H_NYMUS] = { {CREATURE_FAMILIAR,INIT_T1X}, {CREATURE_DEMON,INIT_T2X}, {CREATURE_HELL_HOUND,INIT_T3X} },
    [H_JEZEBETH] = { {CREATURE_FAMILIAR,INIT_T1}, {CREATURE_FAMILIAR,INIT_T1}, {CREATURE_HELL_HOUND,INIT_T3} },
    [H_MALUSTAR] = { {CREATURE_FAMILIAR,INIT_T1}, {CREATURE_DEMON,INIT_T2}, {CREATURE_HELL_HOUND,INIT_T3} },
    [H_AGRAEL] = { {CREATURE_IMP,INIT_T1}, {CREATURE_HORNED_DEMON,INIT_T2}, {CREATURE_CERBERI,INIT_T3} },
    [H_BIARA] = { {CREATURE_FAMILIAR,INIT_T1}, {CREATURE_HELL_HOUND,INIT_T3}, {CREATURE_SUCCUBUS,INIT_T4} },
    [H_KHABELETH] = { {CREATURE_FAMILIAR,INIT_T1}, {CREATURE_DEMON,INIT_T2}, {CREATURE_HELL_HOUND,INIT_T3} },
    [H_ZYDAR] = { {CREATURE_FAMILIAR,2*INIT_T1}, {CREATURE_DEMON,2*INIT_T2}, {CREATURE_DEVIL,INIT_T7} },
    [H_DELEB] = { {CREATURE_DEMON,INIT_T2}, {CREATURE_DEMON,INIT_T2}, {CREATURE_DEMON,INIT_T2} },
    [H_CALID] = { {CREATURE_FAMILIAR,INIT_T1X}, {CREATURE_DEMON,INIT_T2X} },
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
    [H_TELSEK] = { {CREATURE_ORC_WARRIOR,INIT_T3}, {CREATURE_ORC_WARRIOR,INIT_T3}, {CREATURE_ORC_WARRIOR,INIT_T3} },
    [H_GORSHAK] = { {CREATURE_CENTAUR,INIT_T4}, {CREATURE_CENTAUR,INIT_T4} },
    [H_GOTAI] = { {CREATURE_GOBLIN,INIT_T1}, {CREATURE_SHAMAN,INIT_T2}, {CREATURE_ORC_WARRIOR,INIT_T3} },
    [H_AZAR] = { {CREATURE_GOBLIN,INIT_T1}, {CREATURE_SHAMAN,INIT_T2}, {CREATURE_ORC_WARRIOR,INIT_T3} },
    [H_MATEWA] = { {CREATURE_GOBLIN,INIT_T1X}, {CREATURE_CYCLOP,INIT_T7} },
    [H_KUNYAK] = { {CREATURE_SHAMAN,INIT_T2}, {CREATURE_ORC_WARRIOR,INIT_T3}, {CREATURE_ORCCHIEF_BUTCHER,INIT_T5} },
    [H_KRAGH] = { {CREATURE_GOBLIN,INIT_T1}, {CREATURE_ORC_WARRIOR,INIT_T3}, {CREATURE_CENTAUR,INIT_T4} },
    [H_KILGHAN] = { {CREATURE_GOBLIN,INIT_T1X}, {CREATURE_GOBLIN,INIT_T1X} },
    [H_CRAGHACK] = { {CREATURE_GOBLIN,INIT_T1}, {CREATURE_SHAMAN,INIT_T2}, {CREATURE_ORC_WARRIOR,INIT_T3} },
    [H_KRAAL] = { {CREATURE_GOBLIN,INIT_T1}, {CREATURE_SHAMAN,INIT_T2}, {CREATURE_ORC_WARRIOR,INIT_T3} },
    [H_SHAKKARUKAT] = { {CREATURE_WYVERN_POISONOUS,INIT_T6X} },
    [H_KUJIN] = { {CREATURE_GOBLIN,INIT_T1X}, {CREATURE_SHAMAN,INIT_T2X} },
    [H_SHIVA] = { {CREATURE_SHAMAN,INIT_T2X}, {CREATURE_SHAMAN,INIT_T2X} },
    [H_HAGGASH] = { {CREATURE_GOBLIN,2*INIT_T1}, {CREATURE_SHAMAN,2*INIT_T2}, {CREATURE_ORC_WARRIOR,2*INIT_T3} },
    [H_MUKHA] = { {CREATURE_SHAMAN,INIT_T2X}, {CREATURE_ORC_WARRIOR,INIT_T3} },
    [H_URGHAT] = { {CREATURE_GOBLIN,INIT_T1X}, {CREATURE_SHAMAN,INIT_T2X} },
    [H_GARUNA] = { {CREATURE_GOBLIN,INIT_T1}, {CREATURE_SHAMAN,INIT_T2}, {CREATURE_ORC_WARRIOR,INIT_T3} },
    [H_ZOULEIKA] = { {CREATURE_GOBLIN,INIT_T1}, {CREATURE_SHAMAN,INIT_T2}, {CREATURE_ORC_WARRIOR,INIT_T3} },
    [H_ERIKA] = { {CREATURE_GOBLIN,INIT_T1X}, {CREATURE_SHAMAN,INIT_T2X} },
}


-- print("Loaded starting armies advmap routines")
ROUTINES_LOADED[x_starting_armies] = 1
