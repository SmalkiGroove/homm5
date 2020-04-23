
---------------------------------------------------------------------------------------------------
--------------------------------- TITLE --------------------------------------------------------
---------------------------------------------------------------------------------------------------
--	Creation Date: 16.02.07
-- 	Author: Arseny Adamov
--	Author e-mail: Arseny.Adamov@nival.com
--	Project Name: H5A2
--	Map Name: A2C3M3
--	Script Description: MapScript
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------
--------------------------------- CONSTANTS ----------------------------------------------
---------------------------------------------------------------------------------------------------

--*-- HEROES SCRIPT NAMES --*--
HERO_PLAYER = 'Zehir';
WULFSTAN = 'Wulfstan';
HANGVUL = 'Hangvul';
HERO_ROLF = 'Rolf';
ENEMY_HERO1 = 'Bersy';
ENEMY_HERO2 = 'Egil';
ENEMY_HERO3 = 'Ottar';

--*-- CREATURES SCRIPT NAMES --*--


--*-- OBJECTS SCRIPT NAMES --*--
OBJECT_HOME_TOWN = 'Mutazz';
OBJECT_WULFSTAN_TOWN = 'Kolvard';
OBJECT_SUB_GATE_EXIT_HOME = 'Sub_gate_exit_home';
OBJECT_SUB_GATE_EXIT_AI = 'Sub_gate_exit_ai';
OBJECT_ONE_WAY_TELEPORT_AI = 'One_way_teleport_ai';
OBJECT_TELEPORT_TO_DRAGON = 'Teleport_to_Dragon';

PATH = "/Maps/Scenario/A2C3M3/";

-- Adventure map scenes
ADVMAPSCENE_MISSION_START = 0;
ADVMAPSCENE_MEET_ROLF = 1;

-- VoiceOvers

VOICEOVER_ZEHIR_APPROACH_EXIT =         "/Maps/Scenario/A2C3M3/C3M3_VO2_Zehir_01sound.xdb#xpointer(/Sound)";
VOICEOVER_ZEHIR_GOES_GROUND  =          "/Maps/Scenario/A2C3M3/C3M3_VO3_Zehir_01sound.xdb#xpointer(/Sound)";
VOICEOVER_ZEHIR_FINDS_KEY =             "/Maps/Scenario/A2C3M3/C3M3_VO5_Zehir_01sound.xdb#xpointer(/Sound)";
VOICEOVER_ZEHIR_APPROACH_BORDER_GUARD = "/Maps/Scenario/A2C3M3/C3M3_VO4_Zehir_01sound.xdb#xpointer(/Sound)";

EFFECT_TOWNPORTAL_END = "/Effects/_(Effect)/Spells/townportal_end.xdb#xpointer(/Effect)";

SCENE_DRAGON_FOUND="";

doFile("/scripts/A2_Artifact_Sets/A2_Artifact_Sets.lua");
doFile("/scripts/A2_Zehir/A2_Zehir.lua");

--sleep(5);

--if (GetGameVar("BONUS_A2C3M1") == "1") then GiveArtefact("Zehir", ARTIFACT_ROBE_OF_MAGI ); end; -- ������ ������ ��������, ���� � �2�3�1 ����� �������� �������������� ����� ������
--if GetGameVar( "A2C3M2_ZehirHasGrail" ) == "1" then GiveArtefact( "Zehir", ARTIFACT_GRAAL ); end; -- ������ ������ ������, ���� �� ������� ��� ���� � ���������� ������

function summon_creatures()
	if GetDifficulty() == DIFFICULTY_EASY then
		ZehirCreaturesAdd(CREATURE_RAKSHASA_KSHATRI, 10, MERCURY, 20, 4500);
	end;
	if GetDifficulty() == DIFFICULTY_NORMAL then
		ZehirCreaturesAdd(CREATURE_RAKSHASA_KSHATRI, 8, MERCURY, 20, 4500);
	end;
	if GetDifficulty() == DIFFICULTY_HARD then
		ZehirCreaturesAdd(CREATURE_RAKSHASA_KSHATRI, 6, MERCURY, 20, 4500);
	end;
	if GetDifficulty() == DIFFICULTY_HEROIC then
		ZehirCreaturesAdd(CREATURE_RAKSHASA_KSHATRI, 5, MERCURY, 20, 4500);
	end;
	ZehirAbilitiesInit( "Zehir" );
end;

startThread( summon_creatures );

function move_town()
	ZehirTownInit("Mutazz");
	AddTownPoint(27, 48, GROUND, 0, "Checker_place_for_town", 20000, "Get_out")
end;

startThread( move_town );

--*-- Logfile beginning - for testing purposes --*--


 -- MOVE CAMERA TO PROPER STARTING POSITION

--*-- ECONOMIC VARIABLES --*--


--*-- Setting starting player resources --*--


--*-- Setting deadline --*--




---------------------------------------------------------------------------------------------------
-------------------------------- VARIABLES -------------------------------------------------
---------------------------------------------------------------------------------------------------



---------------------------------------------------------------------------------------------------
------------------------------- START MAP SETTINGS -----------------------------------
---------------------------------------------------------------------------------------------------

--*-- Blocking standard interaction algorythms --*--
--SetObjectEnabled(OBJECT_SUB_GATE_EXIT_HOME, nil);
SetObjectEnabled(OBJECT_TELEPORT_TO_DRAGON, nil);
SetObjectEnabled( "BorderGuard", nil );


SetPlayerStartResources(PLAYER_2, 200, 200, 50, 100, 50, 50, 900000);
SetPlayerStartResources(PLAYER_3, 150, 150, 75, 150, 75, 75, 100000);

SetRegionBlocked("Ai_block_zone", 1, PLAYER_2);
SetRegionBlocked("Ai_block_zone2", 1, PLAYER_2);
SetRegionBlocked("Ai_block_zone3", 1, PLAYER_2);
SetRegionBlocked("Ai_block_zone4", 1, PLAYER_2);
SetRegionBlocked( "teleport_to_wulfstan_town_2", true );
SetRegionBlocked( "Get_out", true );

AllowPlayerTavernHero( PLAYER_1, HERO_PLAYER, 1 );
AllowPlayerTavernHero( PLAYER_1, HERO_ROLF, 0 );
AllowPlayerTavernHero( PLAYER_2, HERO_ROLF, 0 );
AllowPlayerTavernHero( PLAYER_3, HERO_ROLF, 0 );

EnableHeroAI( HANGVUL, nil );
EnableHeroAI( HERO_ROLF, nil );

SetHeroRoleMode( HERO_ROLF, HERO_ROLE_MODE_HERMIT );

SetDisabledObjectMode( OBJECT_SUB_GATE_EXIT_HOME , DISABLED_INTERACT );
SetDisabledObjectMode( OBJECT_ONE_WAY_TELEPORT_AI , DISABLED_INTERACT );
SetDisabledObjectMode( OBJECT_TELEPORT_TO_DRAGON , DISABLED_INTERACT );
SetDisabledObjectMode( "BorderGuard", DISABLED_INTERACT );

AllowPlayerTavernHero( PLAYER_1, HERO_PLAYER, 1 );
AllowHeroHiringByRaceInTown( OBJECT_HOME_TOWN, -1, 0 );
AllowHiringOfHeroInTown( OBJECT_HOME_TOWN, HERO_PLAYER, 1 );
AllowHiringOfHeroInTown( OBJECT_WULFSTAN_TOWN, HERO_PLAYER, 0 );

DenyAIHeroFlee(HERO_PLAYER, true);
DenyAIHeroFlee(WULFSTAN, true);

MakeHeroReturnToTavernAfterDeath(HERO_PLAYER, 1, 1 );

DoNotGiveTurnToPlayerAIIfNoTownsAndActiveHeroes( PLAYER_3, true );

SetPlayerResource( PLAYER_3, GOLD, 100000 );
SetPlayerResource( PLAYER_3, ORE, 100 );
SetPlayerResource( PLAYER_3, WOOD, 100 );
SetPlayerResource( PLAYER_3, MERCURY, 100 );
SetPlayerResource( PLAYER_3, CRYSTAL, 100 );
SetPlayerResource( PLAYER_3, GEM, 100 );
SetPlayerResource( PLAYER_3, SULFUR, 100 );

function f_artifacts_sets()
	InitAllSetArtifacts( "A2C3M3", HERO_PLAYER );
	LoadHeroAllSetArtifacts( HERO_PLAYER, "A2C3M2" );
end;

startThread( f_artifacts_sets );

function Z_graal() 
	if GetGameVar("A2C3M2_ZehirHasGrail") == "1" then
		GiveArtefact(HERO_PLAYER, ARTIFACT_GRAAL);
	end;
end;

startThread( Z_graal );

---------------------------------------------------------------------------------------------------
-------------------------------- FUNCTIONS ------------------------------------------------
---------------------------------------------------------------------------------------------------

------------------------------------------------------------------
--*-- PRIMARY QUESTS CHECK FUNCTIONS --*--
------------------------------------------------------------------


-----------------------------------------------------------------------
--*-- SECONDARY QUESTS CHECK FUNCTIONS --*--
-----------------------------------------------------------------------


------------------------------------------------------------------
--*-- PRIMARY QUESTS START FUNCTIONS --*--
------------------------------------------------------------------
--pri1
function f_pri1() --����������� ���������
    SetObjectiveState('pri1', OBJECTIVE_ACTIVE, PLAYER_1);
end;

function PlayVoiceoverIfZehirExitUnderground()
	repeat sleep(1); x,y,floor = GetObjectPosition(HERO_PLAYER); until floor==GROUND;
	sleep(5);
	MessageBox("/Maps/Scenario/A2C3M3/message_007.txt", "PlayVoiceOver");
end;

function PlayVoiceOver()
	Play2DSound( VOICEOVER_ZEHIR_GOES_GROUND );
end;

function PlayVoiceoverIfZehirHasKey()
	repeat sleep(1); until HasBorderguardKey( PLAYER_1, RED_KEY )==not nil;
	sleep(5);
	Play2DSound( VOICEOVER_ZEHIR_FINDS_KEY );
end;

function PlayVoiceoverIfZehirNearExit( heroName )
	if heroName==HERO_PLAYER then
		Play2DSound( VOICEOVER_ZEHIR_APPROACH_EXIT );
		Trigger( REGION_ENTER_WITHOUT_STOP_TRIGGER, "Ai_block_zone2", nil );
	end;
end;

function PlayVoiceoverIfZehirNearShrine()
	Trigger( REGION_ENTER_AND_STOP_TRIGGER, "ShrineRegion", nil );
	Play2DSound( VOICEOVER_ZEHIR_APPROACH_BORDER_GUARD );
end;

function f_pri1_success() --����������� �������� f_win_pre
    SetObjectiveState("pri1", OBJECTIVE_COMPLETED, PLAYER_1);
end;

function f_check_fail_hero() --����������� ��������� Trigger(PLAYER_REMOVE_HERO_TRIGGER, 1, "f_check_fail_hero") ��� Trigger(PLAYER_REMOVE_HERO_TRIGGER, 2, "f_check_fail_hero") ��� Trigger(OBJECT_CAPTURE_TRIGGER, OBJECT_HOME_TOWN, "f_check_fail_hero");
	if (IsHeroAlive(HERO_PLAYER) == nil) and ( GetObjectOwner(OBJECT_HOME_TOWN) ~= PLAYER_1 ) then
		Trigger(PLAYER_REMOVE_HERO_TRIGGER, 1, nil);
		Trigger(PLAYER_REMOVE_HERO_TRIGGER, 2, nil);
		SetObjectiveState("pri2", OBJECTIVE_FAILED, PLAYER_1);
		SetObjectiveState("pri4", OBJECTIVE_FAILED, PLAYER_1);
		print ("ready_to_fail");
		sleep(1);			
		startThread( f_loose );
    end;	
	if	(IsHeroAlive(WULFSTAN) == nil) then
		Trigger(PLAYER_REMOVE_HERO_TRIGGER, 1, nil);
		Trigger(PLAYER_REMOVE_HERO_TRIGGER, 2, nil);
		SetObjectiveState("pri1", OBJECTIVE_FAILED, PLAYER_1);
		SetObjectiveState("pri4", OBJECTIVE_FAILED, PLAYER_1);
		print ("ready_to_fail");
		sleep(1);		
		startThread( f_loose );
	end;	
	if	(IsHeroAlive(HANGVUL) == nil) then
		Trigger(PLAYER_REMOVE_HERO_TRIGGER, 2, nil);
		Trigger(PLAYER_REMOVE_HERO_TRIGGER, 1, nil);
		SetObjectiveState("pri3", OBJECTIVE_FAILED, PLAYER_1);
		SetObjectiveState("pri4", OBJECTIVE_FAILED, PLAYER_1);
		print ("ready_to_fail");
		sleep(1);		
		startThread( f_loose );
	end;

	-- f_pri1_fail();	
	-- f_pri2_fail();
	-- f_pri3_fail();
end;

--pri2
function f_pri2() --����������� ���������
    SetObjectiveState('pri2', OBJECTIVE_ACTIVE, PLAYER_1);
end;

function f_pri2_success() --����������� �������� f_win_pre
    SetObjectiveState("pri2", OBJECTIVE_COMPLETED, PLAYER_1);
end;

--pri3
function f_pri3() --����������� ���������
    SetObjectiveState('pri3', OBJECTIVE_ACTIVE, PLAYER_1);
end;

function f_pri3_success() --����������� �������� f_win_pre
    SetObjectiveState("pri3", OBJECTIVE_COMPLETED, PLAYER_1);
end;

--pri4
function f_pri4() --����������� ���������
    SetObjectiveState('pri4', OBJECTIVE_ACTIVE, PLAYER_1);
end;

function f_pri4_success(hero) --����������� ��������� Trigger(OBJECT_TOUCH_TRIGGER, OBJECT_TELEPORT_TO_DRAGON, "f_pri4_success");
	if hero==HERO_PLAYER then
		if ( GetHeroLevel(HERO_PLAYER) < 25 ) then 
			f_show_message_008();
			return true 
		end;
		print("exp_enough");		
		if hero == HERO_PLAYER then
			SetObjectiveState("pri4", OBJECTIVE_COMPLETED, PLAYER_1);
			f_win_pre();
			sleep( 2 );
		elseif hero ~= HERO_PLAYER then
			sleep( 2 );
		end;
	else
		MessageBox(PATH.."MsgBox_OnlyZehirCanEnterGate.txt");
	end;
end;

-----------------------------------------------------------------------
--*-- PRIMARY QUESTS FINISH FUNCTIONS --*--
-----------------------------------------------------------------------


-----------------------------------------------------------------------
--*-- SECONDARY QUESTS START FUNCTIONS --*--
-----------------------------------------------------------------------


----------------------------------------------------------------------------
--*-- SECONDARY QUESTS FINISH FUNCTIONS --*--
----------------------------------------------------------------------------


-----------------------------------------------------
--*-- MISC ACTIONS FUNCTIONS --*--
-----------------------------------------------------
function f_win_pre() --����������� �������� f_pri4_success
	Trigger(PLAYER_REMOVE_HERO_TRIGGER, 1, nil);
	Trigger(PLAYER_REMOVE_HERO_TRIGGER, 2, nil);
	f_pri1_success ();
	f_pri2_success ();	
	f_pri3_success ();
	sleep(5);
	if HasArtefact(HERO_PLAYER, ARTIFACT_GRAAL )==true then
		SetGameVar("A2C3M3_Graal", "1");
		print ("SetGlobalVar = 1");
	elseif GetTownBuildingLevel(OBJECT_HOME_TOWN, TOWN_BUILDING_GRAIL)==true then
		SetGameVar("A2C3M3_Graal", "2");
		print ("SetGlobalVar = 2");
	end;
	StartDialogScene("/DialogScenes/A2C3/M3/S1/DialogScene.xdb#xpointer(/DialogScene)", "f_win");	
end;

function f_win()
	SaveHeroAllSetArtifacts( HERO_PLAYER, "A2C3M3");
	SaveHeroAllSetArtifacts( WULFSTAN, "A2C3M3");
	sleep(5);
	Win();
end;

function f_loose() --����������� ��������� f_pri1_fail, f_pri2_fail, f_pri3_fail
	sleep(5);
	Loose();
end;

function show_gate_msg_for_hero(hero)
	if hero == WULFSTAN then
		startThread( f_show_message_001 );
	end;
	if hero == HERO_PLAYER then
		--sleep(10);
		--startThread( f_show_message_007 );
	end;
	if hero ~= HERO_PLAYER and hero ~= WULFSTAN then
		startThread( f_show_message_006 );
	end;
end;

function f_one_way_teleport_blocked()
	SetObjectEnabled(OBJECT_ONE_WAY_TELEPORT_AI, nil);
	startThread( f_show_message_003 );
	Trigger(REGION_ENTER_WITHOUT_STOP_TRIGGER, "About_Block_player_zone", "f_deactivator_one_way_teleport_blocked");
	Trigger(OBJECT_TOUCH_TRIGGER, OBJECT_ONE_WAY_TELEPORT_AI, "f_show_message_003");
end;

function f_deactivator_one_way_teleport_blocked()
	Trigger(REGION_ENTER_WITHOUT_STOP_TRIGGER, "About_Block_player_zone", nil);
	SetObjectEnabled(OBJECT_ONE_WAY_TELEPORT_AI, true);
end;

function BlockUndergroundExit( heroName )
	if heroName == HERO_PLAYER then
		SetObjectEnabled( OBJECT_SUB_GATE_EXIT_HOME, true );
	else
		SetObjectEnabled( OBJECT_SUB_GATE_EXIT_HOME, nil );
	end;
end;

---------------------------------------------------
--*-- CAMERA MOVE FUNCTIONS --*--
---------------------------------------------------

function f_open_fog_start() --����������� ���������
	OpenCircleFog(13, 14, 1, 4, 1);
end;

---------------------------------------------------
--*-- MESSAGEBOX FUNCTIONS --*--
---------------------------------------------------
function f_show_message_001() --����������� �������� f_check_touch_gate(hero)
	MessageBox("/Maps/Scenario/A2C3M3/message_001.txt");
end;

function f_show_message_002() -- ����������� ��������� Trigger(REGION_ENTER_AND_STOP_TRIGGER, "Warning_zone2", "f_show_message_002")
	Trigger(REGION_ENTER_AND_STOP_TRIGGER, "Warning_zone2", nil);
	MessageBox("/Maps/Scenario/A2C3M3/message_002.txt");
end;

function f_show_message_003() --����������� ��������� Trigger(REGION_ENTER_AND_STOP_TRIGGER, "About_Block_player_zone", "f_show_message_003") -- �������������! � ����� ��������� Trigger(OBJECT_TOUCH_TRIGGER, OBJECT_ONE_WAY_TELEPORT_AI, "f_show_message_003"); � �������� f_one_way_teleport_blocked
	MessageBox("/Maps/Scenario/A2C3M3/message_003.txt");
end;

function f_show_message_004() --����������� ��������� Trigger(REGION_ENTER_AND_STOP_TRIGGER, "Dragon_hall_zone", "f_show_message_004")
	Trigger(REGION_ENTER_AND_STOP_TRIGGER, "Dragon_hall_zone", nil);
	OpenCircleFog(16, 78, 1, 4, 1);
	sleep(2);
	MoveCamera(16, 78, 1, 30, 1, 3.14, 0, 0, 1);
	MessageBox("/Maps/Scenario/A2C3M3/message_004.txt");
end;

function f_show_message_005() --����������� ��������� Trigger(REGION_ENTER_AND_STOP_TRIGGER, "Warning_zone", "f_show_message_005")
	Trigger(REGION_ENTER_AND_STOP_TRIGGER, "Warning_zone", nil);
	OpenCircleFog(77, 67, 1, 5, 1);
	sleep(2);
	MoveCamera(77, 67, 1, 30, 1, 0, 0, 0, 1);
	MessageBox("/Maps/Scenario/A2C3M3/message_005.txt");
end;

function f_show_message_006() --����������� �������� f_check_touch_gate(hero)
	MessageBox("/Maps/Scenario/A2C3M3/message_006.txt");
end;

function f_show_message_007() --����������� �������� f_check_touch_gate(hero)
	MessageBox("/Maps/Scenario/A2C3M3/message_007.txt");
end;

function f_show_message_008() --����������� �������� f_pri4_success(hero)
	MessageBox("/Maps/Scenario/A2C3M3/message_008.txt");
end;


function ShowMessage_ZehirMustFindDragon( heroName )
	MessageBox("/Maps/Scenario/A2C3M3/message_007.txt");
end;

function SubTerrainEntranceInteract( heroName )
	if heroName==WULFSTAN then
		MessageBox("/Maps/Scenario/A2C3M3/message_001.txt");
	else
		if heroName~=HERO_PLAYER then
			MessageBox("/Maps/Scenario/A2C3M3/message_006.txt");
		end;
	end;
end;
---------------------------------------------------
--*-- GAMEPLAY FUNCTIONS --*--
---------------------------------------------------

if GetDifficulty() == DIFFICULTY_EASY then
	print ("easy");
	AddHeroCreatures( HERO_PLAYER, CREATURE_ARCH_MAGI, 10 );
	AddHeroCreatures( HERO_PLAYER, CREATURE_GENIE, 5 );
	AddHeroCreatures( HERO_PLAYER, CREATURE_RAKSHASA_KSHATRI, 3 );
end;
if GetDifficulty() == DIFFICULTY_NORMAL then
	print ("normal");
	AddHeroCreatures( HERO_PLAYER, CREATURE_ARCH_MAGI, 7 );
	AddHeroCreatures( HERO_PLAYER, CREATURE_GENIE, 4 );
	AddHeroCreatures( HERO_PLAYER, CREATURE_RAKSHASA_KSHATRI, 2 );
end;
if GetDifficulty() == DIFFICULTY_HARD then
	print ("hard");
	AddHeroCreatures( HERO_PLAYER, CREATURE_ARCH_MAGI, 4 );
	AddHeroCreatures( HERO_PLAYER, CREATURE_RAKSHASA_KSHATRI, 1 );
end;
if GetDifficulty() == DIFFICULTY_HEROIC then
	print ("heroic");
end;

function f_difficulty_easy()
	difficulty = 0;
		if (GetDate( DAY ) == 2) then	
			DeployReserveHero(ENEMY_HERO1, 67, 64, 1);
			sleep(4);
			ChangeHeroStat(ENEMY_HERO1, STAT_EXPERIENCE, 1000);
		end;
		if (GetDate( DAY ) == 8) then
			DeployReserveHero(ENEMY_HERO2, 67, 64, 1);
			sleep(4);
			ChangeHeroStat(ENEMY_HERO2, STAT_EXPERIENCE, 3000);
		end;
		if (GetDate( DAY ) == 20) then
			DeployReserveHero(ENEMY_HERO3, 67, 64, 1);			
			Trigger(NEW_DAY_TRIGGER, nil);
			sleep(4);
			ChangeHeroStat(ENEMY_HERO3, STAT_EXPERIENCE, 5000);
			sleep(6);
			Trigger(NEW_DAY_TRIGGER, "f_born_enemy_heroes_later");
		end;
end;

function f_difficulty_normal()
	difficulty = 1;
		if (GetDate( DAY ) == 2) then	
			DeployReserveHero(ENEMY_HERO1, 67, 64, 1);
			sleep(4);
			ChangeHeroStat(ENEMY_HERO1, STAT_EXPERIENCE, 5000);
		end;
		if (GetDate( DAY ) == 8) then
			DeployReserveHero(ENEMY_HERO2, 67, 64, 1);
			sleep(4);
			ChangeHeroStat(ENEMY_HERO2, STAT_EXPERIENCE, 20000);
		end;
		if (GetDate( DAY ) == 20) then
			DeployReserveHero(ENEMY_HERO3, 67, 64, 1);			
			Trigger(NEW_DAY_TRIGGER, nil);
			sleep(4);
			ChangeHeroStat(ENEMY_HERO3, STAT_EXPERIENCE, 50000);
			sleep(6);
			Trigger(NEW_DAY_TRIGGER, "f_born_enemy_heroes_later");
		end;
end;

function f_difficulty_hard()
	difficulty = 2;
		if (GetDate( DAY ) == 2) then	
			DeployReserveHero(ENEMY_HERO3, 67, 64, 1);
			sleep(4);
			ChangeHeroStat(ENEMY_HERO3, STAT_EXPERIENCE, 30000);
		end;
		if (GetDate( DAY ) == 8) then
			DeployReserveHero(ENEMY_HERO1, 67, 64, 1);
			sleep(4);
			ChangeHeroStat(ENEMY_HERO1, STAT_EXPERIENCE, 200000);
		end;
		if (GetDate( DAY ) == 20) then
			DeployReserveHero(ENEMY_HERO2, 67, 64, 1);			
			Trigger(NEW_DAY_TRIGGER, nil);
			sleep(4);
			ChangeHeroStat(ENEMY_HERO2, STAT_EXPERIENCE, 300000);
			sleep(6);
			Trigger(NEW_DAY_TRIGGER, "f_born_enemy_heroes_later");
		end;
end;

function f_difficulty_heroic()
	difficulty = 3;
		if (GetDate( DAY ) == 2) then	
			DeployReserveHero(ENEMY_HERO2, 67, 64, 1);
			sleep(4);
			ChangeHeroStat(ENEMY_HERO2, STAT_EXPERIENCE, 50000);
		end;
		if (GetDate( DAY ) == 8) then
			DeployReserveHero(ENEMY_HERO3, 67, 64, 1);
			sleep(4);
			ChangeHeroStat(ENEMY_HERO3, STAT_EXPERIENCE, 70000);
		end;
		if (GetDate( DAY ) == 20) then
			DeployReserveHero(ENEMY_HERO1, 67, 64, 1);			
			Trigger(NEW_DAY_TRIGGER, nil);
			sleep(4);
			ChangeHeroStat(ENEMY_HERO1, STAT_EXPERIENCE, 400000);
			sleep(6);
			Trigger(NEW_DAY_TRIGGER, "f_born_enemy_heroes_later");
		end;
end;





function f_born_enemy_heroes_later() --����������� ��������� Trigger(NEW_DAY_TRIGGER, "f_born_enemy_heroes_later")
	if (GetDate( DAY_OF_WEEK ) == 1) and (IsHeroAlive( ENEMY_HERO1 ) ~= true) then
		DeployReserveHero(ENEMY_HERO1, 67, 64, 1);
	end;
	if (GetDate( DAY_OF_WEEK ) == 3) and (IsHeroAlive( ENEMY_HERO2 ) ~= true) then
		DeployReserveHero(ENEMY_HERO2, 67, 64, 1);
	end;
	if (GetDate( DAY_OF_WEEK ) == 7) and (IsHeroAlive( ENEMY_HERO3 ) ~= true) then
		DeployReserveHero(ENEMY_HERO3, 67, 64, 1);
	end;
end;

function DeployRolf()
	BlockGame();
	Trigger( REGION_ENTER_AND_STOP_TRIGGER, "BorderGuard_area", nil );
	SetObjectPosition( HERO_ROLF, 13, 81, GROUND );
	sleep(2);
	StartAdvMapDialog( ADVMAPSCENE_MEET_ROLF );
	UnblockGame();
	SetObjectiveState( "pri5", OBJECTIVE_ACTIVE );
	startThread( prim5_KillRolf_Completed );
end;

function prim5_KillRolf_Completed()
	repeat sleep(1); until IsHeroAlive( HERO_ROLF )==nil;
	SetObjectiveState( "pri5", OBJECTIVE_COMPLETED );
end;

function ShowMessageWhenZehirExitsUnderground()
	repeat sleep(1); x,y,floor=GetObjectPosition( HERO_PLAYER ); until floor == GROUND;
	sleep(5);
	MessageBox("/Maps/Scenario/A2C3M3/message_007.txt");
end;

function DeployRolfIfBorderGuardOpened()
	repeat sleep(1); until IsObjectExists("BorderGuard")==nil;
	BlockGame();
	SetObjectPosition( HERO_ROLF, 13, 81, GROUND );
	sleep(1);
	StartAdvMapDialog( ADVMAPSCENE_MEET_ROLF );
	UnblockGame();
	SetObjectiveState( "pri5", OBJECTIVE_ACTIVE );
	startThread( prim5_KillRolf_Completed );
end;

function ShowMessageOnlyZehirCanPass( heroName )
	if heroName ~= "Zehir" then
		MessageBox( PATH.."MsgBox_OnlyZehirCanEnterGate.txt" );
	end;
end;

function ReturnWulfstanToUnderground()
	while IsHeroAlive( WULFSTAN )==true do
		repeat 
			sleep(1); 
			if IsHeroAlive( WULFSTAN )==true then
				x,y,floor = GetObjectPosition( WULFSTAN );
			else
				return
			end;
		until floor == GROUND;
		
		if length(GetObjectsInRegion( "teleport_to_wulfstan_town", OBJECT_HERO )) == 0 then
			reg_x, reg_y = RegionToPoint( "teleport_to_wulfstan_town" );
		else
			reg_x, reg_y = RegionToPoint( "teleport_to_wulfstan_town_2" );
		end;
		SetObjectPosition( WULFSTAN, reg_x, reg_y, UNDERGROUND );
		sleep(1);
		PlayVisualEffect( EFFECT_TOWNPORTAL_END, WULFSTAN );
	end;
end;
--*---------------------------------------------------------------------------------------------*--
--*--------------------------- ANIMATIONS AND EFFECTS -------------------------*--
--*---------------------------------------------------------------------------------------------*--

---------------------------------------------------------------------------------------------------
--------------------------------------- MAIN --------------------------------------------------
---------------------------------------------------------------------------------------------------

--*--- Starting Cutscene  ---*--
StartAdvMapDialog( ADVMAPSCENE_MISSION_START  );

--*-- TRIGGERS --*--
Trigger(PLAYER_REMOVE_HERO_TRIGGER, 1, "f_check_fail_hero");
Trigger(PLAYER_REMOVE_HERO_TRIGGER, 2, "f_check_fail_hero");
Trigger(OBJECT_CAPTURE_TRIGGER, OBJECT_HOME_TOWN, "f_check_fail_hero");

Trigger(OBJECT_TOUCH_TRIGGER, OBJECT_TELEPORT_TO_DRAGON, "f_pri4_success");

--Trigger(REGION_ENTER_AND_STOP_TRIGGER, "Checker", "f_check_teleport_up");
--Trigger(REGION_ENTER_WITHOUT_STOP_TRIGGER, "Unblocker", "f_check_teleport_up_from");
Trigger(REGION_ENTER_AND_STOP_TRIGGER, "Block_player_zone", "f_one_way_teleport_blocked");
Trigger(REGION_ENTER_AND_STOP_TRIGGER, "Warning_zone", "f_show_message_005");
Trigger(REGION_ENTER_AND_STOP_TRIGGER, "Warning_zone2", "f_show_message_002");
Trigger(REGION_ENTER_AND_STOP_TRIGGER, "ShrineRegion", "PlayVoiceoverIfZehirNearShrine");

--Trigger( REGION_ENTER_WITHOUT_STOP_TRIGGER, "Ai_block_zone2", "BlockGateIfHeroNotZehir" );
Trigger( REGION_ENTER_WITHOUT_STOP_TRIGGER, "Ai_block_zone2", "PlayVoiceoverIfZehirNearExit" );
Trigger( OBJECT_TOUCH_TRIGGER, OBJECT_SUB_GATE_EXIT_HOME, "SubTerrainEntranceInteract" );
--Trigger( REGION_ENTER_WITHOUT_STOP_TRIGGER, "Unblocker", "BlockUndergroundExit" );
--Trigger(REGION_ENTER_AND_STOP_TRIGGER, "Dragon_hall_zone", "f_show_message_004");

--Trigger( REGION_ENTER_AND_STOP_TRIGGER, "BorderGuard_area", "DeployRolf" );
startThread( DeployRolfIfBorderGuardOpened );
Trigger( REGION_ENTER_AND_STOP_TRIGGER, "Zehir_GateAlert", "ShowMessage_ZehirMustFindDragon");

SetRegionAutoObjectEnable( "check1b", REGION_AUTOACTION_ON_ENTER, -1, PLAYER_1, "", OBJECT_SUB_GATE_EXIT_HOME, 0 );
SetRegionAutoObjectEnable( "check1b", REGION_AUTOACTION_ON_EXIT,  -1, PLAYER_1, "", OBJECT_SUB_GATE_EXIT_HOME, 1 );
SetRegionAutoObjectEnable( "check1b", REGION_AUTOACTION_ON_ENTER, -1, PLAYER_1, HERO_PLAYER, OBJECT_SUB_GATE_EXIT_HOME, -1 );
SetRegionAutoObjectEnable( "check1b", REGION_AUTOACTION_ON_EXIT,  -1, PLAYER_1, HERO_PLAYER, OBJECT_SUB_GATE_EXIT_HOME, -1 );


SetRegionAutoObjectEnable( "shrine_blocker", REGION_AUTOACTION_ON_ENTER,  -1, PLAYER_1, HERO_PLAYER, "BorderGuard", 1 );
SetRegionAutoObjectEnable( "shrine_blocker", REGION_AUTOACTION_ON_EXIT,  -1, PLAYER_1, HERO_PLAYER, "BorderGuard", 0 );
Trigger( OBJECT_TOUCH_TRIGGER, "BorderGuard", "ShowMessageOnlyZehirCanPass" );
--*-- PRIMARY QUESTS TRIGGERS --*--

--*-- SECONDARY QUESTS TRIGGERS --*--

--*-- MISC ACTIONS TRIGGERS --*--

--*-- GATES TRIGGERS --*--

--Starter

if GetDifficulty() == DIFFICULTY_EASY then
	Trigger(NEW_DAY_TRIGGER, "f_difficulty_easy");
end;
if GetDifficulty() == DIFFICULTY_NORMAL then
	Trigger(NEW_DAY_TRIGGER, "f_difficulty_normal");
end;
if GetDifficulty() == DIFFICULTY_HARD then
	Trigger(NEW_DAY_TRIGGER, "f_difficulty_hard");
end;
if GetDifficulty() == DIFFICULTY_HEROIC then
	Trigger(NEW_DAY_TRIGGER, "f_difficulty_heroic");
end;

startThread( f_pri1 );
startThread( f_pri2 );
startThread( f_pri3 );
startThread( f_pri4 );
startThread( f_open_fog_start );
startThread( PlayVoiceoverIfZehirExitUnderground );
startThread( PlayVoiceoverIfZehirHasKey );
startThread( ReturnWulfstanToUnderground );
--startThread( ShowMessageWhenZehirExitsUnderground );

--TeachHeroSpell( WULFSTAN, SPELL_TOWN_PORTAL );

--*-- END OF FILE --*--