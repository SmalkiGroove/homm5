


function ScanHeroArtifacts(hero)
    for location = 1,10 do
        local loc = location
        if loc == 10 then loc = 7 end
        local artifact = HERO_EQUIPPED_ARTIFACTS[hero][location]
        if artifact == ARTIFACT_NONE then
            for _,a in ARTIFACT_LOCATIONS[loc] do
                if HasArtefact(hero, a, 1) then
                    if location == 7 and HERO_EQUIPPED_ARTIFACTS[hero][10] == a then break end
                    if location == 10 and HERO_EQUIPPED_ARTIFACTS[hero][7] == a then break end
                    print(hero.." now has artifact #"..a.." at location "..location)
                    UpdateArtifactSets(hero, artifact, a)
                    HERO_EQUIPPED_ARTIFACTS[hero][location] = a
                    break
                end
            end
        else
            if not HasArtefact(hero, artifact, 1) then
                local rep = ARTIFACT_NONE
                for _,a in ARTIFACT_LOCATIONS[loc] do
                    if HasArtefact(hero, a, 1) then
                        rep = a
                        break
                    end
                end
                print(hero.." has replaced artifact #"..artifact.." by #"..rep.." at location "..location)
                UpdateArtifactSets(hero, artifact, rep)
                HERO_EQUIPPED_ARTIFACTS[hero][location] = rep
            end
        end
    end
end

function UpdateArtifacts()
    for player = 1,8 do
        if IsPlayerCurrent(player) then
			for i,hero in GetPlayerHeroes(player) do
                print("Update artifact for hero "..hero)
                ScanHeroArtifacts(hero)
            end
        end
    end
end


HERO_EQUIPPED_ARTIFACTS = {
    -- haven
    [H_DUNCAN] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_DOUGAL] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_KLAUS] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_IRINA] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_ISABEL] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_LASZLO] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_NICOLAI] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_GODRIC] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_FREYDA] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_RUTGER] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_MAEVE] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_ELLAINE] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_ALARIC] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_GABRIELLE] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_ORLANDO] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_MARKAL] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    -- preserve
    [H_WYNGAAL] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_ANWEN] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_TALANAR] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_OSSIR] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_FINDAN] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_JENOVA] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_GILRAEN] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_KYRRE] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_IVOR] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_MEPHALA] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_ALARON] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_DIRAEL] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_VINRAEL] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_YLTHIN] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_TIERU] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_GEM] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_ELLESHAR] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    -- academy
    [H_HAVEZ] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_MINASLI] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_JOSEPHINE] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_RAZZAK] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_DAVIUS] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_RISSA] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_GURVILIN] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_JHORA] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_CYRUS] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_FAIZ] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_MAAHIR] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_NATHIR] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_NUR] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_GALIB] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_ZEHIR] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_THEODORUS] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_EMILIA] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    -- fortress
    [H_INGVAR] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_ROLF] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_WULFSTAN] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_TAZAR] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_MAXIMUS] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_KARLI] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_HEDWIG] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_TOLGHAR] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_EBBA] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_ULAND] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_HAEGEIR] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_HELMAR] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_BRAND] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_ERLING] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_HANGVUL] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_BART] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_INGA] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    -- necropolis
    [H_KASPAR] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_VLADIMIR] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_ORSON] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_ORNELLA2] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_LUCRETIA] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_XERXON] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_DEIRDRE] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_NAADIR] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_AISLINN] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_GIOVANNI] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_ARCHILUS] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_ZOLTAN] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_RAVEN] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_ARANTIR] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_THANT] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_SANDRO] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_VIDOMINA] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    -- inferno
    [H_GRAWL] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_NEBIROS] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_MARBAS] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_HARKENRAZ] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_CALH] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_SHELTEM] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_ALASTOR] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_GROK] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_NYMUS] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_JEZEBETH] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_MALUSTAR] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_AGRAEL] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_BIARA] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_KHABELETH] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_ZYDAR] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_DELEB] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_CALID] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    -- dungeon
    [H_SORGAL] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_KYTHRA] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_AGBETH] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_RANLETH] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_DARKSTORM] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_YRWANNA] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_VAYSHAN] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_THRALSAI] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_LETHOS] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_ERUINA] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_SYLSAI] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_SINITAR] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_SHADYA] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_RAELAG] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_YLAYA] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_SEPHINROTH] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_KASTORE] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    -- stronghold
    [H_TELSEK] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_GORSHAK] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_GOTAI] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_AZAR] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_MATEWA] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_KUNYAK] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_KRAGH] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_KILGHAN] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_CRAGHACK] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_KRAAL] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_SHAKKARUKAT] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_KUJIN] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_SHIVA] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_HAGGASH] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_MUKHA] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_URGHAT] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_GARUNA] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_ZOULEIKA] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
    [H_ERIKA] = {[1]=ARTIFACT_NONE, [2]=ARTIFACT_NONE, [3]=ARTIFACT_NONE, [4]=ARTIFACT_NONE, [5]=ARTIFACT_NONE, [6]=ARTIFACT_NONE, [7]=ARTIFACT_NONE, [8]=ARTIFACT_NONE, [9]=ARTIFACT_NONE, [10]=ARTIFACT_NONE},
}


-- print("Loaded artifact management script")
ROUTINES_LOADED[x_artifacts_manager] = 1
