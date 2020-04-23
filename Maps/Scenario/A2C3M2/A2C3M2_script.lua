-------------------------------------------------------------------
----------------- TITLE -------------------------------------------
-------------------------------------------------------------------
--       Creation Date: 23.10.06
--              Author: Ivan Myakishev
--       Author e-mail: Ivan.Myakishev@nival.com
--        Project Name: H5A2
--            Map Name: A2C3M2
--  Script Description: MapScript
 --------------------------------------------------------------------
 --------------------------------------------------------------------


--------------------------------------------------------------------
----------------- CONSTANTS ----------------------------------------
--------------------------------------------------------------------

-- ��������� ��� ���� ������
OUR_HERO_ZEHIR = "Zehir";
OUR_HERO_DUNCAN = "Duncan";
OUR_HERO_FREYDA = "Freyda";
INITIAL_COMBAT_ENEMY_HERO = "RedHeavenHero02";

ZEHIRTOWN_ENTRANCE_X = 130;
ZEHIRTOWN_ENTRANCE_Y = 42;

DEPLOYED_ENEMY_INFERNO_HERO = "Grok";


ADVMAPSCENE_START_COMBAT = 0;
ADVMAPSCENE_FIRST_CLERIC_JOINED = 2;


--EASY Devils 20,      HEROIC Devils 30 
--     Balors 35,             Balors 51
--  Nightmare 50,		   Nightmare 70
--    Cerberi 120,            Cerberi 220
--     Demons 250,             Demons 380
--   Succubus 100,           Succubus 130 
--   Familiar 500,           Familiar 500 

BOSSFIGHT_DEVILS_N = 1+5*GetDifficulty();
BOSSFIGHT_BALORS_N = 1+7*GetDifficulty();
BOSSFIGHT_NIGHTMARE_N = 1+10*GetDifficulty();
BOSSFIGHT_CERBERI_N = 1+40*GetDifficulty();
BOSSFIGHT_DEMONS_N = 1+60*GetDifficulty();
BOSSFIGHT_SUCCUBUS_N = 1+20*GetDifficulty();
BOSSFIGHT_FAMILIAR_N = 1+100*GetDifficulty();

if GetDifficulty() ~= DIFFICULTY_EASY then
	AddObjectCreatures( "InfernoBoss", CREATURE_ARCHDEVIL, BOSSFIGHT_DEVILS_N );
	AddObjectCreatures( "InfernoBoss", CREATURE_BALOR, BOSSFIGHT_BALORS_N );
	AddObjectCreatures( "InfernoBoss", CREATURE_FRIGHTFUL_NIGHTMARE, BOSSFIGHT_NIGHTMARE_N );
	AddObjectCreatures( "InfernoBoss", CREATURE_CERBERI, BOSSFIGHT_CERBERI_N );
	AddObjectCreatures( "InfernoBoss", CREATURE_HORNED_DEMON, BOSSFIGHT_DEMONS_N );
	AddObjectCreatures( "InfernoBoss", CREATURE_SUCCUBUS, BOSSFIGHT_SUCCUBUS_N );
	AddObjectCreatures( "InfernoBoss", CREATURE_FAMILIAR, BOSSFIGHT_FAMILIAR_N );
end;

PATH = "Maps/Scenario/A2C3M2/"; -- ���� � ������ �����

VOICEOVER_ZEHIR_FOUND_SECOND_CLERIC   = "/Maps/Scenario/A2C3M2/C3M2_VO3_Zehir_01sound.xdb#xpointer(/Sound)";
VOICEOVER_ZEHIR_FOUND_THIRD_CLERIC    = "/Maps/Scenario/A2C3M2/C3M2_VO10_Zehir_01sound.xdb#xpointer(/Sound)";
VOICEOVER_ZEHIR_COMPLETES_RITE        = "/Maps/Scenario/A2C3M2/C3M2_VO2_Zehir_01sound.xdb#xpointer(/Sound)";
VOICEOVER_MAIN_INFERNO_TOWN_DESTROYED = "/Maps/Scenario/A2C3M2/C3M2_VO6_Duncan_01sound.xdb#xpointer(/Sound)";
VOICEOVER_INFERNO_HERO_DEFEATED       = "/Maps/Scenario/A2C3M2/C3M2_VO7_Freyda_01sound.xdb#xpointer(/Sound)";
--VOICEOVER_ZEHIR \Maps\Scenario\A2C3M2\C3M2_VO2_Zehir_01sound.xdb#xpointer(\Sound)
--VOICEOVER_ZEHIR_FOUND_SECOND_CLERIC = "/Maps/Scenario/A2C3M2/C3M2_VO2_Zehir_01sound.xdb#xpointer(/Sound)";
--VOICEOVER_ZEHIR_FOUND_SECOND_CLERIC = "/Maps/Scenario/A2C3M2/C3M2_VO2_Zehir_01sound.xdb#xpointer(/Sound)";

-- ��������� ��� ��������
EFFECT_ARMAGEDDON = "/Effects/_(Effect)/Spells/Armageddon.xdb#xpointer(/Effect)";
EFFECT_HOLY_WORD = "/Effects/_(Effect)/Spells/HolyWord.xdb#xpointer(/Effect)";
EFFECT_TELEPORT_START = "/Effects/_(Effect)/Spells/Teleport_Start.xdb#xpointer(/Effect)";
EFFECT_INFERNO_GATING = "/Effects/_(Effect)/Characters/Gating.xdb#xpointer(/Effect)"

SOUND_EFFECT_HOLY_WORD = "/Sounds/_(Sound)/Spells/HolyWord_______255.xdb#xpointer(/Sound)";
SOUND_EFFECT_GATING = "/Sounds/_(Sound)/Spells/SummonOverEnd.xdb#xpointer(/Sound)";

-- ��������� ��� ���������� ����
--SCENE_MISSION_COMPLETED = "/DialogScenes/A2C3/M2/S2/DialogScene.xdb#xpointer(/DialogScene)";
SCENE_ZEHIR_COMPLETES_RITE = "/DialogScenes/A2C3/M2/S1/DialogScene.xdb#xpointer(/DialogScene)";
SCENE_ZEHIR_DUNCAN_FREYDA_DISCUSS = "/DialogScenes/A2C3/M2/S2/DialogScene.xdb#xpointer(/DialogScene)";



LEVEL1_BORDERS_OPENING_TIME = 21; -- ����� ������� ���� ����� ��������� ������� � ������ ������ �������� �� ����� �������� �� 1-� ����
LEVEL2_BORDERS_OPENING_TIME = 42; -- ����� ������� ���� ����� ��������� ������� � ������ ������ �������� �� ����� �������� �� 2-� ����
LEVEL3_BORDERS_OPENING_TIME = 84; -- ����� ������� ���� ����� ��������� ������� � ������ ������ �������� �� ����� �������� �� 3-� ����

-- ��������� ��� ������, ������� ����� ��������� ����� ��� � ������
N_EASY_GENIE = 20; -- ���������� ������� ����������� �� ������ EASY
N_NORMAL_GENIE = 18; -- ���������� ������� ����������� �� ������ NORMAL
N_HARD_GENIE = 14; -- ���������� ������� ����������� �� ������ HARD
N_HEROIC_GENIE = 12; -- ���������� ������� ����������� �� ������ HEROIC

N_EASY_GOLEMS = 60; -- ���������� ������� ����������� �� ������ EASY
N_NORMAL_GOLEMS = 55; -- ���������� ������� ����������� �� ������ NORMAL
N_HARD_GOLEMS = 45; -- ���������� ������� ����������� �� ������ HARD
N_HEROIC_GOLEMS = 40; -- ���������� ������� ����������� �� ������ HEROIC

RITE_X, RITE_Y = GetObjectPosition( "rite_selection" ); -- ���������� ����� �������

print( "MAIN: All constants are defined" );
--------------------------------------------------------------------
----------------- VARIABLES ----------------------------------------
--------------------------------------------------------------------
SetGameVar( "A2C3M2_ZehirHasGrail", "0");
SetGameVar( "A2C3M3_Graal", "0");

isZehirReadyCastMegaspell = 0;  -- boolean. ����� �� ������ ��� ���������� ��� ������� = 0, ������ - 1
dayWhenDuncanAndFreydaDeployed = 0;   -- integer. ���������� ��� �������� ���������� ����, ��������� � ������� ��������� ������ � �������
clericsCollected = 0; -- integer [1..3]. ������������� �� 1 ������ ���, ��� ������ ����� ������� ���������� �������.
isOkPressed  = 0; -- boolean. ��� ������ ������������ ����� ������� Ok isOkPressed  = 1, ���������� ��� ����������� ���������� ������� ����� ������������
isZehirAlreadyLeaveMission = 0;
isNoPressed = 0;
isLightOn = 0;
isInfernoTownDestroyed = 0;
infernoBossAlreadyPlaced = 0;
isInfernoBossDefeated = 0;
isSecondCleric=0;
debugMode=0;
easterEggCounter=0;

print( "MAIN: All variables are defined" );


--------------------------------------------------------------------
----------------- INITIAL CONDITIONS -------------------------------
--------------------------------------------------------------------
doFile("/scripts/A2_Artifact_Sets/A2_Artifact_Sets.lua");

function GiveTransferrableArtifacts()
	InitAllSetArtifacts( "A2C3M2", OUR_HERO_ZEHIR );
    LoadHeroAllSetArtifacts( OUR_HERO_ZEHIR, "A2C3M1" );
end;

--if (GetGameVar("BONUS_A2C3M1") == "1") then GiveArtefact("Zehir", ARTIFACT_ROBE_OF_MAGI ); end; -- ������ ������ ��������, ���� � �2�3�1 ����� �������� �������������� ����� ������

doFile("/scripts/A2_Zehir/A2_Zehir.lua"); -- ���������� ������ ����������� ������ ������ � ������� �� ������

--��������� �������� ��������
SetPlayerStartResource( PLAYER_1, CRYSTAL, 60 );
SetPlayerStartResource( PLAYER_1, MERCURY, 20 );
	
SetRegionBlocked( "110Region", true, PLAYER_1 ); -- ������������� ������, � ������� ����� ��������� zealot (ID=110) �� ����� �������
SetRegionBlocked( "10Region", true, PLAYER_1); -- ������������� ������, � ������� ����� ��������� priest (ID=10) �� ����� �������
SetRegionBlocked( "9Region", true, PLAYER_1 ); -- ������������� ������, � ������� ����� ��������� cleric (ID=9) �� ����� �������
SetRegionBlocked( "ZehirRegion", true, PLAYER_1 ); -- ������������� ������, � ������� ����� ��������� ����� �� ����� �������
SetRegionBlocked( "garrison1", true, PLAYER_2 ); 
SetRegionBlocked( "garrison2", true, PLAYER_2 );
SetRegionBlocked( "level2_border1", true, PLAYER_2 ); 
SetRegionBlocked( "level2_border2", true, PLAYER_2 );
SetRegionBlocked( "level3_border", true, PLAYER_2 );
SetRegionBlocked( "RedHeavenTownBorder", true, PLAYER_3 );
SetRegionBlocked( "landing_zone", true, PLAYER_1);
SetRegionBlocked( "BlockStartRegion1", true, PLAYER_1 );
SetRegionBlocked( "BlockStartRegion2", true, PLAYER_1 );
SetRegionBlocked( "BlockStartRegion3", true, PLAYER_1 );
SetRegionBlocked( "BlockStartRegion4", true, PLAYER_1 );
SetRegionBlocked( "BlockZehirRegion1", true, PLAYER_1 );
SetRegionBlocked( "BlockZehirRegion2", true, PLAYER_1 );

SetObjectEnabled( "main_deamon_town", nil );
SetObjectEnabled( "secondary_deamon_town", nil );
SetObjectEnabled( "red_heaven_town", nil );
SetObjectEnabled( "cleric", nil );
SetObjectEnabled( "priest", nil );

SetDisabledObjectMode( "cleric", DISABLED_INTERACT );
SetDisabledObjectMode( "priest", DISABLED_INTERACT );

DisableAutoEnterTown( "main_deamon_town", true );
DisableAutoEnterTown( "secondary_deamon_town", true );

EnableHeroAI( "RedHeavenHero03", nil );
EnableHeroAI( "RedHeavenHero02", nil );

--AllowPlayerTavernRace( PLAYER_2, TOWN_DUNGEON, 0 );	
--AllowPlayerTavernRace( PLAYER_2, TOWN_NECROMANCY, 0 );	
--AllowPlayerTavernRace( PLAYER_2, TOWN_STRONGHOLD, 0 );	
--AllowPlayerTavernRace( PLAYER_2, TOWN_HEAVEN, 0 );	
--AllowPlayerTavernRace( PLAYER_2, TOWN_PRESERVE, 0 );	
--AllowPlayerTavernRace( PLAYER_2, TOWN_FORTRESS, 0 );	
--AllowPlayerTavernRace( PLAYER_2, TOWN_ACADEMY, 0 );	

--AllowPlayerTavernRace( PLAYER_1, TOWN_DUNGEON, 0 );	
--AllowPlayerTavernRace( PLAYER_1, TOWN_NECROMANCY, 0 );	
--AllowPlayerTavernRace( PLAYER_1, TOWN_STRONGHOLD, 0 );	
--AllowPlayerTavernRace( PLAYER_1, TOWN_FORTRESS, 0 );	
--AllowPlayerTavernRace( PLAYER_1, TOWN_INFERNO, 0 );	

AllowHeroHiringByRaceInTown( "red_heaven_town", TOWN_DUNGEON, 0 );
AllowHeroHiringByRaceInTown( "red_heaven_town", TOWN_NECROMANCY, 0 );
AllowHeroHiringByRaceInTown( "red_heaven_town", TOWN_STRONGHOLD, 0 );
AllowHeroHiringByRaceInTown( "red_heaven_town", TOWN_PRESERVE, 0 );
AllowHeroHiringByRaceInTown( "red_heaven_town", TOWN_FORTRESS, 0 );
AllowHeroHiringByRaceInTown( "red_heaven_town", TOWN_INFERNO, 0 );
AllowHeroHiringByRaceInTown( "red_heaven_town", TOWN_ACADEMY, 0 );

--AllowHeroHiringByRaceInTown( "ZehirsTown", TOWN_DUNGEON, 0 );
--AllowHeroHiringByRaceInTown( "ZehirsTown", TOWN_NECROMANCY, 0 );
--AllowHeroHiringByRaceInTown( "ZehirsTown", TOWN_STRONGHOLD, 0 );
--AllowHeroHiringByRaceInTown( "ZehirsTown", TOWN_FORTRESS, 0 );
--AllowHeroHiringByRaceInTown( "ZehirsTown", TOWN_INFERNO, 0 );

SetTownBuildingLimitLevel( "red_heaven_town", TOWN_BUILDING_DWELLING_7, 0 );
SetTownBuildingLimitLevel( "red_heaven_town", TOWN_BUILDING_DWELLING_6, 0 );
SetTownBuildingLimitLevel( "red_heaven_town", TOWN_BUILDING_DWELLING_5, 0 );
SetTownBuildingLimitLevel( "red_heaven_town", TOWN_BUILDING_DWELLING_4, 0 );
SetTownBuildingLimitLevel( "red_heaven_town", TOWN_BUILDING_FORT, 1 );
SetTownBuildingLimitLevel( "red_heaven_town", TOWN_BUILDING_MAGIC_GUILD, 1 );

MakeHeroReturnToTavernAfterDeath( OUR_HERO_ZEHIR, 1, 1 );

DisableAutoEnterTown( "secondary_deamon_town", true );
DisableAutoEnterTown( "main_deamon_town", true );

function summon_creatures()
    if GetDifficulty() == DIFFICULTY_EASY then
		--ZehirCreaturesAdd(CREATURE_STEEL_GOLEM, N_EASY_GOLEMS, ORE, 20, 2000 ); 
		ZehirCreaturesAdd( CREATURE_MASTER_GENIE, N_EASY_GENIE, CRYSTAL, 20, 3000, "summon_initialized" ); 
		print( "MAIN: Difficulty level is EASY" );
    end;
    if GetDifficulty() == DIFFICULTY_NORMAL then
        --ZehirCreaturesAdd(CREATURE_STEEL_GOLEM, N_NORMAL_GOLEMS, ORE, 25, 2000 );
		ZehirCreaturesAdd( CREATURE_MASTER_GENIE, N_NORMAL_GENIE, CRYSTAL, 20, 3000, "summon_initialized" );
		print( "MAIN: Difficulty level is NORMAL" );
    end;
    if GetDifficulty() == DIFFICULTY_HARD then
        --ZehirCreaturesAdd(CREATURE_STEEL_GOLEM, N_HARD_GOLEMS, ORE, 30, 2000 );
		ZehirCreaturesAdd( CREATURE_MASTER_GENIE, N_HARD_GENIE, CRYSTAL, 20, 3000, "summon_initialized" );
		print( "MAIN: Difficulty level is HARD" );
    end;
    if GetDifficulty() == DIFFICULTY_HEROIC then
        --ZehirCreaturesAdd(CREATURE_STEEL_GOLEM, N_HEROIC_GOLEMS, ORE, 35, 2000 );
		ZehirCreaturesAdd( CREATURE_MASTER_GENIE, N_HEROIC_GENIE, CRYSTAL, 20, 3000, "summon_initialized" );
		print( "MAIN: Difficulty level is HEROIC" );
    end; 

	ZehirAbilitiesInit("Zehir");
end

print( "MAIN: Initial conditions are defined" );

function summon_initialized()
	StartAdvMapDialog( ADVMAPSCENE_START_COMBAT, "StartInitialCombat" );
end;


--------------------------------------------------------------------
----------------- FUNCTIONS ----------------------------------------
--------------------------------------------------------------------

------------------------------------------------------------------------
--     Function Name: moveTown() 
--     Description: 
------------------------------------------------------------------------
function moveTown()
	ZehirTownInit("ZehirsTown");
	AddTownPoint(92, 127, GROUND, 0, "summon_town_area", 15000, "landing_zone");
end;

function ShowReplaceToDeamonCreature( originalCreatureName, deamonCreatureType, quantity )
	BlockGame();
	local x,y,floor = GetObjectPosition( originalCreatureName );
	rotation = 0;
	if originalCreatureName=="demon_deamon" then
		rotation = 180;
	elseif originalCreatureName=="demon_balor" then
		rotation = 135;
	elseif originalCreatureName=="demon_devil" then
		rotation = 315;
	end;
	OpenCircleFog( x, y, floor, 5, PLAYER_1 );
	sleep(2);
	MoveCamera( x, y, floor, 40, 1, rotation/57, 0, 0, 1 );
	sleep(10);
	PlayVisualEffect( EFFECT_INFERNO_GATING, "", "tag", x+0.5, y+0.5, floor );
	Play2DSound( SOUND_EFFECT_GATING );
	sleep(5);
	RemoveObject( originalCreatureName );
	sleep(1);
	CreateMonster( "deamon", deamonCreatureType, quantity, x, y, floor, MONSTER_MOOD_AGGRESSIVE, MONSTER_COURAGE_ALWAYS_FIGHT, rotation );
	sleep(15);
	UnblockGame();
end;

------------------------------------------------------------------------
--     Function Name: MoveHeroRealTimeAndReachPoint( heroName, x, y, floor ) 
--     Description: ���������������� ������� MoveHeroRealTime. ����� �������� �������������� move points, ����� ��������� �������� �� ����
------------------------------------------------------------------------
function MoveHeroRealTimeAndReachPoint( heroName, x, y, floor )
	moveCost = CalcHeroMoveCost( heroName, x, y, GROUND );
	ChangeHeroStat( heroName, STAT_MOVE_POINTS, moveCost );
	sleep(1);
	MoveHeroRealTime( heroName, x, y, GROUND );
end


------------------------------------------------------------------------
--     Function Name: StartInitialCombat()
--     Description: ����� ���������� Red Heaven ����� � ����� ������ ������. 
------------------------------------------------------------------------
function StartInitialCombat()
	local x,y,floor = GetObjectPosition( OUR_HERO_ZEHIR );
	Trigger( PLAYER_REMOVE_HERO_TRIGGER, PLAYER_1, "InitialCombatResultHandler" );
	Trigger( PLAYER_REMOVE_HERO_TRIGGER, PLAYER_2, "InitialCombatResultHandler" );
	BlockGame();
	MoveHeroRealTime( INITIAL_COMBAT_ENEMY_HERO, x, y, floor );
	sleep( 40 );
	UnblockGame();
	
--	while IsHeroAlive( INITIAL_COMBAT_ENEMY_HERO) == true do sleep(1); end; -- ��� ������ ��������� ����� ����� ���������
end;

function ZehirWonInitialCombat()
	--MessageBox( PATH.."MsgBox_ClericGreetings.txt", "IsOkPressed" ); -- �������� ���������� ����� (���� �����������)
	CreateMonster("tmp_zealot", CREATURE_ZEALOT, 1, 127,40,GROUND,MONSTER_MOOD_FRIENDLY,MONSTER_COURAGE_ALWAYS_JOIN,100);
	BlockGame();
	sleep(1);
	UnblockGame();
	StartAdvMapDialog( ADVMAPSCENE_FIRST_CLERIC_JOINED, "IsOkPressed" );
	
	while isOkPressed == 0 do sleep(1); end; -- ��������� ���� ����� �� ������ Ok
	isOkPressed = 0;
	BlockGame();	
	sleep(1);
	UnblockGame();
	RemoveObject( "tmp_zealot" );
	SetClericOnRitePosition( CREATURE_ZEALOT, OUR_HERO_ZEHIR );	-- ��������� ������� �� ����� �������
		
	-- ������ ��� �������
	SetObjectiveState( "Prim1_FindGraal", OBJECTIVE_ACTIVE ); 
	SetObjectiveState( "prim2_CollectAllClerics", OBJECTIVE_ACTIVE );
	SetObjectiveState( "prim3_MoveTown", OBJECTIVE_ACTIVE );
	SetObjectiveState( "prim4_PerformTheRite", OBJECTIVE_ACTIVE );
	
	startThread( IsAllClericsCollected ); -- �������� ������� "������� ���� ��������"
	startThread( IsFlyingTownMoved ); -- �������� ������� "����������� ����� � ����� �������"
	startThread( IsTearOfAshaFound ); -- �������� ������� "����� Tear of Asha"
end;

function ZehirLooseInitialCombat()
	SetObjectOwner( "ZehirsTown", PLAYER_2 );
	MoveHeroRealTimeAndReachPoint( INITIAL_COMBAT_ENEMY_HERO, ZEHIRTOWN_ENTRANCE_X, ZEHIRTOWN_ENTRANCE_Y, GROUND );
end;

function InitialCombatResultHandler( heroLooser, heroWinner )
	Trigger( PLAYER_REMOVE_HERO_TRIGGER, PLAYER_1, nil );
	Trigger( PLAYER_REMOVE_HERO_TRIGGER, PLAYER_2, nil );
	print("InitialCombatResultHandler: Hero looser is", heroLooser );
	print("InitialCombatResultHandler: Hero winner is", heroWinner );
	if heroLooser == OUR_HERO_ZEHIR then
		startThread( ZehirLooseInitialCombat );
	else
		startThread( ZehirWonInitialCombat );
	end;
	SetRegionBlocked( "BlockStartRegion1", nil, PLAYER_1 );
	SetRegionBlocked( "BlockStartRegion2", nil, PLAYER_1 );
	SetRegionBlocked( "BlockStartRegion3", nil, PLAYER_1 );
	SetRegionBlocked( "BlockStartRegion4", nil, PLAYER_1 );
	print("InitialCombatResultHandler: All regions were unblocked for player");
end;


------------------------------------------------------------------------
--     Function Name: 
--     Description: 
------------------------------------------------------------------------
function IsOkPressed()
	isOkPressed = 1;
end;


------------------------------------------------------------------------
--     Function Name: 
--     Description: 
------------------------------------------------------------------------
function IsNoPressed()
	isNoPressed = 1;
end;

------------------------------------------------------------------------
--     Function Name: 
--     Description: 
------------------------------------------------------------------------
function IsClericJoined( heroName, objectName )
	MessageBox( PATH.."MsgBox_ClericGreetings.txt", "IsOkPressed" );
	
	while isOkPressed == 0 do sleep(1); end;
	isOkPressed = 0;
	
	if clericsCollected==1 then
		Play2DSound( VOICEOVER_ZEHIR_FOUND_SECOND_CLERIC );
	elseif clericsCollected==2 then
		Play2DSound( VOICEOVER_ZEHIR_FOUND_THIRD_CLERIC );
	end;

	sleep(1);
	if objectName == "cleric" then
		SetClericOnRitePosition( CREATURE_CLERIC, heroName, objectName );
	else
		if objectName == "priest" then
			SetClericOnRitePosition( CREATURE_PRIEST, heroName, objectName );
		end;
	end;
end;


------------------------------------------------------------------------
--     Function Name: 
--     Description: 
------------------------------------------------------------------------
function SetClericOnRitePosition( clericType, heroName, objectName )
	SetRegionBlocked( clericType.."Region", nil);
	
	OpenCircleFog( RITE_X, RITE_Y, GROUND, 8, PLAYER_1 );	
	MoveCamera( RITE_X, RITE_Y, GROUND, 30, 1, 4, 0, 0, 1 );
	local hero_x, hero_y, hero_floor = GetObjectPosition( heroName );
	sleep(8);
	
	if clericType == CREATURE_ZEALOT then
		print("Cleric is zealot");
		if GetHeroCreatures( OUR_HERO_ZEHIR, CREATURE_ZEALOT ) > 0 then
			N_Creatures = GetHeroCreatures( OUR_HERO_ZEHIR, clericType );
			RemoveHeroCreatures( OUR_HERO_ZEHIR, CREATURE_ZEALOT, 10000);
			print("All clerics are removed");
		else
			N_Creatures = 1;
		end;
	else
		N_Creatures = GetObjectCreatures( objectName, clericType );
		Trigger( OBJECT_TOUCH_TRIGGER, objectName, nil );
		sleep(1);
		RemoveObject( objectName );
	end;
	
	local x,y = RegionToPoint( clericType.."Region" );
	clericName = "cleric"..clericType;
	if clericType == CREATURE_ZEALOT then angle = 225;
	elseif clericType == CREATURE_CLERIC then angle = 135;
	elseif clericType == CREATURE_PRIEST then angle = 45;
	end;
	CreateMonster( clericName, clericType, N_Creatures, x,y, GROUND, MONSTER_MOOD_FRIENDLY, MONSTER_COURAGE_ALWAYS_JOIN, angle );
	sleep(1);
	SetObjectEnabled( clericName, nil );
	SetDisabledObjectMode( clericName, DISABLED_INTERACT );
	Trigger( OBJECT_TOUCH_TRIGGER, clericName, "IsClericTouched");
	PlayObjectAnimation( clericName, "happy" ,ONESHOT );
	sleep(15);
	
	MoveCamera( hero_x, hero_y, hero_floor, 70, 1, 4, 0, 0, 1 );
	clericsCollected = clericsCollected + 1;
	print( "SetClericOnRitePosition: ", clericsCollected," clerics collected.");
	--SetObjectiveProgress(  );
end;


------------------------------------------------------------------------
--     Function Name: 
--     Description: 
------------------------------------------------------------------------
function IsClericTouched( heroName )
	if heroName == OUR_HERO_ZEHIR then
		if clericsCollected < 3 then
			MessageBox( PATH.."MsgBox_ClericAnswer.txt" );
		else
			if HasArtefact( heroName, ARTIFACT_GRAAL ) == nil then
				MessageBox( PATH.."MsgBox_ClericRequestArtifact.txt" );
			else
				if GetObjectiveState( "prim3_MoveTown" ) == nil then
					MessageBox( PATH.."MsgBox_ClericNeedTown.txt" );
				else
					MessageBox( PATH.."MsgBox_ClericAllConditionsCompleted.txt");
				end;
			end;
		end;
	else
		MessageBox( PATH.."MsgBox_ClericNeedGotai.txt" );
	end;
end;

function IsAllRequiredElementsCollected( heroName )
	if heroName == OUR_HERO_ZEHIR then
		if HasArtefact( OUR_HERO_ZEHIR, ARTIFACT_GRAAL ) == true then
			if GetObjectiveState( "prim2_CollectAllClerics" ) == OBJECTIVE_COMPLETED then
				if GetObjectiveState( "prim3_MoveTown" ) == OBJECTIVE_COMPLETED then
					if infernoBossAlreadyPlaced==0 then
						print("Inferno Boss does not placed");
						infernoBossAlreadyPlaced=1;
						startThread( PlaceInfernoBoss );
					else
						print("Inferno boss is already placed");
						if IsObjectExists( "InfernoBoss" )==nil then
							Trigger( OBJECT_TOUCH_TRIGGER, "rite_invisible_building", nil );
							startThread( StartRitualIfInfernoBossDefeated )
						else
							MessageBox( PATH.."InfernoBossNotDefeated.txt" );
						end;
					end;
				else
					print( "Town isn't moved" );
					MessageBox( PATH.."MsgBox_TownNotMoved.txt" );
				end;
			else
				print( "Not all clerics are collected" );
				MessageBox( PATH.."MsgBox_NotAllClericsCollected.txt" );
			end;
		else
			MessageBox( PATH.."MsgBox_ZehirHaveNotGraal.txt" );
			print( "Zehir doesn't have graal" );
		end;
	else
		print( "Hero is not Zehir" );
		MessageBox( PATH.."MsgBox_HeroIsNotZehir.txt" );
	end;
end;

function PlaceInfernoBoss()
	BlockGame();
	local x, y = RegionToPoint( "ZehirRegion" );
	PlayVisualEffect( EFFECT_INFERNO_GATING, "", "tag", x+0.5, y+0.5, GROUND );
	Play2DSound( SOUND_EFFECT_GATING );
	sleep(5);
	SetObjectPosition( "InfernoBoss", x, y, GROUND );
	sleep(1);
	SetObjectRotation( "InfernoBoss", 315 );
	SetRegionBlocked("ZehirRegion", nil);
	--CreateMonster( "inferno_boss", CREATURE_ARCHDEVIL, BOSSFIGHT_DEVILS_N, x, y, GROUND, MONSTER_MOOD_AGGRESSIVE, MONSTER_COURAGE_ALWAYS_FIGHT, 315 );
	sleep(1);
	PlayObjectAnimation( "InfernoBoss", "stir00", ONESHOT );
	sleep(20);
	MessageBox( PATH.."RitualPlaceBossFight.txt" );
	startThread( PlayInfernoBossAnimations );
	startThread( BlockRegionWhenBossDefeated );
	
--EASY Devils 11,      HEROIC Devils 20 
--     Balors 15,             Balors 27
--  Nightmare 20,		   Nightmare 35
--    Cerberi 40,            Cerberi 100
--     Demons 70,             Demons 175
--   Succubus 30,           Succubus 60 

	UnblockGame();
end;

function PlayInfernoBossAnimations()
	while IsObjectExists( "InfernoBoss" )==true do
		PlayObjectAnimation( "InfernoBoss", "stir00", ONESHOT );
		sleep(50);
		if IsObjectExists( "InfernoBoss" )==true then
			PlayObjectAnimation( "InfernoBoss", "happy", ONESHOT );
		end;
		sleep(30);
	end;
end;

function BlockRegionWhenBossDefeated()
	repeat sleep(1); until IsObjectExists( "InfernoBoss" )==nil;
	SetRegionBlocked( "ZehirRegion", true );
	MessageBox( PATH.."MsgBox_GoToTheCenter.txt" );
end;

function StartRitualIfInfernoBossDefeated()
	BlockGame();
	SetRegionBlocked( "ZehirRegion", nil );
	sleep(5);
	ChangeHeroStat( OUR_HERO_ZEHIR, STAT_MOVE_POINTS, 100 );
	MoveHeroRealTimeAndReachPoint( OUR_HERO_ZEHIR, RegionToPoint( "ZehirRegion" ) );
	Trigger( REGION_ENTER_AND_STOP_TRIGGER, "ZehirRegion", "IsZehirReady" );
	while isZehirReadyCastMegaspell == 0 do sleep(1); end;
	sleep(1);
	SetObjectRotation( OUR_HERO_ZEHIR, 315);	
	sleep(1);
	PlayObjectAnimation( "cleric"..110, "cast", ONESHOT );
	PlayObjectAnimation( "cleric"..10, "cast", ONESHOT );
	PlayObjectAnimation( "cleric"..9, "cast", ONESHOT );
	sleep(10);
	local x_r,y_r = RegionToPoint("rite_area" );
	PlayVisualEffect( EFFECT_HOLY_WORD, '', 'megaboom', x_r,y_r, 7, 0, GROUND );
	Play2DSound( SOUND_EFFECT_HOLY_WORD );
	sleep(20);
	ShowDeamonTransformation();
	sleep(1);
	SetObjectiveState( "prim4_PerformTheRite", OBJECTIVE_COMPLETED );
	sleep(15);
	UnblockGame();
	startThread( DeployDuncanAndFreyda );
end;
------------------------------------------------------------------------
--     Function Name: 
--     Description: 
------------------------------------------------------------------------
function IsZehirReady()
	isZehirReadyCastMegaspell = 1;
end;


------------------------------------------------------------------------
--     Function Name: 
--     Description: 
------------------------------------------------------------------------
function IsAllClericsCollected()
	while  clericsCollected	< 3 do sleep(5) end;
	SetObjectiveState( "prim2_CollectAllClerics", OBJECTIVE_COMPLETED );
end;


------------------------------------------------------------------------
--     Function Name: 
--     Description: 
------------------------------------------------------------------------
function IsFlyingTownMoved()
	repeat
		town_x = GetObjectPosition("ZehirsTown"); sleep(5);
	until town_x == 92;
	SetObjectiveState( "prim3_MoveTown", OBJECTIVE_COMPLETED );
end;


------------------------------------------------------------------------
--     Function Name: 
--     Description: 
------------------------------------------------------------------------
function IsAnyPlayerHeroHasArtifact( player, artifact )
	currentPlayerHeroes = GetPlayerHeroes( player );
	for i=0, length( currentPlayerHeroes )-1 do
		if HasArtefact( currentPlayerHeroes[i], artifact ) == true then
			return true;
		end;
	end;
	return nil;
end;


------------------------------------------------------------------------
--     Function Name: 
--     Description: 
------------------------------------------------------------------------
function IsTearOfAshaFound()
	while IsAnyPlayerHeroHasArtifact( PLAYER_1, ARTIFACT_GRAAL ) == nil do sleep(4); end;
	print("IsTearOfAshaFound:  Graal is found!");
	if HasArtefact( OUR_HERO_ZEHIR, ARTIFACT_GRAAL ) == nil then -- ���� �������� ����� �� �����, �� 
		SetObjectiveState( "prim6_GiveGraalToZehir", OBJECTIVE_ACTIVE ); -- ������ ������� "�������� �������� ������"
		while HasArtefact( OUR_HERO_ZEHIR, ARTIFACT_GRAAL ) == nil do sleep(1); end;    -- ��� ������ �������� �������� � ������
		SetObjectiveState( "prim6_GiveGraalToZehir", OBJECTIVE_COMPLETED ); -- ���������� ������� "�������� �������� ������"
	end;
	RemoveArtefact( OUR_HERO_ZEHIR, ARTIFACT_GRAAL ); -- ������� ��������, ����� ������ ����� �� � ���������� untransferable
	GiveArtefact( OUR_HERO_ZEHIR, ARTIFACT_GRAAL, 1 ); -- ��������� ������ ���������� �������� ������ ������. (Set artifact untransferable)
	SetObjectiveState( "Prim1_FindGraal", OBJECTIVE_COMPLETED ); 
	startThread( IsGraalLost );                                     -- ��������� ��������, �� ����� �� ����� � ���������� (���� �����, ���������)
end;


------------------------------------------------------------------------
--     Function Name: 
--     Description: 
------------------------------------------------------------------------
function IsGraalLost()
	while IsAnyPlayerHeroHasArtifact( PLAYER_1, ARTIFACT_GRAAL ) == true do sleep(1); end; -- ���� �� � ������ ����� ������ ���� ������
	if GetObjectiveState( "prim4_PerformTheRite" ) ~= OBJECTIVE_COMPLETED then               -- ���������, ��� �� �� ������� ������
		print("IsGraalLost: Player has lost the Graal :(");	                               -- ���� ���, ��������� (����� ������� ������)
		MessageBox( PATH.."HeroLostGraal.txt" );
		sleep(1);
		Loose( PLAYER_1 );
	end;
	print("IsGraalLost:  No one hero has graal"); -- ������ ���� �� � ������ ����� ������, �� �� ���������� � ������. ��� ���� � ������ � ����� �������� �������.
end;


------------------------------------------------------------------------
--     Function Name: 
--     Description: 
------------------------------------------------------------------------
function ShowDeamonTransformation()
	BlockGame();
	print("ShowDeamonTransformation: Game blocked");
	OpenCircleFog( 97, 88, GROUND, 16 , PLAYER_1 );
	MoveCamera( 88,84,GROUND,70,1,4,0,0,1 );
	PlayVisualEffect( EFFECT_HOLY_WORD, '', 'boom', 97, 97, 10, 0, GROUND );
	PlayVisualEffect( EFFECT_HOLY_WORD, '', 'boom', 103, 92, 10, 0, GROUND );
	PlayVisualEffect( EFFECT_HOLY_WORD, '', 'boom', 103, 85, 10, 0, GROUND );
	PlayVisualEffect( EFFECT_HOLY_WORD, '', 'boom', 89, 91, 10, 0, GROUND );
	PlayVisualEffect( EFFECT_HOLY_WORD, '', 'boom', 89, 81, 10, 0, GROUND );
	PlayVisualEffect( EFFECT_HOLY_WORD, '', 'boom', 96, 71, 10, 0, GROUND );
	PlayVisualEffect( EFFECT_HOLY_WORD, '', 'boom', 81, 82, 10, 0, GROUND );
	Play2DSound( SOUND_EFFECT_HOLY_WORD );
	sleep(22);
	RemoveObject("rock1");
	RemoveObject("rock2");
	RemoveObject("rock3");
	RemoveObject("rock4");
	RemoveObject("rock5");
	RemoveObject("rock6");
	RemoveObject("rock7");
	RemoveObject("rock8");
	RemoveObject("rock9");
	ReplaceDwelling( "daemon_level3_dwelling1", TOWN_INFERNO );
	ReplaceDwelling( "daemon_level3_dwelling2", TOWN_INFERNO );
	ReplaceDwelling( "daemon_level2_dwelling1", TOWN_INFERNO );
	ReplaceDwelling( "daemon_level2_dwelling2", TOWN_INFERNO );
	ReplaceDwelling( "deamon_military_post1", TOWN_INFERNO );
	ReplaceDwelling( "deamon_military_post2", TOWN_INFERNO );
	TransformTown("main_deamon_town", TOWN_INFERNO );
	sleep(1);
	Play2DSound( VOICEOVER_ZEHIR_COMPLETES_RITE );
	BuildInfernoTown();
	local x,y,floor = GetObjectPosition("RedHeavenHero03");
	sleep(1);
	RemoveObject("RedHeavenHero03");
	sleep(1);
	DeployReserveHero( DEPLOYED_ENEMY_INFERNO_HERO, x, y, floor );
	sleep(25);
	OpenCircleFog( 11, 119, GROUND, 12 , PLAYER_1 );
	MoveCamera( 11,119, GROUND, 70, 1,4,0,0,1 );
	sleep(5);
	PlayVisualEffect( EFFECT_HOLY_WORD, '', 'boom', 11, 119, 10, 0, GROUND );
	PlayVisualEffect( EFFECT_HOLY_WORD, '', 'boom', 18, 114, 10, 0, GROUND );
	PlayVisualEffect( EFFECT_HOLY_WORD, '', 'boom', 19, 121, 10, 0, GROUND );
	Play2DSound( SOUND_EFFECT_HOLY_WORD );
	sleep(22);
	ReplaceDwelling( "daemon_level3_dwelling1_2", TOWN_INFERNO );
	ReplaceDwelling( "daemon_level1_dwelling1", TOWN_INFERNO );
	TransformTown("secondary_deamon_town", TOWN_INFERNO );
	sleep(2);
	UpgradeTownBuilding( "secondary_deamon_town", TOWN_BUILDING_TAVERN );
	UpgradeTownBuilding( "red_heaven_town", TOWN_BUILDING_TAVERN );
	DisableAutoEnterTown( "main_deamon_town", true );
	DisableAutoEnterTown( "secondary_deamon_town", true );
	startThread( PlayVoiceoverWhenVeyerDefeated );
	startThread( PlayVoiceoverWhenMainInfernoTownDestroyed );
	UnblockGame();
	ShowReplaceToDeamonCreature( "demon_deamon", CREATURE_HORNED_LEAPER, 100 );
	ShowReplaceToDeamonCreature( "demon_balor", CREATURE_PIT_SPAWN, 15 );
	ShowReplaceToDeamonCreature( "demon_devil", CREATURE_ARCH_DEMON, 10);
	print("ShowDeamonTransformation: Game unblocked");
end;

function BuildInfernoTown()
	UpgradeTownBuilding( "main_deamon_town", TOWN_BUILDING_TOWN_HALL );
	UpgradeTownBuilding( "main_deamon_town", TOWN_BUILDING_BLACKSMITH );
	UpgradeTownBuilding( "main_deamon_town", TOWN_BUILDING_MAGIC_GUILD );
	UpgradeTownBuilding( "main_deamon_town", TOWN_BUILDING_MAGIC_GUILD );
	UpgradeTownBuilding( "main_deamon_town", TOWN_BUILDING_DWELLING_1 );
	UpgradeTownBuilding( "main_deamon_town", TOWN_BUILDING_DWELLING_2 );
	UpgradeTownBuilding( "main_deamon_town", TOWN_BUILDING_MARKETPLACE );
	UpgradeTownBuilding( "main_deamon_town", TOWN_BUILDING_DWELLING_1 );
	UpgradeTownBuilding( "main_deamon_town", TOWN_BUILDING_DWELLING_2 );
	UpgradeTownBuilding( "main_deamon_town", TOWN_BUILDING_FORT );
	UpgradeTownBuilding( "main_deamon_town", TOWN_BUILDING_FORT );
	UpgradeTownBuilding( "main_deamon_town", TOWN_BUILDING_TAVERN );
end;

------------------------------------------------------------------------
--     Function Name: 
--     Description: 
------------------------------------------------------------------------
function RemoveZehirAndHisTown()
	isZehirAlreadyLeaveMission = 1;
	Trigger( REGION_ENTER_WITHOUT_STOP_TRIGGER, "ZehirsExit", nil );
	MakeHeroReturnToTavernAfterDeath( OUR_HERO_ZEHIR, 0, 0 );
	SaveHeroAllSetArtifacts( OUR_HERO_ZEHIR, "A2C3M2" );	
	sleep(4);
	RemoveObject( OUR_HERO_ZEHIR );
	
	CurrentPlayerHeroes=GetPlayerHeroes( PLAYER_1 );
	for i=1, length(CurrentPlayerHeroes)-1 do
		if CurrentPlayerHeroes[i]~=OUR_HERO_DUNCAN and CurrentPlayerHeroes[i]~=OUR_HERO_FREYDA then
			RemoveObject( CurrentPlayerHeroes[i] );
			print("RemoveZehirAndHisTown: hero "..CurrentPlayerHeroes[i].." was removed from map.");
		end;
	end;
	
	local town_x, town_y = GetObjectPosition( "ZehirsTown" );
	sleep(1);
	
	MoveCamera( town_x, town_y, GROUND, 50, 1,4, 0, 0, 1 );
	sleep(5);
	ZehirMoveTownPlayEffect( "ZehirsTown" );
	sleep(1);
	RemoveObject( "ZehirsTown" );
	DisableCameraFollowHeroes( 0, 0, 0 );
	print( "RemoveZehirAndHisTown: Zehir and his town were removed" );
end;


------------------------------------------------------------------------
--     Function Name: 
--     Description: 
------------------------------------------------------------------------
function DeployDuncanAndFreyda()
	--StartDialogScene( SCENE_ZEHIR_COMPLETES_RITE );	
	local zehir_x, zehir_y = GetObjectPosition( OUR_HERO_ZEHIR );
	BlockGame();
	print("DeployDuncanAndFreyda: Game is blocked");
	DisableCameraFollowHeroes( 1, 0, 0 );
	MoveCamera( zehir_x, zehir_y, GROUND, 50, 1,4, 0, 0, 1 );
	sleep(3);
	SetObjectPosition( OUR_HERO_ZEHIR, 2, 70, GROUND );
	sleep(5);
	
	DeployReserveHero( OUR_HERO_DUNCAN, 3, 68, GROUND );
	DeployReserveHero( OUR_HERO_FREYDA, 5, 70, GROUND );
	sleep(1);
	SetObjectRotation( OUR_HERO_DUNCAN, 90 );
	SetObjectRotation( OUR_HERO_FREYDA, 90 );
	sleep(1);
	UnreserveHero( OUR_HERO_DUNCAN );
	UnreserveHero( OUR_HERO_FREYDA );
	MoveCamera( 2, 70, GROUND, 50, 1,4, 0, 0, 1 );
	
	print("DeployDuncanAndFreyda: Duncan and Freyda have been deployed");
	UnblockGame();	
	--MessageBox( PATH.."MsgBox_ZehirGiveGraalFreydaAndDuncan.txt", "IsOkPressed" );
	StartDialogScene( SCENE_ZEHIR_COMPLETES_RITE, "SetDandFMissionPartSettings" );
end;

function SetDandFMissionPartSettings()	
	QuestionBox( PATH.."MsgBox_GiveGraalZehirOrDuncan.txt", "IsOkPressed", "IsNoPressed" );
	BlockGame();
	sleep(3);
	while isOkPressed == 0 and isNoPressed == 0 do sleep(1); end; 
	if isOkPressed == 1 then
		isOkPressed = 0;
		GiveArtefact( OUR_HERO_DUNCAN, ARTIFACT_GRAAL );
	else
		if isNoPressed == 1 then
			isNoPressed = 0;
			SetGameVar( "A2C3M2_ZehirHasGrail", "1" );
		end;
	end;
	
	SetRegionBlocked( "BlockZehirRegion1", nil, PLAYER_1 );
	SetRegionBlocked( "BlockZehirRegion2", nil, PLAYER_1 );
	
	Trigger( REGION_ENTER_WITHOUT_STOP_TRIGGER, "ZehirsExit", "RemoveZehirAndHisTown");	
	ChangeHeroStat( OUR_HERO_ZEHIR, STAT_MOVE_POINTS, 2000 );
	sleep(1);
	MoveHeroRealTime( OUR_HERO_ZEHIR, 1, 69, GROUND );
	
	UnblockGame();
	print( "DeployDuncanAndFreyda: Game is unblocked" );
	
	SetObjectiveState( "prim5_CaptureDeamonMainTown", OBJECTIVE_ACTIVE );
	SetObjectiveState( "sec1_CaptureDeamonSecondaryTown", OBJECTIVE_ACTIVE );
	SetObjectiveState( "prim7_FreydaMustSurvive", OBJECTIVE_ACTIVE );
	SetObjectiveState( "DuncanMustSurvive", OBJECTIVE_ACTIVE );
	startThread( HeroMustSurvive, OUR_HERO_FREYDA );
	startThread( HeroMustSurvive, OUR_HERO_DUNCAN );
	
	Trigger( OBJECT_CAPTURE_TRIGGER, "main_deamon_town", "IsMainDeamonTownCaptured" );
	Trigger( OBJECT_CAPTURE_TRIGGER, "secondary_deamon_town", "IsSecondaryDeamonTownCaptured" );
	
	SetObjectEnabled( "secondary_deamon_town", true );
	SetObjectEnabled( "main_deamon_town", true );
	SetObjectEnabled( "red_heaven_town", true );
	
	dayWhenDuncanAndFreydaDeployed = GetDate( DAY );
	
	Trigger( NEW_DAY_TRIGGER, "TimeToOpenBordersToAI" );
	Trigger( REGION_ENTER_AND_STOP_TRIGGER, "RedHeavenTownBorder", "RedHeavenGreatings" );
	
	SetObjectOwner( "archer_tower1", PLAYER_3 );
	SetObjectOwner( "archer_tower2", PLAYER_3 );
	SetObjectOwner( "footman_tower1", PLAYER_3 );
	SetObjectOwner( "footman_tower2", PLAYER_3 );
	SetObjectOwner( "military_post1", PLAYER_3 );
	SetObjectOwner( "military_post2", PLAYER_3 );
	SetObjectOwner( "red_heaven_town", PLAYER_3 );
	SetObjectOwner( "red_heaven_garrison", PLAYER_3 );
	
	UpgradeTownBuilding( "red_heaven_town", TOWN_BUILDING_TAVERN );
	UpgradeTownBuilding( "secondary_deamon_town", TOWN_BUILDING_TAVERN );
	
	--SetObjectOwner( "ore_mine", PLAYER_NONE );
	--SetObjectOwner( "ore_mine2", PLAYER_NONE );
	--SetObjectOwner( "gold_mine", PLAYER_NONE );
	--SetObjectOwner( "gold_mine2", PLAYER_NONE );
	--SetObjectOwner( "gem_mine", PLAYER_NONE );
	--SetObjectOwner( "crystal_mine", PLAYER_NONE );
	--SetObjectOwner( "mercury_mine", PLAYER_NONE );
	--SetObjectOwner( "sawmill_mine", PLAYER_NONE );
	--SetObjectOwner( "sulfur_mine", PLAYER_NONE );
	--SetObjectOwner( "dwarven_mine", PLAYER_NONE );
	
	DenyAIHeroFlee( OUR_HERO_DUNCAN, true );
	DenyAIHeroFlee( OUR_HERO_FREYDA, true );
	
	print("DeployDuncanAndFreyda: All heaven dwellings were given to PLAYER_3");
	
	RH_heroes = GetObjectsInRegion( "RedHeavenRegion", OBJECT_HERO );
	if length( RH_heroes ) > 0 then
		for i=0, length( RH_heroes )-1 do
			RemoveObject( RH_heroes[i] );
		end;
	end;
	print("DeployDuncanAndFreyda: All Heroes in RH_region have been removed");
end;

function HeroMustSurvive( heroName )
	repeat sleep(5); until IsHeroAlive( heroName )==nil;
	print( "HeroMustSurvive: ",heroName," is dead!");
	SetObjectiveState( "prim7_FreydaMustSurvive", OBJECTIVE_FAILED );
	SetObjectiveState( "DuncanMustSurvive", OBJECTIVE_FAILED );
	Loose( PLAYER_1 );
end;

------------------------------------------------------------------------
--     Function Name: 
--     Description: 
------------------------------------------------------------------------
function RedHeavenGreatings( heroName )
	if GetObjectOwner( heroName )==PLAYER_1 then
		Trigger( REGION_ENTER_AND_STOP_TRIGGER, "RedHeavenTownBorder", nil );
		MessageBox( PATH.."MsgBox_RedHeavenJoin.txt","GiveToPlayerAllRedHeavenBuildings");
	end;
end;


------------------------------------------------------------------------
--     Function Name: 
--     Description: 
------------------------------------------------------------------------
function GiveToPlayerAllRedHeavenBuildings()
	SetObjectOwner( "archer_tower1", PLAYER_1 );
	SetObjectOwner( "archer_tower2", PLAYER_1 );
	SetObjectOwner( "footman_tower1", PLAYER_1 );
	SetObjectOwner( "footman_tower2", PLAYER_1 );
	SetObjectOwner( "military_post1", PLAYER_1 );
	SetObjectOwner( "red_heaven_town", PLAYER_1 );
	SetObjectOwner( "red_heaven_garrison", PLAYER_1 );
	
	SetObjectOwner( "RH_SawMill", PLAYER_1 );
	SetObjectOwner( "RH_OrePit", PLAYER_1 );
	
	if GetObjectOwner( "military_post2" ) == PLAYER_3 then
		SetObjectOwner( "military_post2", PLAYER_NONE );
	end;
	
	SetTownBuildingLimitLevel( "red_heaven_town", TOWN_BUILDING_DWELLING_7, 2 );
	SetTownBuildingLimitLevel( "red_heaven_town", TOWN_BUILDING_DWELLING_6, 2 );
	SetTownBuildingLimitLevel( "red_heaven_town", TOWN_BUILDING_DWELLING_5, 2 );
	SetTownBuildingLimitLevel( "red_heaven_town", TOWN_BUILDING_DWELLING_4, 2 );
	SetTownBuildingLimitLevel( "red_heaven_town", TOWN_BUILDING_FORT, 3 );
	SetTownBuildingLimitLevel( "red_heaven_town", TOWN_BUILDING_MAGIC_GUILD, 5 );
	
	print("GiveToPlayerAllRedHeavenBuildings: All buildings owned by PLAYER_1");
	RH_heroes = GetObjectsInRegion( "RedHeavenRegion", OBJECT_HERO );
	if length( RH_heroes ) > 0 then
		for i=0, length( RH_heroes )-1 do
			SetObjectOwner( RH_heroes[i], PLAYER_1 );
		end;
	end;
	
	RH_mines={'gold_mine_2_1', 'gold_mine_2_2', 'gold_mine_2_3', 'gem_mine_2', 'ore_pit_2', 'sawmill_2', 'alchemist_lab_2', 'crystal_cavern_2', 'sulfur_deposit_2'};

	for i=1, length( RH_mines ) do
		if GetObjectOwner( RH_mines[i] )==PLAYER_3 then
			SetObjectOwner( RH_mines[i], PLAYER_1);
		end;
	end;
	
	
	print("GiveToPlayerAllRedHeavenBuildings: All heroes in RH_heroes region were owned by PLAYER_1");
end;


------------------------------------------------------------------------
--     Function Name: 
--     Description: 
------------------------------------------------------------------------
function IsMainDeamonTownCaptured( oldOwner, newOwner, heroName )
	if newOwner == PLAYER_1 then
		isInfernoTownDestroyed = 1;
		RazeTown("main_deamon_town");
	end;
end;

function prim_DefeatInfernoHeroAndDestroyTown_completed()
	repeat sleep(5); until isInfernoTownDestroyed==1 and IsHeroAlive( DEPLOYED_ENEMY_INFERNO_HERO )==nil;
	--StartDialogScene( SCENE_ZEHIR_DUNCAN_FREYDA_DISCUSS );
	SaveHeroAllSetArtifacts( OUR_HERO_FREYDA, "A2C3M2");
	SaveHeroAllSetArtifacts( OUR_HERO_DUNCAN, "A2C3M2");
	sleep(1);
	SetObjectiveState( "prim5_CaptureDeamonMainTown", OBJECTIVE_COMPLETED );
	--StartDialogScene( SCENE_MISSION_COMPLETED, "WinMission");
	Win(PLAYER_1);
end;

function PlayVoiceoverWhenVeyerDefeated()
	repeat sleep(1); until IsHeroAlive( DEPLOYED_ENEMY_INFERNO_HERO )==nil;
	if isInfernoTownDestroyed==0 then
		Play2DSound( VOICEOVER_INFERNO_HERO_DEFEATED );
	end;
end;

function PlayVoiceoverWhenMainInfernoTownDestroyed()
	repeat sleep(1); until isInfernoTownDestroyed==1;
	if IsHeroAlive( DEPLOYED_ENEMY_INFERNO_HERO )==true then
		Play2DSound( VOICEOVER_MAIN_INFERNO_TOWN_DESTROYED );
	end;
end;

function WinMission()
	sleep(5);
	Win(PLAYER_1);
end;


------------------------------------------------------------------------
--     Function Name: 
--     Description: 
------------------------------------------------------------------------
function IsSecondaryDeamonTownCaptured( oldOwner, newOwner, heroName )
	if newOwner == PLAYER_1 then
		SetObjectiveState( "sec1_CaptureDeamonSecondaryTown", OBJECTIVE_COMPLETED );
		RazeTown( "secondary_deamon_town" );
		sleep(15);
		--GiveArtefact( heroName, ARTIFACT_OGRE_CLUB );
		--GiveArtefact( heroName, ARTIFACT_OGRE_SHIELD );
		GiveArtefact( heroName, ARTIFACT_CROWN_OF_COURAGE );
		GiveArtefact( heroName, ARTIFACT_LION_HIDE_CAPE );
		GiveArtefact( heroName, ARTIFACT_NECKLACE_OF_BRAVERY );
		ShowFlyingSign( PATH.."MsgBox_GainOgreSetArtifacts.txt", heroName, PLAYER_1, 4 );
	end;
end;

function IsPlayerHasZehirTown()
	if IsObjectExists( "ZehirsTown" )==true then
		if GetObjectOwner( "ZehirsTown" )==PLAYER_1 then
			return true;
		else
			return nil;
		end;
	else
		return nil;
	end;
end;


function ZehirMustSurvive()
	repeat sleep(5); until IsHeroAlive( OUR_HERO_ZEHIR )==nil and IsPlayerHasZehirTown()==nil;
	if isZehirAlreadyLeaveMission == 1 then
		SetObjectiveState( "Prim9_ZehirMustSurvive", OBJECTIVE_COMPLETED );
	else
		SetObjectiveState( "Prim9_ZehirMustSurvive", OBJECTIVE_FAILED );
		Loose( PLAYER_1 );
	end;
end;

------------------------------------------------------------------------
--     Function Name: 
--     Description: 
------------------------------------------------------------------------
function TimeToOpenBordersToAI()
	if GetDate( DAY ) - dayWhenDuncanAndFreydaDeployed == LEVEL1_BORDERS_OPENING_TIME then
		SetRegionBlocked( "garrison1", nil, PLAYER_2 );
		SetRegionBlocked( "garrison2", nil, PLAYER_2 );
		print("TimeToOpenBordersToAI: AI has access to level 1 area");
	elseif GetDate( DAY ) - dayWhenDuncanAndFreydaDeployed == LEVEL2_BORDERS_OPENING_TIME then
		SetRegionBlocked( "level2_border1", nil, PLAYER_2 );
		SetRegionBlocked( "level2_border2", nil, PLAYER_2 );
		print("TimeToOpenBordersToAI: AI has access to level 2 area");
	elseif GetDate( DAY ) - dayWhenDuncanAndFreydaDeployed == LEVEL3_BORDERS_OPENING_TIME then
		SetRegionBlocked( "level3_border", nil, PLAYER_2 );
		print("TimeToOpenBordersToAI: AI has access to level 3 area");
	end;
end;

function ShowSceneIfZehirNearGraal( heroName )	-- �� ��������. ��������, ����� �� �����
	Trigger( REGION_ENTER_AND_STOP_TRIGGER, "graal_region", nil);
	StartAdvMapDialog();
end;

isDiscoStarted=0;
Lights = { "green_light", "red_light", "blue_light", "yellow_light", "no_light" };
DISCO_ARRAY = { "happy", "happy", "happy", "hit", "hit", "attack00", "death", "cast", "rangeattack" };

function StartDisco()
	startThread( DiscoLights, "discoLight1" );
	startThread( DiscoLights, "discoLight2" );
	startThread( DiscoLights, "discoLight3" );
	startThread( DiscoLights, "discoLight4" );
	for i=1, 20 do
		startThread( StartDiscoAnimations, "m"..i );
	end;
end;

function StartDiscoAnimations( dancerName )
	while IsObjectExists( dancerName )==true do
		animationName = DISCO_ARRAY[ random(length(DISCO_ARRAY)) + 1 ];
		PlayObjectAnimation( dancerName, animationName, ONESHOT );
		sleep( random(12)+5 );
	end;
	print("Object "..dancerName.." doesn't exist");
end;

function DiscoLights( objectName )
	print("DiscoLights for object "..objectName.. " started");
	while 1 do
		SetObjectFlashlight( objectName, Lights[ random( length( Lights ))+1]);
		sleep( random(4) );
		ResetObjectFlashlight( objectName );
	end;
end;

function SetToDisco( heroName )
	if heroName == "Zehir" then
		if easterEggCounter == 5 then
			SetObjectPosition( heroName, 12, 25, UNDERGROUND );
			if isDiscoStarted==0 then
				isDiscoStarted=1;
				startThread( StartDisco );
			end;
		else
			easterEggCounter=easterEggCounter+1;
			print("easterEggCounter = "..easterEggCounter);
		end;
	end;
end;

function ReturnFromToDisco( heroName )
	SetObjectPosition( heroName, 119, 36, UNDERGROUND );
end;
--------------------------------------------------------------------
----------------- MAIN ---------------------------------------------
--------------------------------------------------------------------
function mainStart()
	BlockGame();
	GiveTransferrableArtifacts();
	
	startThread( ZehirMustSurvive );
	
	Trigger( OBJECT_TOUCH_TRIGGER, "rite_invisible_building", "IsAllRequiredElementsCollected" );
	Trigger( OBJECT_TOUCH_TRIGGER, "cleric", "IsClericJoined" )
	Trigger( OBJECT_TOUCH_TRIGGER, "priest", "IsClericJoined" )
	Trigger( REGION_ENTER_AND_STOP_TRIGGER, "disco_exit", "ReturnFromToDisco" );
	Trigger( REGION_ENTER_AND_STOP_TRIGGER, "disco_enter", "SetToDisco" );
	
	startThread( prim_DefeatInfernoHeroAndDestroyTown_completed );

	print( "MAIN: All functions and triggers are ran" );
	sleep( 1 );
	
	summon_creatures();
	moveTown();
	UnblockGame();
end;
startThread( mainStart );