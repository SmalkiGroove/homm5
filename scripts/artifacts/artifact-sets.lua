

function ScanHeroArtifacts(hero)
    for i = 1,10 do
        local pieces = 0
        for _,artifact in ARTIFACT_SETS[i] do
            if HasArtefact(hero, artifact, 1) then
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
    if artfset ~= 0 then
        if not contains(HERO_ACTIVE_ARTIFACT_SETS[hero], artfset) then
            print("Hero "..hero.." has artifact set "..artfset)
            insert(HERO_ACTIVE_ARTIFACT_SETS[hero], artfset)
        end
    end
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
