-------------------------------------------------------------------
----------------- TITLE -------------------------------------------
-------------------------------------------------------------------
--       Creation Date: 23.10.06
--              Author: Ivan Myakishev
--       Author e-mail: Ivan Myakishev@nival.com
--        Project Name: H5A2
--            Map Name: A2S1
--  Script Description: MapScript
 --------------------------------------------------------------------
 --------------------------------------------------------------------


--------------------------------------------------------------------
----------------- CONSTANT -----------------------------------------
--------------------------------------------------------------------
VOICEOVER_FIRST_EMPRY_CHEST = "/Maps/SingleMissions/A2S1/SM1_VO2_Kunyak_01sound.xdb#xpointer(/Sound)";
VOICEOVER_SECOND_EMPRY_CHEST = "/Maps/SingleMissions/A2S1/SM1_VO3_Kunyak_01sound.xdb#xpointer(/Sound)";
VOICEOVER_APPROACH_CUP_OF_RAIN_ISLAND = "/Maps/SingleMissions/A2S1/SM1_VO4_Kunyak_01sound.xdb#xpointer(/Sound)";
VOICEOVER_CUP_OF_RAIN_FOUND = "/Maps/SingleMissions/A2S1/SM1_VO5_Kunyak_01sound.xdb#xpointer(/Sound)";
VOICEOVER_APPROACH_PRISON_ISLAND = "/Maps/SingleMissions/A2S1/SM1_VO6_Kunyak_01sound.xdb#xpointer(/Sound)";
VOICEOVER_MISSION_START = "/Maps/SingleMissions/A2S1/SM1_VO1_Kunyak_01sound.xdb#xpointer(/Sound)";

ADVMAPSCENE_KUNYAK_LIBERATE_HERO = 0;
ADVMAPSCENE_KUNYAK_SPEAKS_WITH_GOBLINS = 1;
ADVMAPSCENE_KUNYAK_FREES_SHAMAN = 2;


HERO_NAME = "Hero4"; -- ��������� ��� ����� �������� ����� 
LEVELS = 7; 
START_ATTACK = 130 - GetDifficulty()*15; -- ��������� ��� ������� ����� ���������� ����� (���������� ����)
HAVEN_HEROES = {"Maeve", "Christian", "Brem", "Orrin", "Ving", "Sarge"}; -- ������ ������ ����� ���������
HAVEN_HEROES.n = length( HAVEN_HEROES ); -- ����� ������� ������ ����� ���������
IMPRISONED_HERO = "Hero6" -- ��������� ��� ����� �����, ������� ����� � ������ �� ������� � ���������� ��� "������������" ���������������� ���������
CHEST_ARTIFACTS = {	ARTIFACT_SWORD_OF_RUINS, 
					ARTIFACT_GREAT_AXE_OF_GIANT_SLAYING,
					ARTIFACT_RING_OF_HASTE,
					ARTIFACT_DRAGON_EYE_RING,
					ARTIFACT_MOONBLADE,
					ARTIFACT_OGRE_CLUB,
					ARTIFACT_OGRE_SHIELD,
					ARTIFACT_RUNIC_WAR_AXE,
					ARTIFACT_RUNIC_WAR_HARNESS,
					ARTIFACT_DWARVEN_SMITHY_HUMMER,
					ARTIFACT_TREEBORN_QUIVER,
					ARTIFACT_DRAGON_SCALE_ARMOR
					};
TOWNS = {   "main_orcish_town",
			"west_orcish_town",
			"east_orcish_town",
			"north_east_orcish_town",
			"south_east_orcish_town",
			"academy_town1",
			"academy_town2",
			"heaven_town"
		};
TOWNS.n = length( TOWNS );


--------------------------------------------------------------------
----------------- VARIABLE DATA  -----------------------------------
--------------------------------------------------------------------
cupOfRain = "cupOfRain"..(1+random(12)); -- ���������� ��� ����� ���������. �������� ���������� ��������� �������.
isElementalsKilled = 0; -- ���������� ��� ��������� "Sec3_kill_waterElementals". 1 - ���������� ����������, 0 - ���
isMonstersKilled = 0; -- ���������� ��� ��������� "Sec1_killMonsters". 1 - ������� � ���������� ����������, 0 - ���
isImperialAttackStarted = 0; -- 1 - ����� ����� (START_ATTACK > 84) � ��������� ���� ��������� �� �����. 0 - ����� ��� �� �����.
isImperialFleetDeployed = 0;
finderHero = HERO_NAME; -- ���������� ��� ����� �����, ��������� �������� Cup of Rain
current_chest_id  = 0;
isAllEnemiesDefeated = 0;
isOkPressed = 0;
ShamanGuardToucher = nil;

print("Cup of Rain is ", cupOfRain);

SCENE_MISSION_START = "/DialogScenes/A2Single/SM1/S1/DialogScene.xdb#xpointer(/DialogScene)";
SCENE_MISSION_END = "/DialogScenes/A2Single/SM1/S2/DialogScene.xdb#xpointer(/DialogScene)";


for i=0, 12 do
	PlayVisualEffect("/Effects/_(Effect)/Artefacts/General/Blue.xdb#xpointer(/Effect)", "cupOfRain"..i, "cupOfRain"..i.."Effect" );
end;

--------------------------------------------------------------------
----------------- START MAP SETTINGS -------------------------------
--------------------------------------------------------------------
StartDialogScene( SCENE_MISSION_START );

PlayVisualEffect( "/Effects/_(Effect)/Characters/Creatures/Neutral/WaterElemental/idle00.xdb#xpointer(/Effect)", "", "elementals", 154, 36, 0, 0, GROUND);
PlayVisualEffect( "/Effects/_(Effect)/Characters/Creatures/Neutral/WaterElemental/idle00.xdb#xpointer(/Effect)", "", "elementals", 153, 34, 0, 0, GROUND);
PlayVisualEffect( "/Effects/_(Effect)/Characters/Creatures/Neutral/WaterElemental/idle00.xdb#xpointer(/Effect)", "", "elementals", 156, 35, 0, 0, GROUND);
SetObjectEnabled( cupOfRain, nil);
SetObjectEnabled( "butar", nil );
SetObjectEnabled( "butar_hut", nil );
SetObjectEnabled( "fisher", nil );
SetObjectEnabled( "fisher_hut", nil );
SetRegionBlocked ( "water_elementals", 1, PLAYER_2 );
SetRegionBlocked ( "water_elementals", 1, PLAYER_3 );
SetRegionBlocked ( "shaman_gate", 1, PLAYER_2 );
SetRegionBlocked ( "shaman_gate", 1, PLAYER_3 );
SetRegionBlocked ( "cup1", 1, PLAYER_2 );
SetRegionBlocked ( "cup2", 1, PLAYER_2 );
SetRegionBlocked ( "cup3", 1, PLAYER_2 );
SetRegionBlocked ( "cup1", 1, PLAYER_3 );
SetRegionBlocked ( "cup2", 1, PLAYER_3 );
SetRegionBlocked ( "cup3", 1, PLAYER_3 );
SetRegionBlocked ( "fisher_region", 1, PLAYER_2 );
SetRegionBlocked ( "fisher_region", 1, PLAYER_3 );
SetRegionBlocked ( "prison", 1, PLAYER_2 );
SetRegionBlocked ( "prison", 1, PLAYER_3 );
SetPlayerHeroesCountNotForHire( PLAYER_2, 6 );
MakeHeroReturnToTavernAfterDeath( "Nathaniel", true, 1 );

AllowPlayerTavernRace( PLAYER_1, TOWN_INFERNO, 0 );
AllowPlayerTavernRace( PLAYER_1, TOWN_ACADEMY, 0 );
AllowPlayerTavernRace( PLAYER_1, TOWN_HEAVEN, 0 );
AllowPlayerTavernRace( PLAYER_1, TOWN_NECROMANCY, 0 );
AllowPlayerTavernRace( PLAYER_1, TOWN_PRESERVE, 0 );
AllowPlayerTavernRace( PLAYER_1, TOWN_FORTRESS, 0 );
AllowPlayerTavernRace( PLAYER_1, TOWN_DUNGEON, 0 );

--AllowPlayerTavernRace( PLAYER_2, TOWN_INFERNO, 0 );
--AllowPlayerTavernRace( PLAYER_2, TOWN_STRONGHOLD, 0 );
--AllowPlayerTavernRace( PLAYER_3, TOWN_INFERNO, 0 );
--AllowPlayerTavernRace( PLAYER_3, TOWN_STRONGHOLD, 0 );

--Difficulty dependencies
if GetDifficulty()==DIFFICULTY_EASY then
	SetTownBuildingLimitLevel( "academy_town1", TOWN_BUILDING_DWELLING_7, 0 );
	SetTownBuildingLimitLevel( "academy_town2", TOWN_BUILDING_DWELLING_7, 0 );
	SetTownBuildingLimitLevel( "heaven_town", TOWN_BUILDING_DWELLING_7, 0 );
	SetTownBuildingLimitLevel( "academy_town1", TOWN_BUILDING_DWELLING_6, 0 );
	SetTownBuildingLimitLevel( "academy_town2", TOWN_BUILDING_DWELLING_6, 0 );
	SetTownBuildingLimitLevel( "heaven_town", TOWN_BUILDING_DWELLING_6, 0 );
	SetTownBuildingLimitLevel( "academy_town1", TOWN_BUILDING_FORT, 1 );
	SetTownBuildingLimitLevel( "academy_town2", TOWN_BUILDING_FORT, 1 );
	SetTownBuildingLimitLevel( "heaven_town", TOWN_BUILDING_FORT, 1 );
	AddHeroCreatures( HERO_NAME, CREATURE_GOBLIN, 100 );
	AddHeroCreatures( HERO_NAME, CREATURE_SHAMAN, 30 );
	AddHeroCreatures( HERO_NAME, CREATURE_ORCCHIEF_BUTCHER, 4 );
	print( "Difficulty level is EASY" );
	diff=0;
elseif 	GetDifficulty()==DIFFICULTY_NORMAL then
	SetTownBuildingLimitLevel( "academy_town1", TOWN_BUILDING_DWELLING_7, 0 );
	SetTownBuildingLimitLevel( "academy_town2", TOWN_BUILDING_DWELLING_7, 0 );
	SetTownBuildingLimitLevel( "heaven_town", TOWN_BUILDING_DWELLING_7, 0 );
	SetTownBuildingLimitLevel( "academy_town1", TOWN_BUILDING_FORT, 2 );
	SetTownBuildingLimitLevel( "academy_town2", TOWN_BUILDING_FORT, 2 );
	SetTownBuildingLimitLevel( "heaven_town", TOWN_BUILDING_FORT, 2 );
	AddHeroCreatures( HERO_NAME, CREATURE_GOBLIN, 50 );
	AddHeroCreatures( HERO_NAME, CREATURE_SHAMAN, 15 );
	print( "Difficulty level is NORMAL" );
	diff=1;
elseif 	GetDifficulty()==DIFFICULTY_HARD then
	print( "Difficulty level is HARD" );
	diff=2;
elseif 	GetDifficulty()==DIFFICULTY_HEROIC then
	print( "Difficulty level is HEROIC" );
	diff=3;
end;

SetObjectiveState( "prim2_DestroyHavenFleet", OBJECTIVE_ACTIVE );
sleep(1);
SetObjectiveState( "prim3_findCupOfRain", OBJECTIVE_ACTIVE );
DenyAIHeroFlee( HERO_NAME, true );

--------------------------------------------------------------------
----------------- FUNCTIONS BODY -----------------------------------
--------------------------------------------------------------------


function Destination( object1, object2 )
		obj1_x, obj1_y, obj1_z = GetObjectPosition( object1 );
		obj2_x, obj2_y, obj2_z = GetObjectPosition( object2 );
		dest = sqrt( ( obj1_x - obj2_x )*( obj1_x - obj2_x ) + ( obj1_y - obj2_y )*( obj1_y - obj2_y ) );
	return dest;
end;

function RemoveCupOfRainEffects( heroName, objectName )
	StopVisualEffects(objectName.."Effect");
	current_chest_id = current_chest_id + 1;
	GiveArtefact( heroName, CHEST_ARTIFACTS[current_chest_id] );
	if objectName ~= cupOfRain then
		Play2DSound( VOICEOVER_SECOND_EMPRY_CHEST );
	end;
end;
------------------------------------------------------------------------
--     Function Name: CloserOrfurtherNotification() 
--     Description: ������� ���������, ���� ������� ����� ���������� �����/������ �� ��������� Cup of rain
------------------------------------------------------------------------
function CloserOrfurtherNotification()
	print("funstion CloserOrfurtherNotification has started...");
	sleep(3);
	initialDestination = Destination( cupOfRain, HERO_NAME );
	step = LEVELS; -- ���������� �������, ��� ����������� �������, ��������� ���������
	print( "Initial Destination = ", initialDestination );
	print( "step = ", step );
	while IsHeroAlive( HERO_NAME )==true and IsObjectExists( cupOfRain )==true do
		while IsHeroAlive( HERO_NAME )==true and IsObjectExists( cupOfRain )==true do
			currentDestination = Destination( cupOfRain, HERO_NAME );
			if currentDestination < ( initialDestination * step )/(LEVELS+1) then -- ���� ���������� ������ ��� ������� �����
				step = step - 1; -- ������� � �������� ���������� (����� �������� � ���������) ������
				ShowFlyingSign("Maps/SingleMissions/A2S1/FlyingMessage_IsCloser.txt", HERO_NAME, PLAYER_1, 3);
				print("HOT. We are closer to cupOfRain. step = ",step,"cur.Destination = ", currentDestination, "nxtStep = ",( initialDestination * step )/(LEVELS+1));
				break;
			end;
			if currentDestination > ( initialDestination * (step+1) )/(LEVELS+1) and currentDestination < initialDestination then -- ���� ���������� ����� ������, ��� ���������� �����
				step = step + 1; -- ������� � �������� ����������� (����� �������� �� ���������) ������
				ShowFlyingSign("Maps/SingleMissions/A2S1/FlyingMessage_IsFurther.txt", HERO_NAME, PLAYER_1, 3);
				print("COLD. We are further to cupOfRain. step = ",step,"cur Destination = ", currentDestination,"prvStep = ",( initialDestination * step+1 )/(LEVELS+1));
				break;
			end;
			sleep(1);
		end;
		sleep(1);
	end;
	print("Cup of Rain is found or main hero is dead. Function CloserOrfurtherNotification terminated...");
end;


------------------------------------------------------------------------
--     Function Name: show_fakeCupOfRain() 
--     Description: ���������� ������ �������������� ������� ��������� cup of rain
------------------------------------------------------------------------
function show_fakeCupOfRain( heroName )
	if IsHeroAlive( IMPRISONED_HERO ) == true then
		StartAdvMapDialog( ADVMAPSCENE_KUNYAK_LIBERATE_HERO, "IsOkPressed" );
		--MessageBox( "Maps/SingleMissions/A2S1/MsgBox_ImprisonedHeroThx.txt", "IsOkPressed"  );
		while isOkPressed == 0 do sleep(1); end;
		print( "Hero ", IMPRISONED_HERO, " is liberated!!!" );
		Trigger( OBJECT_TOUCH_TRIGGER, "prison", nil );
		if IsObjectExists("fake") == true then
			local x_chest, y_chest, floor_chest = GetObjectPosition( "fake" );
			local x_hero, y_hero, floor_hero = GetObjectPosition( heroName );
			
			OpenCircleFog( x_chest, y_chest, floor_chest, 10, PLAYER_1);
			MoveCamera( x_chest, y_chest, floor_chest, 50, 1.2, 0, 0, 0, 1);
			sleep(15);
			MoveCamera( x_hero, y_hero, floor_hero, 50, 1.2, 0, 0, 0, 1);
			Trigger(OBJECT_TOUCH_TRIGGER, "fake", "Is_fakeCupOfRain_found" );
			print("trigger started");
		end;
	end;
end;

function IsOkPressed()
	isOkPressed = 1;
end;


------------------------------------------------------------------------
--     Function Name: Is_fakeCupOfRain_found() 
--     Description: ��� ������ ������� ������ �������� �������� pedant of mastery (������ cup of rain)
------------------------------------------------------------------------
function Is_fakeCupOfRain_found( heroName )
	GiveArtefact( heroName, ARTIFACT_PEDANT_OF_MASTERY );
	Play2DSound( VOICEOVER_FIRST_EMPRY_CHEST );
end;


function StartGoblinsQuestScene()
	StartAdvMapDialog( ADVMAPSCENE_KUNYAK_SPEAKS_WITH_GOBLINS, "Sec1_killMonsters" );
end;

------------------------------------------------------------------------
--     Function Name: Sec1_killMonsters( heroName ) 
--     Description: ��������� ������� "����� ������" � ������ ������ ������� "������ ������"
------------------------------------------------------------------------	
function Sec1_killMonsters()
	Trigger( REGION_ENTER_AND_STOP_TRIGGER, "shaman_gate", nil );
	Trigger( OBJECT_TOUCH_TRIGGER, "butar", "ButarAnswers" );
	--MessageBox("Maps/SingleMissions/A2S1/MessageBox_butarQuest.txt");
	SetObjectiveState( "sec2_HelpButar", OBJECTIVE_ACTIVE);
	startThread( IfGoblinsQuestCompleted );
end;

------------------------------------------------------------------------
--     Function Name: ButarAnswers()
--     Description: ��� �������������� � �������, ���� ������� �� ���������, ������ ���� �� �������������, ���� ��������� ��������� ���
--					� ��������� ������� "CloserOrfurtherNotification()"
------------------------------------------------------------------------
function ButarAnswers()
	MessageBox( "Maps/SingleMissions/A2S1/MsgBox_Butar1.txt" );
end;

function ShamanGuardTouched(heroName)
	ShamanGuardToucher = heroName;
end;
------------------------------------------------------------------------
--     Function Name: IsButarQestCompleted() 
--     Description: ���� ��� ������� � ���������� ����� ����������� isMonstersKilled = 1
------------------------------------------------------------------------
function IfGoblinsQuestCompleted()
	while  IsObjectExists( "shaman_guard")==true do	sleep(1); end;
	StartAdvMapDialog( ADVMAPSCENE_KUNYAK_FREES_SHAMAN, "CompleteGoblinsQuest" );
end;

function CompleteGoblinsQuest()
	if GetObjectiveState( "sec2_HelpButar" ) == OBJECTIVE_UNKNOWN then
		SetObjectiveState( "sec2_HelpButar", OBJECTIVE_ACTIVE);
		sleep (1);
	end;
	SetObjectiveState( "sec2_HelpButar", OBJECTIVE_COMPLETED );
	startThread( CloserOrfurtherNotification );
	isMonstersKilled = 1;
	SetObjectEnabled( "butar", true );
	Trigger( OBJECT_TOUCH_TRIGGER, "butar", nil );
	if ShamanGuardToucher ~= nil then
		TeachHeroSpell( ShamanGuardToucher, SPELL_SUMMON_CREATURES );
	end;
	--MessageBox("Maps/SingleMissions/A2S1/MsgBox_ShamanThx.txt");
	print("All monsters are killed.");
end;

------------------------------------------------------------------------
--     Function Name: RazeButarHut() 
--     Description: ��� �������������� � ������� ������ ������� ��� � �����
------------------------------------------------------------------------
function RazeButarHut( heroName, objectName )
	MessageBox( "Maps/SingleMissions/A2S1/MsgBox_nobodyHome.txt" );
	--PlayVisualEffect( "/Effects/_(Effect)/Buildings/Capture/Start_dust_S.xdb#xpointer(/Effect)", objectName);
	--sleep(10);
	--PlayVisualEffect( "/Effects/_(Effect)/Characters/Heroes/DemonLord/Path/Level_2b.xdb#xpointer(/Effect)", objectName);
	--RazeBuilding( "butar_hut" );
end;


------------------------------------------------------------------------
--     Function Name: Sec3_kill_waterElementals() 
--     Description: ��������� ������� "���������� ������� �����������" � ������ ������ �������� golden sextant
------------------------------------------------------------------------	
function Sec3_kill_waterElementals( heroName )
	Trigger( OBJECT_TOUCH_TRIGGER, "fisher", nil );
	SetObjectiveState( "sec3_KillWaterElementals", OBJECTIVE_ACTIVE );
	if isElementalsKilled == 0 then -- ���� ����� ��� �� ��������� ������� �����������
		Trigger( OBJECT_TOUCH_TRIGGER, "fisher", "Fisher_answers" ); -- ���� ��� ������� ������, �� ������������ �� ��������� �� ��� ��� �������?
		x_hero, y_hero, floor_hero = GetObjectPosition( heroName ); 
		OpenCircleFog( 155, 35, GROUND, 10, PLAYER_1);
		MoveCamera( 155, 35, GROUND, 50, 1.2, 0, 0, 0, 1); -- ���������� ����� ��� ��������� ����������
		sleep(15);
		MoveCamera( x_hero, y_hero, floor_hero, 50, 1.2, 0, 0, 0, 1); -- ���������� ������ �����
	else
		Trigger( OBJECT_TOUCH_TRIGGER, "fisher", "KillFisher" );
		Trigger( OBJECT_TOUCH_TRIGGER, "fisher_hut", "RazeHut" );
		SetObjectiveState( "sec3_KillWaterElementals", OBJECTIVE_ACTIVE );
		sleep(1);
		SetObjectiveState( "sec3_KillWaterElementals", OBJECTIVE_COMPLETED );
		sleep(1);
		MessageBox("Maps/SingleMissions/A2S1/MessageBox_FisherThx.txt");
		GiveArtefact( heroName, ARTIFACT_GOLDEN_SEXTANT );
	end;
end;


------------------------------------------------------------------------
--     Function Name: Fisher_answers() 
--     Description: ������ ����������� ��� �������������� � ������� ���� ��� ������� �� ���������
------------------------------------------------------------------------	
function Fisher_answers( heroName )
	if isElementalsKilled==0 then
		MessageBox("Maps/SingleMissions/A2S1/MessageBox_fisherAnswer.txt");
	else
		Trigger( OBJECT_TOUCH_TRIGGER, "fisher", "KillFisher" );
		Trigger( OBJECT_TOUCH_TRIGGER, "fisher_hut", "RazeHut" );
		SetObjectiveState( "sec3_KillWaterElementals", OBJECTIVE_COMPLETED );
		GiveArtefact( heroName, ARTIFACT_GOLDEN_SEXTANT );
	end;
end;


------------------------------------------------------------------------
--     Function Name: IsInWaterElementalsRegion() 
--     Description: �������� ������ � �������� ������������, ���� ����� ������ ����� � ������ "water_elementals"
------------------------------------------------------------------------	
function IsInWaterElementalsRegion( heroName )
	Trigger( REGION_ENTER_AND_STOP_TRIGGER, "water_elementals", nil );
	StopVisualEffects("elementals");
	sleep(3);
	PlayVisualEffect( "/Effects/_(Effect)/Spells/SummonElementals/Water.xdb#xpointer(/Effect)", "", "elementals", 135, 35, 0, 0, GROUND);
	sleep(15);
	StartCombat( heroName, nil, 4, CREATURE_WATER_ELEMENTAL, 4+diff*2, CREATURE_WATER_ELEMENTAL, 4+diff*2, CREATURE_WATER_ELEMENTAL, 4+diff*2, CREATURE_WATER_ELEMENTAL, 4+diff*2, nil, "IsPlayerDefeatElementals" );
end;


------------------------------------------------------------------------
--     Function Name: IsPlayerDefeatElementals() 
--     Description: ���� ����� ������� �����������, ����������� ���������� isElementalsKilled = 1
------------------------------------------------------------------------	
function IsPlayerDefeatElementals( heroName, combatResult )
	if combatResult ~= nil then
		print("Elementals defeated!");
		isElementalsKilled = 1;
		MessageBox( "Maps/SingleMissions/A2S1/MsgBox_KuinakKilledWaterElementals.txt" );
	end;
end;



------------------------------------------------------------------------
--     Function Name: KillFisher() 
--     Description: ��� �������������� � ������� ���������� ����� ���
------------------------------------------------------------------------	
function KillFisher()
	QuestionBox("Maps/SingleMissions/A2S1/MessageBox_wantToKillFisher.txt","WantToKillFisher");
end;


------------------------------------------------------------------------
--     Function Name: WantToKillFisher() 
--     Description: ����������� �������� ������ ��� ������ � ������� ��� � �����
------------------------------------------------------------------------	
function WantToKillFisher()
	print("fisher was killed");
	Trigger( OBJECT_TOUCH_TRIGGER, "fisher", nil );
	PlayObjectAnimation( "fisher", "death", ONESHOT_STILL );
	sleep(10);
	RemoveObject( "fisher" );
end;


------------------------------------------------------------------------
--     Function Name: RazeHut( heroName, objectName ) 
--     Description: ��� �������������� � ������� ������, ����� ��������� 
------------------------------------------------------------------------	
function RazeHut( heroName, objectName )
	PlayVisualEffect( "/Effects/_(Effect)/Buildings/Capture/Start_dust_S.xdb#xpointer(/Effect)",  objectName );
	sleep(10);
	PlayVisualEffect( "/Effects/_(Effect)/Characters/Heroes/DemonLord/Path/Level_2b.xdb#xpointer(/Effect)", objectName );
	RazeBuilding( objectName );
end;



------------------------------------------------------------------------
--     Function Name: IsCupOfRainFound() 
--     Description: ��� �������������� � ��������, � ������� ����� ��������, ����������, ������ �� ������ �� ���� ���������.
------------------------------------------------------------------------	
function IsCupOfRainFound( heroName )
	QuestionBox("Maps/SingleMissions/A2S1/QuestionBox_WantFightElementals.txt", "FightForArtifact" );
	finderHero = heroName;
end;


------------------------------------------------------------------------
--     Function Name: FightForArtifact() 
--     Description: ���� � ���������� ������� ����� ������� "��" �������� ����� � �������� ������������.
------------------------------------------------------------------------	
function FightForArtifact()
	StartCombat( finderHero, nil, 4, CREATURE_FIRE_ELEMENTAL, 40+diff*15, CREATURE_FIRE_ELEMENTAL, 40+diff*15, CREATURE_FIRE_ELEMENTAL, 40+diff*15, CREATURE_FIRE_ELEMENTAL, 40+diff*15, nil, "IsArtifactGuardDefeated" );
end;


------------------------------------------------------------------------
--     Function Name: IsArtifactGuardDefeated() 
--     Description: ���� � ����� � ������������ ����� ������� ��������� ������� �� ������� ������� "����� ���� �����".
------------------------------------------------------------------------	
function IsArtifactGuardDefeated( heroName, combatResult )
	if combatResult ~= nil then
		print("Artifact guards are defeated.");
		startThread( prim3_FindCupOfRain_complete );
	end;
end;

------------------------------------------------------------------------
--     Function Name: prim3_FindCupOfRain_complete() 
--     Description: ��������� ������� "����� ���� �����" � ������ "���������� ��������� ����"
------------------------------------------------------------------------
function prim3_FindCupOfRain_complete()
	Trigger( NEW_DAY_TRIGGER, nil );
	RemoveObject( cupOfRain );
	SetObjectiveState( "prim3_findCupOfRain", OBJECTIVE_COMPLETED );
	local soundTime = GetSoundTimeInSleeps( VOICEOVER_CUP_OF_RAIN_FOUND );
	BlockGame();
	Play2DSound( VOICEOVER_CUP_OF_RAIN_FOUND  );
	sleep( soundTime );
	UnblockGame();
	if isImperialFleetDeployed==0 then -- ���� ���� ��������� ���������� ����� ��� �� ���������
		ImperialAttackHeroDeploy(); -- ��������� �� ����� ��������� ����
		sleep(15);
		for i=1, HAVEN_HEROES.n do
			SinkHero( HAVEN_HEROES[i] );
			PlayVisualEffect( "/Effects/_(Effect)/Arenas/Boat/Surf06.xdb#xpointer(/Effect)", HAVEN_HEROES[i] );
		end;
	else -- ��������� ������� "������� �����" ��� ���� ������ �����
		for i=1, HAVEN_HEROES.n do
			startThread( SinkHavenHeroes, HAVEN_HEROES[i] ); -- 
			sleep(15);
		end;
	end;
end;	



------------------------------------------------------------------------
--     Function Name: SinkHavenHeroes( heroName )
--     Description: ����� �����, ���� �� ��������� �� ����, � ���������� ��� ������
------------------------------------------------------------------------
function SinkHavenHeroes( heroName )
	while IsHeroInBoat( heroName ) ~= true do sleep(5); end; -- ����� ���� ����� �� ��� �� �������
	if IsHeroAlive( heroName )==true then
		BlockGame();	
		local x, y = GetObjectPosition( heroName );
		OpenCircleFog( x, y, GROUND, 15, PLAYER_1 );
		sleep( 1 );
		MoveCamera( x, y, GROUND , 50, 1.2, 0, 0, 0, 1);
		PlayVisualEffect( "/Effects/_(Effect)/Arenas/Boat/Surf06.xdb#xpointer(/Effect)", heroName, "effect"..heroName );
		SinkHero( heroName );
		sleep(40);
		StopVisualEffects( "effect"..heroName );
		UnblockGame();
	end;
end;


------------------------------------------------------------------------
--     Function Name: ImperialAttackTimer() 
--     Description: ���������, �� ������ �� ����� ������ ��������� ����� �������.
------------------------------------------------------------------------
function ImperialAttackTimer()
	if GetDate( DAY ) == START_ATTACK or isAllEnemiesDefeated == 1 then
		Trigger( NEW_DAY_TRIGGER, nil );
		startThread( ImperialAttackHeroDeploy );
	end;
	GreatImproveAISpecialForUbisoft( "academy_town1" );
	GreatImproveAISpecialForUbisoft( "academy_town2" );
end;

function IsAllDefeated()
	repeat
		sleep(5);
		countAiTowns = 0;
		for i=1,TOWNS.n do
			if GetObjectOwner(TOWNS[i]) == PLAYER_3 or GetObjectOwner(TOWNS[i]) == PLAYER_2 then
				countAiTowns = countAiTowns+1;
			end;
		end;
		aiHeroes = length(GetPlayerHeroes(PLAYER_2))+length(GetPlayerHeroes(PLAYER_3));
	until aiHeroes == 0 and countAiTowns == 0;
	isAllEnemiesDefeated = 1;
	print("All AI Players are defeated");
end;
------------------------------------------------------------------------
--     Function Name: ImperialAttackHeroDeploy() 
--     Description: ������ �� ����� ����������������� ����� Haven. ���������� �� ������.
------------------------------------------------------------------------
function ImperialAttackHeroDeploy()
	if isImperialFleetDeployed == 0 then
		isImperialFleetDeployed = 1;
		BlockGame();
		sleep( 1 );
		OpenCircleFog( 120, 5, GROUND, 15, PLAYER_1 );
		sleep( 1 );
		MoveCamera( 120, 5, GROUND , 50, 1.2, 0, 0, 0, 1);
		sleep( 1 );
		DeployReserveHero( HAVEN_HEROES[1], 112, 2, GROUND );
		DeployReserveHero( HAVEN_HEROES[2], 115, 5, GROUND );
		DeployReserveHero( HAVEN_HEROES[3], 120, 8, GROUND );
		DeployReserveHero( HAVEN_HEROES[4], 110, 6, GROUND );
		DeployReserveHero( HAVEN_HEROES[5], 122, 4, GROUND );
		DeployReserveHero( HAVEN_HEROES[6], 128, 7, GROUND );
		sleep( 1 );
		SetObjectRotation(HAVEN_HEROES[1], 180);
		SetObjectRotation(HAVEN_HEROES[2], 180);
		SetObjectRotation(HAVEN_HEROES[3], 180);
		SetObjectRotation(HAVEN_HEROES[4], 180);
		SetObjectRotation(HAVEN_HEROES[5], 180);
		SetObjectRotation(HAVEN_HEROES[6], 180);
		sleep(1);
		startThread( Prim2_DestroyHavenHeroes );
		MoveHeroRealTime( HAVEN_HEROES[1], 112, 4, GROUND );
		MoveHeroRealTime( HAVEN_HEROES[2], 115, 7, GROUND );
		MoveHeroRealTime( HAVEN_HEROES[3], 120, 10, GROUND );
		MoveHeroRealTime( HAVEN_HEROES[4], 110, 8, GROUND );
		MoveHeroRealTime( HAVEN_HEROES[5], 122, 6, GROUND );
		MoveHeroRealTime( HAVEN_HEROES[6], 128, 9, GROUND );
		UnblockGame();
		print("ImperialAttackHeroDeploy: heroes are deployed");
	end;
end;


------------------------------------------------------------------------
--     Function Name: Prim2_DestroyHavenHeroes() 
--     Description: ��������� ������� "���������� ���� �������", ���� ��� ����� Haven ����������.
------------------------------------------------------------------------
function Prim2_DestroyHavenHeroes()
	print("Prim2_DestroyHavenHeroes: started");
	while ((IsHeroAlive("Maeve") or 
		    IsHeroAlive("Christian") or 
		    IsHeroAlive("Brem") or 
		    IsHeroAlive("Orrin") or 
		    IsHeroAlive("Sarge") or 
		    IsHeroAlive("Ving") ) == true)
		do
		sleep(10);
	end;
	print("All heroes are dead");
	sleep(20);
	StartDialogScene( SCENE_MISSION_END );
	sleep(1);
	SetObjectiveState( "prim2_DestroyHavenFleet", OBJECTIVE_COMPLETED );
	sleep(1);
	if GetObjectiveState( "prim3_findCupOfRain" ) ~= OBJECTIVE_COMPLETED then
		SetObjectiveState( "prim3_findCupOfRain", OBJECTIVE_COMPLETED );
	end;
end;

------------------------------------------------------------------------
--     Function Name: PlayerWin() 
--     Description: ���� ��������� ��� ������� �������, ����� �������
------------------------------------------------------------------------
function PlayerWin()
	while  GetObjectiveState( "prim2_DestroyHavenFleet" ) ~= OBJECTIVE_COMPLETED 
		or GetObjectiveState( "prim3_findCupOfRain" ) ~= OBJECTIVE_COMPLETED do
		sleep(10);
	end;
	sleep(10);
	Win( PLAYER_1 );
end;


------------------------------------------------------------------------
--     Function Name: KuinakMustSurvive() 
--     Description: ���� ������� ����� ���� - ������ ������
------------------------------------------------------------------------
function KuinakMustSurvive( heroName )
	if heroName == HERO_NAME then Loose( PLAYER_1 ); end;
end;


function ApproachPrisonIslandVoiceover( heroName )
	if GetObjectOwner( heroName )==PLAYER_1 then
		Trigger( REGION_ENTER_WITHOUT_STOP_TRIGGER, "approach_prison_island", nil );
		Play2DSound( VOICEOVER_APPROACH_PRISON_ISLAND );
	end;
end;

function ApproachCupOfRainIslandVoiceover( heroName )
	if GetObjectOwner( heroName )==PLAYER_1 then
		Trigger( REGION_ENTER_WITHOUT_STOP_TRIGGER, "approach_cup_of_rain_area_1", nil );
		Trigger( REGION_ENTER_WITHOUT_STOP_TRIGGER, "approach_cup_of_rain_area_2", nil );
		Trigger( REGION_ENTER_WITHOUT_STOP_TRIGGER, "approach_cup_of_rain_area_3", nil );
		Trigger( REGION_ENTER_WITHOUT_STOP_TRIGGER, "approach_cup_of_rain_area_4", nil );
		Trigger( REGION_ENTER_WITHOUT_STOP_TRIGGER, "approach_cup_of_rain_area_1_west_north", nil );
		Trigger( REGION_ENTER_WITHOUT_STOP_TRIGGER, "approach_cup_of_rain_area_2_west_north", nil );
		Trigger( REGION_ENTER_WITHOUT_STOP_TRIGGER, "approach_cup_of_rain_area_1_east_north", nil );
		Trigger( REGION_ENTER_WITHOUT_STOP_TRIGGER, "approach_cup_of_rain_area_2_east_north", nil );
		Play2DSound( VOICEOVER_APPROACH_CUP_OF_RAIN_ISLAND );
	end;
end;

function GreatImproveAISpecialForUbisoft( townName ) -- it stupid cheat, i'm sorry
	if GetObjectOwner( townName )==PLAYER_3 then
		if GetDate(DAY)==4 then
			BuildStructure( TOWN_BUILDING_DWELLING_1, 2, townName );
		end;
		if GetDate(DAY)==6 then
			BuildStructure( TOWN_BUILDING_MARKETPLACE, 1, townName );
		end;
		if GetDate(DAY)==11 then
			BuildStructure( TOWN_BUILDING_DWELLING_1, 3, townName );
		end;
		if GetDate(DAY)==15 then
			BuildStructure( TOWN_BUILDING_TOWN_HALL, 2, townName );
		end;
		if GetDate(DAY)==16 then
			BuildStructure( TOWN_BUILDING_DWELLING_2, 2, townName );
		end;
		if GetDate(DAY)==18 then
			BuildStructure( TOWN_BUILDING_DWELLING_3, 2, townName );
		end;
		if GetDate(DAY)==22 then
			BuildStructure( TOWN_BUILDING_FORT, 2, townName );
		end;
		if GetDate(DAY)==23 then
			BuildStructure( TOWN_BUILDING_DWELLING_3, 3, townName );
		end;
		if GetDate(DAY)==24 then
			BuildStructure( TOWN_BUILDING_MAGIC_GUILD, 3, townName );
		end;
		if GetDate(DAY)==26 then
			BuildStructure( TOWN_BUILDING_FORT, 3, townName );
		end;
		if GetDate(DAY)==29 then
			BuildStructure( TOWN_BUILDING_DWELLING_4, 2, townName );
		end;
		if GetDate(DAY)==32 then
			BuildStructure( TOWN_BUILDING_DWELLING_4, 3, townName );
		end;
		if GetDate(DAY)==35 then
			BuildStructure( TOWN_BUILDING_DWELLING_5, 2, townName );
		end;
		if GetDate(DAY)==38 then
			BuildStructure( TOWN_BUILDING_ACADEMY_ARCANE_FORGE, 2, townName );
		end;
		if GetDate(DAY)==43 then
			BuildStructure( TOWN_BUILDING_ACADEMY_LIBRARY, 2, townName );
		end;
		if GetDate(DAY)==48 then
			BuildStructure( TOWN_BUILDING_ACADEMY_TREASURE_CAVE, 2, townName );
		end;
		if GetDate(DAY)==53 then
			BuildStructure( TOWN_BUILDING_MAGIC_GUILD, 5, townName );
		end;
	end;
end;

function BuildStructure( structureType, structureLimit, townName )
	if GetTownBuildingLevel( townName, structureType ) < structureLimit then
		UpgradeTownBuilding( townName, structureType );
		print("building "..structureType.." was builded in town"..townName );
	end;
end;
--------------------------------------------------------------------
----------------- MAIN ---------------------------------------------
--------------------------------------------------------------------
Trigger( OBJECT_TOUCH_TRIGGER, "butar_hut", "RazeButarHut");
Trigger( OBJECT_TOUCH_TRIGGER, "butar", "Sec1_killMonsters" );
Trigger( OBJECT_TOUCH_TRIGGER, "fisher", "Sec3_kill_waterElementals" );
Trigger( OBJECT_TOUCH_TRIGGER, "prison", "show_fakeCupOfRain" );
Trigger( OBJECT_TOUCH_TRIGGER, "shaman_guard", "ShamanGuardTouched" );
for i=0, 12 do
	Trigger( OBJECT_TOUCH_TRIGGER, "cupOfRain"..i, "RemoveCupOfRainEffects" );
end;
Trigger( REGION_ENTER_AND_STOP_TRIGGER, "water_elementals", "IsInWaterElementalsRegion" );
Trigger( REGION_ENTER_AND_STOP_TRIGGER, "shaman_gate", "StartGoblinsQuestScene" );
Trigger( PLAYER_REMOVE_HERO_TRIGGER , PLAYER_1, "KuinakMustSurvive" );
Trigger( OBJECT_TOUCH_TRIGGER, cupOfRain, "IsCupOfRainFound");
Trigger( NEW_DAY_TRIGGER, "ImperialAttackTimer" );
Trigger( REGION_ENTER_WITHOUT_STOP_TRIGGER, "approach_prison_island", "ApproachPrisonIslandVoiceover" );

cup_x, cup_y = GetObjectPosition( cupOfRain );
if cup_x>=4 and cup_x<=25 and cup_y>=154 and cup_y<=172   then 
	Trigger( REGION_ENTER_WITHOUT_STOP_TRIGGER, "approach_cup_of_rain_area_1_west_north", "ApproachCupOfRainIslandVoiceover" );
	Trigger( REGION_ENTER_WITHOUT_STOP_TRIGGER, "approach_cup_of_rain_area_2_west_north", "ApproachCupOfRainIslandVoiceover" );
end;
if cup_x>=154 and cup_x<=167 and cup_y>=142 and cup_y<=168   then 
	Trigger( REGION_ENTER_WITHOUT_STOP_TRIGGER, "approach_cup_of_rain_area_1_east_north", "ApproachCupOfRainIslandVoiceover" );
	Trigger( REGION_ENTER_WITHOUT_STOP_TRIGGER, "approach_cup_of_rain_area_2_east_north", "ApproachCupOfRainIslandVoiceover" );
end;
if cup_x>=102 and cup_x<=128 and cup_y>=35 and cup_y<=51   then 
	Trigger( REGION_ENTER_WITHOUT_STOP_TRIGGER, "approach_cup_of_rain_area_1", "ApproachCupOfRainIslandVoiceover" );
	Trigger( REGION_ENTER_WITHOUT_STOP_TRIGGER, "approach_cup_of_rain_area_2", "ApproachCupOfRainIslandVoiceover" );
	Trigger( REGION_ENTER_WITHOUT_STOP_TRIGGER, "approach_cup_of_rain_area_3", "ApproachCupOfRainIslandVoiceover" );
	Trigger( REGION_ENTER_WITHOUT_STOP_TRIGGER, "approach_cup_of_rain_area_4", "ApproachCupOfRainIslandVoiceover" );
end;

startThread( PlayerWin );
startThread( IsAllDefeated );
--startThread( DisablePlayerHeroHiring, PLAYER_2, 2);
print( "All triggers and functions started..." );