PlayerHero = "Arantir"
SetHeroesExpCoef( 0.6 );
doFile("/scripts/A2_Artifact_Sets/A2_Artifact_Sets.lua"); ----!!!

--SetPlayerResource(1, 6, 20000);

DenyAIHeroesFlee( PLAYER_4, 1 );
DenyAIHeroesFlee( PLAYER_2, 1 );
DenyAIHeroesFlee( PLAYER_1, 1 );

print("Start_A2C1M2.................");

function x2()
	InitAllSetArtifacts( "A2C1M2", PlayerHero );
--	LoadHeroAllSetArtifacts( PlayerHero, "A2C1M1" );
end

BlockTownGarrisonForAI( "winner", true )

--sleep( 3 );
--SetObjectiveState('prim1',OBJECTIVE_ACTIVE);
--SetObjectiveState('prim4',OBJECTIVE_ACTIVE);

GiveExp( "Faiz", 65000 ); ---addexp
GiveExp( "Gamor", 41000 ); ---addexp
GiveExp( "Astral", 1000 ); ---addexp

EnableHeroAI("Nur", false);
EnableHeroAI("Gamor", false);
EnableHeroAI("Faiz", false);

SetTownBuildingLimitLevel("t1", TOWN_BUILDING_DWELLING_4, 0);
SetTownBuildingLimitLevel("t2", TOWN_BUILDING_DWELLING_4, 0);
SetTownBuildingLimitLevel("t1", TOWN_BUILDING_TAVERN, 0);
print ('....CHECK1....');

----------------------------------------------------//Diff
function Diff_level()
	slozhnost = GetDifficulty(); 
	if slozhnost == DIFFICULTY_NORMAL then
		RemoveHeroCreatures(PlayerHero, CREATURE_SKELETON, 10);
	elseif slozhnost == DIFFICULTY_HARD then
		RemoveHeroCreatures(PlayerHero, CREATURE_SKELETON, 25);
		AddHeroCreatures("Nur", CREATURE_IRON_GOLEM, 2);
		AddHeroCreatures("Gamor", CREATURE_INFERNAL_SUCCUBUS, 65);
		AddHeroCreatures("Gamor", CREATURE_ARCHDEVIL, 5);
		SetRegionBlocked("z1", 1, PLAYER_2); --------------------------------//AI_BORDER!!!
		SetRegionBlocked("z1", 1, PLAYER_3);
		SetRegionBlocked("z2", 1, PLAYER_2); 
		SetRegionBlocked("z2", 1, PLAYER_3);
		SetRegionBlocked("z3", 1, PLAYER_2); 
		SetRegionBlocked("z3", 1, PLAYER_3);
		SetRegionBlocked("z4", 1, PLAYER_2); 
		SetRegionBlocked("z4", 1, PLAYER_3);
	elseif slozhnost == DIFFICULTY_HEROIC then
		RemoveHeroCreatures(PlayerHero, CREATURE_SKELETON, 35);
		AddHeroCreatures("Nur", CREATURE_IRON_GOLEM, 6);
		AddHeroCreatures("Gamor", CREATURE_INFERNAL_SUCCUBUS, 160);
		AddHeroCreatures("Gamor", CREATURE_ARCHDEVIL, 30 );
		SetRegionBlocked("z1", 1, PLAYER_2); --------------------------------//AI_BORDER!!!
		SetRegionBlocked("z1", 1, PLAYER_3);
		SetRegionBlocked("z2", 1, PLAYER_2); 
		SetRegionBlocked("z2", 1, PLAYER_3);
--		SetRegionBlocked("z3", 1, PLAYER_2); 
--		SetRegionBlocked("z3", 1, PLAYER_3);
--		SetRegionBlocked("z4", 1, PLAYER_2); 
--		SetRegionBlocked("z4", 1, PLAYER_3);
	end;
	print('difficulty = ',slozhnost);
end;
----------------------------------------------------//Block_regions

SetRegionBlocked("demon_block", 1, PLAYER_4); 

SetRegionBlocked("mage1", 1, PLAYER_1); 
SetRegionBlocked("mage1", 1, PLAYER_2);
SetRegionBlocked("mage1", 1, PLAYER_3); 
 

SetRegionBlocked("b1", 1, PLAYER_2); 
SetRegionBlocked("b1", 1, PLAYER_3); 
  
SetRegionBlocked("b2", 1, PLAYER_2); 
SetRegionBlocked("b2", 1, PLAYER_3); 

SetRegionBlocked("b3", 1, PLAYER_2); 
SetRegionBlocked("b3", 1, PLAYER_3); 

SetRegionBlocked("b4", 1, PLAYER_2); 
SetRegionBlocked("b4", 1, PLAYER_3); 

SetRegionBlocked("key1", 1, PLAYER_2); 
SetRegionBlocked("key1", 1, PLAYER_3); 

SetRegionBlocked("key2", 1, PLAYER_2); 
SetRegionBlocked("key2", 1, PLAYER_3); 

SetRegionBlocked("key3", 1, PLAYER_2); 
SetRegionBlocked("key3", 1, PLAYER_3); 

SetRegionBlocked("ent1", 1, PLAYER_2); 
SetRegionBlocked("ent1", 1, PLAYER_3); 

SetRegionBlocked("ent2", 1, PLAYER_2); 
SetRegionBlocked("ent2", 1, PLAYER_3); 

SetRegionBlocked("back", 1, PLAYER_1); 

SetRegionBlocked("nb1", 1, PLAYER_2); 
SetRegionBlocked("nb1", 1, PLAYER_3);

SetRegionBlocked("n_sec", 1, PLAYER_2); 
SetRegionBlocked("n_sec", 1, PLAYER_3);


print ('....CHECK2....'); 

 
--------------------------------------------------//Main_heroes_death

function Main_hero_de()  
	while 1 do
		sleep(10);
		if IsHeroAlive(PlayerHero) == nil then 
			sleep(2);
			Loose();
			break;
		end;
	end;
end;

---------------------------------------------------//First_Attack_Mages

function AIAction()
--	sleep(3);
	BlockGame();
	sleep(5);
	StartAdvMapDialog (5); -----------------------------------------------------5_adv_map_dialog
--	sleep(25);
--	UnblockGame();
--	sleep(5);
--	BlockGame();
--	Play2DSound( "/Maps/Scenario/A2C1M2/C1M2_VO5_Arantir_01sound.xdb#xpointer(/Sound)" ); ----------------VO
	sleep(30);
	ChangeHeroStat( "Nur", STAT_MOVE_POINTS, 30000 );
	MoveHeroRealTime( "Nur", GetObjectPosition( PlayerHero ) );
	sleep(20);
	UnblockGame();
	sleep(5);
	SetTownBuildingLimitLevel("t1", TOWN_BUILDING_TAVERN, 1);	
	SetObjectiveState('prim1',OBJECTIVE_ACTIVE);
	SetObjectiveState('prim4',OBJECTIVE_ACTIVE);	
end;
--------------------------------------------------//Start_sec_obj_enterdangeon
function Demon_obj()  
	while 1 do
		sleep(10);
		if IsHeroAlive("Nur") == nil then  
			SetObjectiveState('prim2',OBJECTIVE_ACTIVE);			
			startThread(AIAction2);
			sleep(2);
			break;
		end;
	end;
end;
-----------------------advmap_dialog_after_batle
function AIAction2()
	SetObjectRotation( "Astral", 270 );
	SetObjectPosition( "Astral", 117, 118, GROUND );
	sleep(2);
	BlockGame();
	sleep(3);
	StartAdvMapDialog (1, "AI3"); -----------------------------------------------------1_adv_map_dialog
	sleep(2);
	UnblockGame();
--	SetObjectPosition( "Astral", 92, 49, GROUND );	
end;

function AI3()
	SetObjectPosition( "Astral", 92, 49, GROUND );
	Play2DSound( "/Maps/Scenario/A2C1M2/C1M2_VO5_Arantir_01sound.xdb#xpointer(/Sound)" ); ----------------VO
end;
---------------------------------------------------//Demon_death
function Demon_kill()  
	while 1 do
		sleep(10);
		if IsHeroAlive("Gamor") == nil then  
			SetObjectiveState( "prim2", OBJECTIVE_COMPLETED );
			sleep(10);
			Play2DSound( "/Maps/Scenario/A2C1M2/C1M2_VO6_Arantir_01sound.xdb#xpointer(/Sound)" ); ----------------VO	
			SetObjectiveState('prim3',OBJECTIVE_ACTIVE);
			SetObjectiveState('Prim5',OBJECTIVE_ACTIVE);
			sleep(10); 
			MessageBox ("Maps/Scenario/A2C1M2/key3.txt");
			break;
		end;
	end;
end;
--------------------------------------------------//Mages_death

function Objective_prim1()  
	while 1 do
		sleep(10);
		if GetPlayerState(PLAYER_2) == PLAYER_LOST then
			sleep(5);
			SetObjectiveState( "prim1", OBJECTIVE_COMPLETED );
			print ('................Mage_defeated....');
			SetRegionBlocked("b3", nil, PLAYER_3);
			break;
		end;
	end;
end;
--------------------------------------------------//Final_City_defeat


function Complete_obj3()
	while 1 do	
		sleep( 10 );
		if (GetObjectOwner("winner") == PLAYER_1) then
			sleep( 5 );
			SetObjectiveState('prim3',OBJECTIVE_COMPLETED);
			SetRegionBlocked("back", nil, PLAYER_1);
			RemoveObject("e1");
			RemoveObject("e2");
			RemoveObject("e3");
			sleep( 5 );
			break;
		end;
	end;
end;
--------------------------------------------------//Winn_all
function Complete_miss()
	while 1 do	
		sleep( 10 );
		if GetObjectiveState("prim1") == OBJECTIVE_COMPLETED and GetObjectiveState("prim3") == OBJECTIVE_COMPLETED then
			sleep( 5 );
			StartDialogScene( "/DialogScenes/A2C1/M2/S2/DialogScene.xdb#xpointer(/DialogScene)", "Complete_miss_fin" ); ----///����� ���������C1M2_S1 
			break;
		end;
	end;
end;

function Complete_miss_fin()
	SaveHeroAllSetArtifacts( "Arantir",  "A2C1M2" );
	Win();
end;

---------------------------------------------//Sec2_complete_vamp_dwellings

function Complete_sec2obj()
	while 1 do	
		sleep( 10 );
		if GetObjectOwner("vamp1") == PLAYER_1 and GetObjectOwner("vamp2") == PLAYER_1 and GetObjectOwner("vamp3") == PLAYER_1 then
			sleep( 5 );
			SetObjectiveState('sec2',OBJECTIVE_COMPLETED);
			sleep( 5 );
			SetTownBuildingLimitLevel("t1", TOWN_BUILDING_DWELLING_4, 2);
			SetTownBuildingLimitLevel("t2", TOWN_BUILDING_DWELLING_4, 2);
			break;
		end;
	end;
end;
-----------------------------------------------//Sec2obj_start
Trigger( REGION_ENTER_AND_STOP_TRIGGER, "n_sec","SecObj1start", nil );

function SecObj1start()
	StartAdvMapDialog (6); -----------------------------------------------------6_adv_map_dialog
	SetObjectiveState('sec2',OBJECTIVE_ACTIVE);
	OpenCircleFog( 27, 100, 0, 4, PLAYER_1 );
	sleep(2);	
	Trigger( REGION_ENTER_AND_STOP_TRIGGER, "n_sec",nil);
end;
---------------------------------------------//Complete_sec1_obj

Trigger( REGION_ENTER_AND_STOP_TRIGGER, "dang","SecObj1complete", nil );

function SecObj1complete()
	sleep(2);	
	Trigger( REGION_ENTER_AND_STOP_TRIGGER, "dang",nil);
	sleep(5);
	SetObjectiveState( "Prim5", OBJECTIVE_COMPLETED );
	sleep(10);
	MessageBox ("Maps/Scenario/A2C1M2/mess4.txt");
end;

----------------------------//Keyzone_enter_check

Trigger( REGION_ENTER_AND_STOP_TRIGGER, "key_zone","Warningmess" );

function Warningmess ( heroname )
	HN = heroname;
	if IsObjectInRegion (HN, "key_zone") == true and IsHeroAlive("Gamor") ~= nil and GetObjectiveState("prim3") ~= OBJECTIVE_COMPLETED then 
		sleep(2);
		Play2DSound( "/Maps/Scenario/A2C1M2/C1M2_VO3_Arantir_01sound.xdb#xpointer(/Sound)" ); ----------------VO
--		HN = heroname;
		SetObjectPosition( HN, 125, 14, 0 );
		sleep( 10 );
		MessageBox ("Maps/Scenario/A2C1M2/key.txt");
	else
	print("Region_disable");
	Play2DSound( "/Maps/Scenario/A2C1M2/C1M2_VO4_Arantir_01sound.xdb#xpointer(/Sound)" ); ----------------VO
	Trigger( REGION_ENTER_AND_STOP_TRIGGER, "key_zone",nil);
	end;
end;


-------------------------//Mummi_warning

Trigger( REGION_ENTER_AND_STOP_TRIGGER, "magic1","Warning" );


function Warning ( heroname )
	HN = heroname;
	if GetObjectiveState("prim3") ~= OBJECTIVE_COMPLETED then
		MessageBox ("Maps/Scenario/A2C1M2/mummy.txt");
		sleep(3);
	else
	print("Region_disable");
	Trigger( REGION_ENTER_AND_STOP_TRIGGER, "magic1",nil);
	end;
end;

------------------------//Mummi_combat

Trigger( REGION_ENTER_AND_STOP_TRIGGER, "magic2","Pipez" );

function Pipez ( heroname )
	HN = heroname;
	if IsObjectInRegion (HN, "magic2") == true and GetObjectiveState("prim3") ~= OBJECTIVE_COMPLETED then
		BlockGame();
		sleep(6);
		SetObjectPosition( HN, 82, 7, 0 );
		sleep(15);
		PlayVisualEffect( "/Effects/_(Effect)/Spells/AnimateDead.xdb#xpointer(/Effect)", HN, "hn1", 0, 0, 0, 0, 0 );
		sleep(15);
		UnblockGame();
		StartCombat(HN,nil,4,CREATURE_MUMMY,50,CREATURE_MUMMY,50,CREATURE_MUMMY,50,CREATURE_MUMMY,50,nil);
	else
	print("Region_mymmi_disable");
	Trigger( REGION_ENTER_AND_STOP_TRIGGER, "magic2",nil);
	end;
end;
--------------------------------------//Time_events
function Time_events()
	if ( GetDate(MONTH) == 3 ) and ( GetDate(WEEK) == 3 ) and (GetDate(DAY_OF_WEEK) == 1 ) then 
		AddHeroCreatures("Gamor", CREATURE_INFERNAL_SUCCUBUS, 20);
		AddHeroCreatures("Gamor", CREATURE_ARCHDEVIL, 5);
		AddObjectCreatures("winner", CREATURE_TITAN, 2);
		AddObjectCreatures("winner", CREATURE_ARCH_MAGI, 10);
		AddObjectCreatures("winner", CREATURE_IRON_GOLEM, 50);
	end;
	if ( GetDate(MONTH) == 4 ) and ( GetDate(WEEK) == 3 ) and (GetDate(DAY_OF_WEEK) == 1 ) then 
		AddHeroCreatures("Gamor", CREATURE_INFERNAL_SUCCUBUS, 100);
		AddHeroCreatures("Gamor", CREATURE_ARCHDEVIL, 20);
		AddObjectCreatures("winner", CREATURE_TITAN, 10);
		AddObjectCreatures("winner", CREATURE_ARCH_MAGI, 35);
		AddObjectCreatures("winner", CREATURE_IRON_GOLEM, 100);
	end;
end;
----------------------------------------///

Trigger( REGION_ENTER_AND_STOP_TRIGGER, "dd2","Dem2", nil );

function Dem2()
	RemoveObject("i2");
	sleep(3);
	CreateMonster( "m2", CREATURE_INFERNAL_SUCCUBUS, 160, 92, 79, 1, MONSTER_MOOD_AGGRESSIVE, MONSTER_COURAGE_ALWAYS_FIGHT, 270 );
	Trigger( REGION_ENTER_AND_STOP_TRIGGER, "dd2",nil);
	Play2DSound( "/Maps/Scenario/A2C1M2/C1M2_VO7_Arantir_01sound.xdb#xpointer(/Sound)" ); ----------------VO_������� 	
end;

Trigger( REGION_ENTER_AND_STOP_TRIGGER, "dd3","Dem3", nil );

function Dem3()
	RemoveObject("i3");
	sleep(2);
	CreateMonster( "m3", CREATURE_BALOR, 18, 107, 77, 1, MONSTER_MOOD_AGGRESSIVE, MONSTER_COURAGE_ALWAYS_FIGHT, 270 );
	Trigger( REGION_ENTER_AND_STOP_TRIGGER, "dd3",nil);
	Play2DSound( "/Maps/Scenario/A2C1M2/C1M2_VO8_Arantir_01sound.xdb#xpointer(/Sound)" ); ----------------VO_Pit_Lords	
end;

--C1M2_VO8_Arantir_01sound
-------------------------------------Dialogs-------------------------------

function dialog_1(hero)
	print(hero.." enter");
	if hero == PlayerHero then
		sleep(5);
		StartAdvMapDialog (3);   --------------------------------2_advmap_dialog
		Trigger( REGION_ENTER_AND_STOP_TRIGGER, "mage2",nil);
		sleep(3);
		startThread(caput_mage);
	end;
end;

function caput_mage()
	BlockGame();
	sleep(2);
	PlayVisualEffect( "/Effects/_(Effect)/Spells/LuckGood.xdb#xpointer(/Effect)", PlayerHero, "ara1", 0, 0, 0, 0, 0 );
	sleep(8);
	PlayVisualEffect( "/Effects/_(Effect)/Spells/LuckBad.xdb#xpointer(/Effect)", "mg", "mag1", 0, 0, 0, 0, 0 );
	sleep(5);
	RemoveObject( "mg" )
	UnblockGame();
	SetRegionBlocked("mage1", nil, PLAYER_1);
end


Trigger( REGION_ENTER_AND_STOP_TRIGGER, "mage2","dialog_1");


function dialog_2(hero)
	print(hero.." enter");
	if hero == PlayerHero then
		sleep(5);
		StartAdvMapDialog (2);   --------------------------------2_advmap_dialog
		Trigger( REGION_ENTER_AND_STOP_TRIGGER, "vamp1",nil);
	end;
end;

Trigger( REGION_ENTER_AND_STOP_TRIGGER, "vamp1","dialog_2" );
-----------------------------------------------------------------////death_knight_advmap_dialogs
function Death_kn_objective()
	while 1 do
		if GetObjectiveState("Neck") == OBJECTIVE_ACTIVE then
			SetObjectRotation( PlayerHero, 90 );
			SetObjectPosition( PlayerHero, 119, 122, GROUND );
			StartAdvMapDialog (0);   --------------------------------0_advmap_dialog
			sleep(2);
			startThread(Death_kn_objective2);
			Trigger(OBJECT_TOUCH_TRIGGER, "Neck_", "Death_kn_objective3");
			break;
		end;
	sleep( 3 );
	end;	
end;

function Death_kn_objective2()
	while 1 do
		if GetObjectiveState("Neck") == OBJECTIVE_COMPLETED then
			SetObjectRotation( PlayerHero, 90 );
			SetObjectPosition( PlayerHero, 119, 122, GROUND );
			StartAdvMapDialog (7);   --------------------------------7_advmap_dialog
			break;
		end;
	sleep( 3 );
	end;	
end;

function Death_kn_objective3()
startThread(Death_kn_objective3_1);
end;

function Death_kn_objective3_1()
	if GetObjectiveState("Neck") == OBJECTIVE_ACTIVE then
		SetObjectRotation( PlayerHero, 90 );
		SetObjectPosition( PlayerHero, 119, 122, GROUND );
		StartAdvMapDialog (8);   ------------------------------------8_advmap_dialog
	end;
end;

--Trigger(OBJECT_TOUCH_TRIGGER, "Neck", "Death_kn_objective3");
-------------------------------------//////Main
startThread(Death_kn_objective);
startThread(x2);
startThread(AIAction);

Trigger( NEW_DAY_TRIGGER, "Time_events",nil );

startThread(Main_hero_de);
startThread(Demon_obj);
startThread(Demon_kill);
startThread(Objective_prim1);
startThread(Complete_obj3);
startThread(Complete_sec2obj);
startThread(Complete_miss);
startThread(Diff_level);