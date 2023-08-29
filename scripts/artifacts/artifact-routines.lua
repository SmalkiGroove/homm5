
function NoneArtifactRoutine()
    --print("Do nothing")
end


ARTIFACT_ROUTINES = {
    [ARTIFACT_NONE] = NoneArtifactRoutine,
    [ARTIFACT_SWORD_OF_RUINS] = NoneArtifactRoutine,
    [ARTIFACT_GREAT_AXE_OF_GIANT_SLAYING] = NoneArtifactRoutine,
    [ARTIFACT_WAND_OF_X] = NoneArtifactRoutine,
    [ARTIFACT_UNICORN_HORN_BOW] = NoneArtifactRoutine,
    [ARTIFACT_TITANS_TRIDENT] = NoneArtifactRoutine,
    [ARTIFACT_STAFF_OF_VEXINGS] = NoneArtifactRoutine,
    [ARTIFACT_SHACKLES_OF_WAR] = NoneArtifactRoutine,
    [ARTIFACT_FOUR_LEAF_CLOVER] = NoneArtifactRoutine,
    [ARTIFACT_ICEBERG_SHIELD] = NoneArtifactRoutine,
    [ARTIFACT_GOLDEN_SEXTANT] = NoneArtifactRoutine,
    [ARTIFACT_CROWN_OF_COURAGE] = NoneArtifactRoutine,
    [ARTIFACT_CROWN_OF_MANY_EYES] = NoneArtifactRoutine,
    [ARTIFACT_PLATE_MAIL_OF_STABILITY] = NoneArtifactRoutine,
    [ARTIFACT_BREASTPLATE_OF_PETRIFIED_WOOD] = NoneArtifactRoutine,
    [ARTIFACT_PEDANT_OF_MASTERY] = NoneArtifactRoutine,
    [ARTIFACT_NECKLACE_OF_BRAVERY] = NoneArtifactRoutine,
    [ARTIFACT_WEREWOLF_CLAW_NECKLACE] = NoneArtifactRoutine,
    [ARTIFACT_EVERCOLD_ICICLE] = NoneArtifactRoutine,
    [ARTIFACT_NECKLACE_OF_POWER] = NoneArtifactRoutine,
    [ARTIFACT_RING_OF_LIGHTING_PROTECTION] = NoneArtifactRoutine,
    [ARTIFACT_RING_OF_LIFE] = NoneArtifactRoutine,
    [ARTIFACT_RING_OF_HASTE] = NoneArtifactRoutine,
    [ARTIFACT_NIGHTMARISH_RING] = NoneArtifactRoutine,
    [ARTIFACT_BOOTS_OF_SPEED] = NoneArtifactRoutine,
    [ARTIFACT_GOLDEN_HORSESHOE] = NoneArtifactRoutine,
    [ARTIFACT_WAYFARER_BOOTS] = NoneArtifactRoutine,
    [ARTIFACT_BOOTS_OF_INTERFERENCE] = NoneArtifactRoutine,
    [ARTIFACT_ENDLESS_SACK_OF_GOLD] = NoneArtifactRoutine,
    [ARTIFACT_ENDLESS_BAG_OF_GOLD] = NoneArtifactRoutine,
    [ARTIFACT_ANGEL_WINGS] = NoneArtifactRoutine,
    [ARTIFACT_LION_HIDE_CAPE] = NoneArtifactRoutine,
    [ARTIFACT_PHOENIX_FEATHER_CAPE] = NoneArtifactRoutine,
    [ARTIFACT_CLOAK_OF_MOURNING] = NoneArtifactRoutine,
    [ARTIFACT_HELM_OF_ENLIGHTMENT] = NoneArtifactRoutine,
    [ARTIFACT_CHAIN_MAIL_OF_ENLIGHTMENT] = NoneArtifactRoutine,
    [ARTIFACT_DRAGON_SCALE_ARMOR] = NoneArtifactRoutine,
    [ARTIFACT_DRAGON_SCALE_SHIELD] = NoneArtifactRoutine,
    [ARTIFACT_DRAGON_BONE_GRAVES] = NoneArtifactRoutine,
    [ARTIFACT_DRAGON_WING_MANTLE] = NoneArtifactRoutine,
    [ARTIFACT_DRAGON_TEETH_NECKLACE] = NoneArtifactRoutine,
    [ARTIFACT_DRAGON_TALON_CROWN] = NoneArtifactRoutine,
    [ARTIFACT_DRAGON_EYE_RING] = NoneArtifactRoutine,
    [ARTIFACT_DRAGON_FLAME_TONGUE] = NoneArtifactRoutine,
    [ARTIFACT_ROBE_OF_MAGI] = NoneArtifactRoutine,
    [ARTIFACT_STAFF_OF_MAGI] = NoneArtifactRoutine,
    [ARTIFACT_CROWN_OF_MAGI] = NoneArtifactRoutine,
    [ARTIFACT_RING_OF_MAGI] = NoneArtifactRoutine,
    [ARTIFACT_DWARVEN_MITHRAL_CUIRASS] = NoneArtifactRoutine,
    [ARTIFACT_DWARVEN_MITHRAL_GREAVES] = NoneArtifactRoutine,
    [ARTIFACT_DWARVEN_MITHRAL_HELMET] = NoneArtifactRoutine,
    [ARTIFACT_DWARVEN_MITHRAL_SHIELD] = NoneArtifactRoutine,
    [ARTIFACT_SCROLL_OF_SPELL_X] = NoneArtifactRoutine,
    [ARTIFACT_GRAAL] = NoneArtifactRoutine,
    [ARTIFACT_BOOTS_OF_LEVITATION] = NoneArtifactRoutine,
    [ARTIFACT_SKULL_HELMET] = NoneArtifactRoutine,
    [ARTIFACT_VALORIOUS_ARMOR] = NoneArtifactRoutine,
    [ARTIFACT_BOOTS_OF_SWIFTNESS] = NoneArtifactRoutine,
    [ARTIFACT_MOONBLADE] = NoneArtifactRoutine,
    [ARTIFACT_RING_OF_CELERITY] = NoneArtifactRoutine,
    [ARTIFACT_BAND_OF_CONJURER] = NoneArtifactRoutine,
    [ARTIFACT_EARTHSLIDERS] = NoneArtifactRoutine,
    [ARTIFACT_RIGID_MANTLE] = NoneArtifactRoutine,
    [ARTIFACT_JINXING_BAND] = NoneArtifactRoutine,
    [ARTIFACT_BONESTUDDED_LEATHER] = NoneArtifactRoutine,
    [ARTIFACT_WISPERING_RING] = NoneArtifactRoutine,
    [ARTIFACT_HELM_OF_CHAOS] = NoneArtifactRoutine,
    [ARTIFACT_TWISTING_NEITHER] = NoneArtifactRoutine,
    [ARTIFACT_SANDALS_OF_THE_SAINT] = NoneArtifactRoutine,
    [ARTIFACT_SHAWL_OF_GREAT_LICH] = NoneArtifactRoutine,
    [ARTIFACT_RING_OF_DEATH] = NoneArtifactRoutine,
    [ARTIFACT_NECROMANCER_PENDANT] = NoneArtifactRoutine,
    [ARTIFACT_FREIDA] = NoneArtifactRoutine,
    [ARTIFACT_RING_OF_THE_SHADOWBRAND] = NoneArtifactRoutine,
    [ARTIFACT_OGRE_CLUB] = NoneArtifactRoutine,
    [ARTIFACT_OGRE_SHIELD] = NoneArtifactRoutine,
    [ARTIFACT_TOME_OF_DESTRUCTION] = NoneArtifactRoutine,
    [ARTIFACT_TOME_OF_LIGHT_MAGIC] = NoneArtifactRoutine,
    [ARTIFACT_TOME_OF_DARK_MAGIC] = NoneArtifactRoutine,
    [ARTIFACT_TOME_OF_SUMMONING_MAGIC] = NoneArtifactRoutine,
    [ARTIFACT_BEGINNER_MAGIC_STICK] = NoneArtifactRoutine,
    [ARTIFACT_RUNIC_WAR_AXE] = NoneArtifactRoutine,
    [ARTIFACT_RUNIC_WAR_HARNESS] = NoneArtifactRoutine,
    [ARTIFACT_SKULL_OF_MARKAL] = NoneArtifactRoutine,
    [ARTIFACT_BEARHIDE_WRAPS] = NoneArtifactRoutine,
    [ARTIFACT_DWARVEN_SMITHY_HUMMER] = NoneArtifactRoutine,
    [ARTIFACT_RUNE_OF_FLAME] = NoneArtifactRoutine,
    [ARTIFACT_TAROT_DECK] = NoneArtifactRoutine,
    [ARTIFACT_CROWN_OF_LEADER] = NoneArtifactRoutine,
    [ARTIFACT_MASK_OF_DOPPELGANGER] = NoneArtifactRoutine,
    [ARTIFACT_EDGE_OF_BALANCE] = NoneArtifactRoutine,
    [ARTIFACT_RING_OF_MACHINE_AFFINITY] = NoneArtifactRoutine,
    [ARTIFACT_HORN_OF_PLENTY] = NoneArtifactRoutine,
    [ARTIFACT_RING_OF_UNSUMMONING] = NoneArtifactRoutine,
    [ARTIFACT_BOOK_OF_POWER] = NoneArtifactRoutine,
    [ARTIFACT_TREEBORN_QUIVER] = NoneArtifactRoutine,
    [ARTIFACT_PRINCESS] = NoneArtifactRoutine,
    [ARTIFACT_RES_WOOD] = NoneArtifactRoutine,
    [ARTIFACT_RES_ORE] = NoneArtifactRoutine,
    [ARTIFACT_RES_SULPHUR] = NoneArtifactRoutine,
    [ARTIFACT_RES_CRYSTAL] = NoneArtifactRoutine,
    [ARTIFACT_RES_GEM] = NoneArtifactRoutine,
    [ARTIFACT_RES_MERCURY] = NoneArtifactRoutine,	
    [ARTIFACT_LEGION_T1] = NoneArtifactRoutine,
    [ARTIFACT_LEGION_T2] = NoneArtifactRoutine,
    [ARTIFACT_LEGION_T3] = NoneArtifactRoutine,
    [ARTIFACT_LEGION_T4] = NoneArtifactRoutine,
    [ARTIFACT_LEGION_T5] = NoneArtifactRoutine,
    [ARTIFACT_LEGION_T6] = NoneArtifactRoutine,
    [ARTIFACT_LEGION_T7] = NoneArtifactRoutine,
    [ARTIFACT_STEADFAST] = NoneArtifactRoutine,
    [ARTIFACT_BUCKLER] = NoneArtifactRoutine,
    [ARTIFACT_LIFE_01] = NoneArtifactRoutine,
    [ARTIFACT_LIFE_02] = NoneArtifactRoutine,
    [ARTIFACT_LIFE_03] = NoneArtifactRoutine,
    [ARTIFACT_LIFE_04] = NoneArtifactRoutine,
    [ARTIFACT_MONK_01] = NoneArtifactRoutine,
    [ARTIFACT_MONK_02] = NoneArtifactRoutine,
    [ARTIFACT_MONK_03] = NoneArtifactRoutine,
    [ARTIFACT_MONK_04] = NoneArtifactRoutine,
    [ARTIFACT_GUARDIAN_01] = NoneArtifactRoutine,
    [ARTIFACT_GUARDIAN_02] = NoneArtifactRoutine,
    [ARTIFACT_GUARDIAN_03] = NoneArtifactRoutine,
    [ARTIFACT_DRACONIC] = NoneArtifactRoutine,
    [ARTIFACT_SENTINEL] = NoneArtifactRoutine,
    [ARTIFACT_EIGHTFOLD] = NoneArtifactRoutine,
    [ARTIFACT_CODEX] = NoneArtifactRoutine,
    [ARTIFACT_PIRATE01] = NoneArtifactRoutine,
    [ARTIFACT_PIRATE02] = NoneArtifactRoutine,
    [ARTIFACT_PIRATE03] = NoneArtifactRoutine,
    [ARTIFACT_PIRATE04] = NoneArtifactRoutine,
    [ARTIFACT_PIRATE05] = NoneArtifactRoutine,
    [ARTIFACT_PIRATE06] = NoneArtifactRoutine,	
    [ARTIFACT_MEDICAL01] = NoneArtifactRoutine,
    [ARTIFACT_MEDICAL02] = NoneArtifactRoutine,
    [ARTIFACT_MEDICAL03] = NoneArtifactRoutine,
    [ARTIFACT_MEDICAL04] = NoneArtifactRoutine,
    [ARTIFACT_POTION01] = NoneArtifactRoutine,	
    [ARTIFACT_POTION02] = NoneArtifactRoutine,		
    [ARTIFACT_POTION03] = NoneArtifactRoutine,
    [ARTIFACT_BOOK_A1] = NoneArtifactRoutine,
    [ARTIFACT_BOOK_A2] = NoneArtifactRoutine,
    [ARTIFACT_BOOK_A3] = NoneArtifactRoutine,
    [ARTIFACT_BOOK_A4] = NoneArtifactRoutine,
    [ARTIFACT_BOOK_D1] = NoneArtifactRoutine,
    [ARTIFACT_BOOK_D2] = NoneArtifactRoutine,
    [ARTIFACT_BOOK_D3] = NoneArtifactRoutine,
    [ARTIFACT_BOOK_D4] = NoneArtifactRoutine,
    [ARTIFACT_BOOK_S1] = NoneArtifactRoutine,
    [ARTIFACT_BOOK_S2] = NoneArtifactRoutine,
    [ARTIFACT_BOOK_S3] = NoneArtifactRoutine,
    [ARTIFACT_BOOK_S4] = NoneArtifactRoutine,
    [ARTIFACT_BOOK_K1] = NoneArtifactRoutine,
    [ARTIFACT_BOOK_K2] = NoneArtifactRoutine,
    [ARTIFACT_BOOK_K3] = NoneArtifactRoutine,
    [ARTIFACT_BOOK_K4] = NoneArtifactRoutine,
    [ARTIFACT_BOOK_R1] = NoneArtifactRoutine,	
    [ARTIFACT_BOOK_R2] = NoneArtifactRoutine,	
    [ARTIFACT_BOOK_R3] = NoneArtifactRoutine,	
    [ARTIFACT_SHANTIRI_01] = NoneArtifactRoutine,	
    [ARTIFACT_SHANTIRI_02] = NoneArtifactRoutine,	
    [ARTIFACT_SHANTIRI_03] = NoneArtifactRoutine,	
    [ARTIFACT_SHANTIRI_04] = NoneArtifactRoutine,	
    [ARTIFACT_SHANTIRI_05] = NoneArtifactRoutine,	
    [ARTIFACT_UPG_AR1] = NoneArtifactRoutine,	
    [ARTIFACT_UPG_AR2] = NoneArtifactRoutine,
    [ARTIFACT_UPG_AR3] = NoneArtifactRoutine,	
    [ARTIFACT_UPG_HM1] = NoneArtifactRoutine,	
    [ARTIFACT_UPG_HM2] = NoneArtifactRoutine,
    [ARTIFACT_UPG_HM3] = NoneArtifactRoutine,
    [ARTIFACT_UPG_ST1] = NoneArtifactRoutine,
    [ARTIFACT_UPG_ST2] = NoneArtifactRoutine,
    [ARTIFACT_UPG_ST3] = NoneArtifactRoutine,
    [ARTIFACT_UPG_SW1] = NoneArtifactRoutine,	
    [ARTIFACT_UPG_SW2] = NoneArtifactRoutine,
    [ARTIFACT_UPG_SW3] = NoneArtifactRoutine,	
    [ARTIFACT_FIZBIN] = NoneArtifactRoutine,
    [ARTIFACT_FORGING] = NoneArtifactRoutine,				
    [ARTIFACT_URGASH_01] = NoneArtifactRoutine,	
    [ARTIFACT_URGASH_02] = NoneArtifactRoutine,
    [ARTIFACT_ELRATH_01] = NoneArtifactRoutine,		
    [ARTIFACT_ELRATH_02] = NoneArtifactRoutine,	
    [ARTIFACT_GOVERNOR_01] = NoneArtifactRoutine,
    [ARTIFACT_GOVERNOR_02] = NoneArtifactRoutine,				
    [ARTIFACT_GEAR_01] = NoneArtifactRoutine,
    [ARTIFACT_GEAR_02] = NoneArtifactRoutine,
    [ARTIFACT_GEAR_03] = NoneArtifactRoutine,
    [ARTIFACT_GEAR_04] = NoneArtifactRoutine,
    [ARTIFACT_GEAR_05] = NoneArtifactRoutine,	
    [ARTIFACT_GEAR_06] = NoneArtifactRoutine,	
    [ARTIFACT_GEAR_07] = NoneArtifactRoutine,	
    [ARTIFACT_GEAR_08] = NoneArtifactRoutine,	
    [ARTIFACT_ORB_01] = NoneArtifactRoutine,
    [ARTIFACT_ORB_02] = NoneArtifactRoutine,
    [ARTIFACT_ORB_03] = NoneArtifactRoutine,
    [ARTIFACT_ORB_04] = NoneArtifactRoutine,
}

ARTIFACT_SETS_ROUTINES = {
    
}



DAILY_ARTIFACT_ROUTINES = {

}

WEEKLY_ARTIFACT_ROUTINES = {

}

AFTERCOMBAT_ARTIFACT_ROUTINES = {

}

LEVELUP_ARTIFACT_ROUTINES = {

}



function EnableArtifactRoutine(hero, artifact)

end


-- print("Loaded artifact routines script")
ROUTINES_LOADED[16] = 1
