-------------------------------------------------------------------
----------------- TITLE -------------------------------------------
-------------------------------------------------------------------
--              Author: Dmitry Butkevich
--       Author e-mail: Dmitry Butkevich@nival.com
--        Project Name: H5A2
--            Map Name: A2S2
--------------------------------------------------------------------
--------------------------------------------------------------------
--Play2DSound( "/Maps/Scenario/A2C1M2/C1M2_VO6_Arantir_01sound.xdb#xpointer(/Sound)" ); ----------------VO

print ('Start.......single_mission_a2sm2');

StartDialogScene("/DialogScenes/A2Single/SM2/S1/DialogScene.xdb#xpointer(/DialogScene)"); ----///�����_��������� 

MAIN_HERO = "Linaas"

SetObjectiveState('Prim1',OBJECTIVE_ACTIVE);
SetObjectiveState('Prim4',OBJECTIVE_ACTIVE);

OpenCircleFog( 44, 51, 0, 6, PLAYER_1 );
OpenCircleFog( 80, 93, 0, 6, PLAYER_1 );

---------------------------------------------
function Diff_level()
	slozhnost = GetDifficulty(); 
	if slozhnost == DIFFICULTY_EASY then
		AddHeroCreatures(MAIN_HERO, CREATURE_WOOD_ELF, 30);
		AddHeroCreatures(MAIN_HERO, CREATURE_DRUID, 6);
		RemoveObjectCreatures("G1", CREATURE_ASSASSIN, 100);
		RemoveObjectCreatures("G1", CREATURE_BLOOD_WITCH, 30);
		RemoveObjectCreatures("G1", CREATURE_MINOTAUR_KING, 40);
		RemoveObjectCreatures("G2", CREATURE_ASSASSIN, 100);
		RemoveObjectCreatures("G2", CREATURE_BLOOD_WITCH, 30);
		RemoveObjectCreatures("G2", CREATURE_MINOTAUR_KING, 40);
	elseif slozhnost == DIFFICULTY_NORMAL then
		AddHeroCreatures(MAIN_HERO, CREATURE_WOOD_ELF, 10);
--		AddHeroCreatures(MAIN_HERO, CREATURE_DRUID, 6);
		RemoveObjectCreatures("G1", CREATURE_ASSASSIN, 50);
		RemoveObjectCreatures("G1", CREATURE_BLOOD_WITCH, 20);
		RemoveObjectCreatures("G1", CREATURE_MINOTAUR_KING, 15);
		RemoveObjectCreatures("G2", CREATURE_ASSASSIN, 50);
		RemoveObjectCreatures("G2", CREATURE_BLOOD_WITCH, 20);
		RemoveObjectCreatures("G2", CREATURE_MINOTAUR_KING, 15);
	end;
	print('difficulty = ',slozhnost);
end;
----------------------------------------------

SetRegionBlocked("block1", 1, PLAYER_2);
SetRegionBlocked("block1", 1, PLAYER_3);
SetRegionBlocked("block1", 1, PLAYER_4);
  
SetRegionBlocked("block2", 1, PLAYER_2); 
SetRegionBlocked("block2", 1, PLAYER_3); 
SetRegionBlocked("block2", 1, PLAYER_4);

SetRegionBlocked("block_ai1", 1, PLAYER_3);
SetRegionBlocked("block_ai2", 1, PLAYER_3);
SetRegionBlocked("block_ai1", 1, PLAYER_4);
SetRegionBlocked("block_ai2", 1, PLAYER_4);
SetRegionBlocked("block_ai1", 1, PLAYER_2);
SetRegionBlocked("block_ai2", 1, PLAYER_2);
------------------------------------------------
function Time_events()
	slozhnost = GetDifficulty();
	if ( GetDate(MONTH) == 1 ) and ( GetDate(WEEK) == 1 ) and (GetDate(DAY_OF_WEEK) == 4 ) then 
		SetObjectiveState('sec1',OBJECTIVE_ACTIVE);
		SetObjectiveState('sec2',OBJECTIVE_ACTIVE);
		Play2DSound( "/Maps/SingleMissions/A2S2/SM2_VO5_Tieru_01sound.xdb#xpointer(/Sound)" ); ----------------VO ��������� ��� ������
		sleep(2);
		startThread( Second1 );
	end;
	if (( GetDate(MONTH) == 1 ) and ( GetDate(WEEK) == 1 ) and (GetDate(DAY_OF_WEEK) == 6 )) and (GetObjectiveState( "Prim1" ) == OBJECTIVE_ACTIVE) then 
		Play2DSound( "/Maps/SingleMissions/A2S2/SM2_VO7_Tieru_01sound.xdb#xpointer(/Sound)" ); 
		sleep(2);
	end;
	if ( GetDate(MONTH) == 2 ) and ( GetDate(WEEK) == 1 ) and (GetDate(DAY_OF_WEEK) == 1 ) and slozhnost == DIFFICULTY_EASY then 
		SetRegionBlocked("block_ai1", nil, PLAYER_3);
		SetRegionBlocked("block_ai2", nil, PLAYER_3);
		SetRegionBlocked("block_ai2", nil, PLAYER_4);
		SetRegionBlocked("block_ai1", nil, PLAYER_4);
		print('Region_disable_easy_diff!');
		sleep(2);   
	end;
	if ( GetDate(MONTH) == 2 ) and ( GetDate(WEEK) == 1 ) and (GetDate(DAY_OF_WEEK) == 1 ) and slozhnost == DIFFICULTY_NORMAL then 
		SetRegionBlocked("block_ai1", nil, PLAYER_3);
		SetRegionBlocked("block_ai2", nil, PLAYER_3);
		SetRegionBlocked("block_ai2", nil, PLAYER_4);
		SetRegionBlocked("block_ai1", nil, PLAYER_4);
		print('Region_disable_normal_diff!');
		sleep(2);   
	end;
	if ( GetDate(MONTH) == 2 ) and ( GetDate(WEEK) == 2 ) and (GetDate(DAY_OF_WEEK) == 1 ) and slozhnost == DIFFICULTY_HARD then 
		SetRegionBlocked("block_ai1", nil, PLAYER_3);
		SetRegionBlocked("block_ai2", nil, PLAYER_3);
		SetRegionBlocked("block_ai2", nil, PLAYER_4);
		SetRegionBlocked("block_ai1", nil, PLAYER_4);
		print('Region_disable_hard_diff!');
		sleep(2);   
	end;
	if ( GetDate(MONTH) == 2 ) and ( GetDate(WEEK) == 3 ) and (GetDate(DAY_OF_WEEK) == 1 ) and slozhnost == DIFFICULTY_HEROIC then 
		SetRegionBlocked("block_ai1", nil, PLAYER_3);
		SetRegionBlocked("block_ai2", nil, PLAYER_3);
		SetRegionBlocked("block_ai2", nil, PLAYER_4);
		SetRegionBlocked("block_ai1", nil, PLAYER_4);
		print('Region_disable_heroic_diff!');
		sleep(2);   
	end;
end;
----------------------------------------------

function Complete_obj_start()
	while 1 do	
		sleep( 10 );
		if (GetObjectOwner("E1") == PLAYER_1) or (GetObjectOwner("E2") == PLAYER_1) then
			sleep( 10 );
			SetObjectiveState('Prim1',OBJECTIVE_COMPLETED);
			SetObjectiveState('Prim2',OBJECTIVE_ACTIVE);
			SetObjectiveState('Prim3',OBJECTIVE_ACTIVE);
			StartDialogScene("/DialogScenes/A2Single/SM2/S2/DialogScene.xdb#xpointer(/DialogScene)"); ----///����� ������� ������� ������
			startThread( Objective2 );
			startThread( Objective3 );
			sleep( 5 );
			Play2DSound( "/Maps/SingleMissions/A2S2/SM2_VO2_Tieru_01sound.xdb#xpointer(/Sound)" ); ----------------VO_������ 1 �����
			break;
		end;
	end;
end;

function Objective2()  
	while 1 do
		sleep(10);
		if GetPlayerState(PLAYER_2) == 3 then
			sleep(3);
			SetObjectiveState( "Prim2", OBJECTIVE_COMPLETED );
			print ('................Pirates defeated....');
			Play2DSound( "/Maps/SingleMissions/A2S2/SM2_VO3_Tieru_01sound.xdb#xpointer(/Sound)" ); ----------------VO_����������� �������
			break;
		end;
	end;
end;

function Objective3()  
	while 1 do
		sleep(10);
		if GetPlayerState(PLAYER_3) == 3 and GetPlayerState(PLAYER_4) == 3 then
			sleep(5);
			Play2DSound( "/Maps/SingleMissions/A2S2/SM2_VO4_Tieru_02sound.xdb#xpointer(/Sound)" ); ----------------VO_����������� ������ ������
			SetObjectiveState( "Prim3", OBJECTIVE_COMPLETED );
			print ('................Elves defeated...');
			break;
		end;
	end;
end;

----------------------------------------------
function Winner()
	while 1 do
		sleep(10);
		if GetObjectiveState( "Prim2" ) == OBJECTIVE_COMPLETED and GetObjectiveState( "Prim3" ) == OBJECTIVE_COMPLETED then
			sleep( 35 );
			StartDialogScene("/DialogScenes/A2Single/SM2/S3/DialogScene.xdb#xpointer(/DialogScene)"); ----///����� ���������
			sleep( 15 );
			Win();
			break;
		end;
	end;
end;

function Main_hero_de()  
	while 1 do
		sleep(10);
		if IsHeroAlive(MAIN_HERO) == nil then 
			sleep(2);
			Loose();
			break;
		end;
	end;
end;
-------------------------------------------------�������� �� ������� ��� ������
function Second1()
	while 1 do
		sleep(10);
		if GetObjectiveState( "sec1" ) == OBJECTIVE_COMPLETED then
			sleep( 2 );
			Play2DSound( "/Maps/SingleMissions/A2S2/SM2_VO6_Tieru_01sound.xdb#xpointer(/Sound)" ); ----------------VO
			break;
		end;
	end;
end;
------------------------------------
function Sukka_objective()
	while 1 do
		if GetObjectiveState("Q2") == OBJECTIVE_ACTIVE then
			Play2DSound( "/Maps/SingleMissions/A2S2/SM2_VO8_Tieru_01sound.xdb#xpointer(/Sound)" ); ----------------VO
			sleep(5);
			startThread(Tarot_objective2);
			break;
		end;
	sleep( 3 );
	end;	
end;

---------------------------###########MAIN###########---------------------------
startThread( Sukka_objective );

Trigger( NEW_DAY_TRIGGER, "Time_events",nil );

startThread( Complete_obj_start );
startThread( Time_events );

startThread( Diff_level );
 
startThread( Winner );
startThread( Main_hero_de );