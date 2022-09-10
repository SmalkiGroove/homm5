
RECRUITED_TRIGGERS = {};
LEVEL_UP_TRIGGERS = {};


for i,hero in LEVEL_UP_TRIGGERS do
    Trigger(HERO_LEVELUP_TRIGGER,hero,"LevelUpTrigger_"..hero);
end;