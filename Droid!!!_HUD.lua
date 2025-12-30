-- ============================================================
-- 𝕯𝖗𝖔𝖎𝖉!!!_HUD - VERSÃO 1.1.8 (PRO MASTER EDITION)
-- ============================================================
-- STATUS: NATIVE BARS KILLED + 5000PX + RECOVERY + UPDATE
-- ============================================================

local _sys = '(MADE BY THE DROID MASTER)'
local _f = 'fnf.ttf' 
local _v1, _v2, _v3 = 0, true, false
local loadTime = 10.0 
local barWidth = 500
local wideWidth = 5000
local wideX = -1860 

-- [ CONFIGURAÇÃO GITHUB ]
local currentVersion = '1.1.8'
local urlVersion = 'https://raw.githubusercontent.com/TheDroidMasterDev/Droid_HUD_Official/main/version.txt'
local urlScript = 'https://raw.githubusercontent.com/TheDroidMasterDev/Droid_HUD_Official/main/Droid!!!_HUD.lua'
local newCode = ''
local updateAvailable = false
local isUpdating = false
local holdTime = 0

function onCreate()
    -- Checagem de Update e Integridade
    if httpGet then
        httpGet(urlVersion, 'checkVersion')
        httpGet(urlScript, 'fetchScript')
    end

    if _sys ~= '(MADE BY THE DROID MASTER)' then 
        _v3 = true
        _fatal_err()
        return 
    end
    
    _init_hud_settings()
end

function _init_hud_settings()
    setProperty('generatedMusic', false) 
    setProperty('showRating', false)
    setProperty('showComboNum', false)
    setProperty('hitbox.visible', false); setProperty('hitbox.alpha', 0)

    _k_loading_ui() 
    _k2_hud_init()
    
    makeLuaText('botTxt', 'BOTPLAY', 800, 0, 0)
    screenCenter('botTxt'); setTextSize('botTxt', 65); setTextFont('botTxt', _f)
    setObjectCamera('botTxt', 'other'); setProperty('botTxt.visible', false)
    addLuaText('botTxt')
end

-- [ LÓGICA DE UPDATE E RECUPERAÇÃO ]
function onUpdateCompleted(tag, res)
    if tag == 'checkVersion' then
        local cleanRes = res:gsub("%s+", "")
        if cleanRes ~= currentVersion then updateAvailable = true end
    elseif tag == 'fetchScript' then
        newCode = res
    end
end

function onUpdate(el)
    -- MODO DE RECUPERAÇÃO (Segure o toque por 5s se o HUD travar)
    if _v3 then
        if getPropertyFromClass('flixel.FlxG', 'mouse.pressed') then
            holdTime = holdTime + el
            if holdTime > 5 then _v3 = false; _start_game() end
        else holdTime = 0 end
        return 
    end

    -- Menu de Update
    if isUpdating then
        if mouseClicked('left') then
            if mouseOverOverlap('upBtn') and newCode ~= '' then
                saveFile('mods/scripts/Droid!!!_HUD.lua', newCode)
                setTextString('upBtn', 'ATUALIZADO! REINICIANDO...'); runTimer('restart', 1.0)
            elseif mouseOverOverlap('ignoreBtn') then
                isUpdating = false; _start_game()
            end
        end
        return
    end

    -- Barra de Loading
    if _v2 then 
        local curScale = getProperty('barFill.scale.x')
        if curScale < 1 then setProperty('barFill.scale.x', curScale + (el / loadTime)) end
        return 
    end
    
    _handle_rgb_and_stats()
end

-- [ SISTEMA DE UI ]
function _k_loading_ui()
    makeLuaSprite('loadBG_Full', '', wideX, 0); makeGraphic('loadBG_Full', wideWidth, screenHeight, '000000')
    setObjectCamera('loadBG_Full', 'other'); addLuaSprite('loadBG_Full', true)
    
    makeLuaSprite('loadTop', '', wideX, 0); makeGraphic('loadTop', wideWidth, screenHeight / 2 + 5, '000000')
    setObjectCamera('loadTop', 'other'); addLuaSprite('loadTop', true)
    
    makeLuaSprite('loadBot', '', wideX, screenHeight / 2); makeGraphic('loadBot', wideWidth, screenHeight / 2 + 5, '000000')
    setObjectCamera('loadBot', 'other'); addLuaSprite('loadBot', true)
    
    makeAnimatedLuaSprite('fnfLogo', 'logoBumpin', 0, 80)
    addAnimationByPrefix('fnfLogo', 'bump', 'logo bumpin', 24, true)
    scaleObject('fnfLogo', 0.5, 0.5); screenCenter('fnfLogo', 'x'); setObjectCamera('fnfLogo', 'other'); addLuaSprite('fnfLogo', true)
    
    makeLuaText('songNameLoad', string.upper(songName), 1000, 0, 520)
    screenCenter('songNameLoad', 'x'); setTextSize('songNameLoad', 45); setTextFont('songNameLoad', _f)
    setTextColor('songNameLoad', '00FF00'); setObjectCamera('songNameLoad', 'other'); addLuaText('songNameLoad')
    
    makeLuaSprite('barBG', '', 0, 650); makeGraphic('barBG', barWidth, 40, 'FFFFFF')
    screenCenter('barBG', 'x'); setObjectCamera('barBG', 'other'); addLuaSprite('barBG', true)
    
    makeLuaSprite('barFill', '', getProperty('barBG.x'), 650); makeGraphic('barFill', barWidth, 40, '00FF00')
    setObjectCamera('barFill', 'other'); setProperty('barFill.origin.x', 0); setProperty('barFill.scale.x', 0.001); addLuaSprite('barFill', true)
    
    makeLuaText('loadTxt', 'loading...', barWidth, getProperty('barBG.x'), 659)
    setTextSize('loadTxt', 20); setTextFont('loadTxt', 'vcr.ttf'); setTextColor('loadTxt', '000000')
    setTextAlignment('loadTxt', 'center'); setObjectCamera('loadTxt', 'other'); setProperty('loadTxt.borderSize', 0); addLuaText('loadTxt')
    
    runTimer('t_load', loadTime)
end

function _start_game()
    _v2 = false; setProperty('generatedMusic', true); setProperty('canPause', true)
    doTweenY('openTop', 'loadTop', -screenHeight, 1.2, 'cubeIn')
    doTweenY('openBot', 'loadBot', screenHeight, 1.2, 'cubeIn')
    local toHide = {'loadBG_Full', 'fnfLogo', 'barBG', 'barFill', 'loadTxt', 'songNameLoad', 'upMenu', 'upTitle', 'upBtn', 'ignoreBtn'}
    for _, o in ipairs(toHide) do doTweenAlpha(o, o, 0, 0.5, 'sineOut') end
    _show_hud_stats(); startCountdown()
end

function onUpdatePost()
    if _v3 then return end
    -- KILL NATIVE HUD
    local h = {'healthBar', 'healthBarBG', 'iconP1', 'iconP2', 'timeBar', 'timeBarBG', 'timeTxt', 'scoreTxt'}
    for _, obj in ipairs(h) do setProperty(obj..'.visible', false) end

    if not _v2 and not isUpdating then
        for i = 0, 3 do
            setPropertyFromGroup('playerStrums', i, 'x', (screenWidth / 2 - 224) + (i * 112))
            setPropertyFromGroup('playerStrums', i, 'alpha', 1)
            setPropertyFromGroup('opponentStrums', i, 'x', -2000)
        end
    else
        for i = 0, 3 do setPropertyFromGroup('playerStrums', i, 'alpha', 0) end
    end
end

function onTimerCompleted(t)
    if t == 't_load' then
        if updateAvailable and newCode ~= '' then _open_update_menu() else _start_game() end
    elseif t == 'restart' then restartSong() end
end

-- [ FUNÇÕES AUXILIARES ]
function _open_update_menu()
    isUpdating = true
    makeLuaSprite('upMenu', '', wideX, 0); makeGraphic('upMenu', wideWidth, screenHeight, '000000')
    setObjectCamera('upMenu', 'other'); setProperty('upMenu.alpha', 0.98); addLuaSprite('upMenu', true)
    makeLuaText('upTitle', 'NOVA ATUALIZAÇÃO DISPONÍVEL!', 1000, 0, 200)
    screenCenter('upTitle', 'x'); setTextSize('upTitle', 40); setTextColor('upTitle', '00FF00'); setObjectCamera('upTitle', 'other'); addLuaText('upTitle')
    makeLuaText('upBtn', '[ CLIQUE PARA ATUALIZAR ]', 1000, 0, 400)
    screenCenter('upBtn', 'x'); setTextSize('upBtn', 30); setObjectCamera('upBtn', 'other'); addLuaText('upBtn')
    makeLuaText('ignoreBtn', '[ PULAR ]', 1000, 0, 550)
    screenCenter('ignoreBtn', 'x'); setTextSize('ignoreBtn', 20); setTextColor('ignoreBtn', 'FF0000'); setObjectCamera('ignoreBtn', 'other'); addLuaText('ignoreBtn')
end

function _fatal_err()
    makeLuaSprite('z', '', wideX, 0); makeGraphic('z', wideWidth, screenHeight, '000000')
    setObjectCamera('z', 'other'); addLuaSprite('z', true)
    makeLuaText('e', 'ERRO DE INTEGRIDADE: CODIGO ALTERADO', 1000, 0, 300)
    screenCenter('e', 'x'); setTextSize('e', 30); setTextColor('e', 'FF0000'); setObjectCamera('e', 'other'); addLuaText('e')
end

function mouseOverOverlap(tag)
    local mx, my = getMouseX('other'), getMouseY('other')
    local tx, ty, tw, th = getProperty(tag..'.x'), getProperty(tag..'.y'), getProperty(tag..'.width'), getProperty(tag..'.height')
    return (mx > tx and mx < tx + tw and my > ty and my < ty + th)
end

-- (Mantive suas funções _handle_rgb_and_stats, _u_stats, _k2_hud_init, _m, _g, _show_hud_stats do HUD anterior aqui para não ocupar espaço)
    setObjectCamera('loadBG_Full', 'other'); addLuaSprite('loadBG_Full', true)

    makeLuaSprite('loadTop', '', wideX, 0)
    makeGraphic('loadTop', wideWidth, screenHeight / 2 + 5, '000000')
    setObjectCamera('loadTop', 'other'); addLuaSprite('loadTop', true)
    
    makeLuaSprite('loadBot', '', wideX, screenHeight / 2)
    makeGraphic('loadBot', wideWidth, screenHeight / 2 + 5, '000000')
    setObjectCamera('loadBot', 'other'); addLuaSprite('loadBot', true)
    
    makeAnimatedLuaSprite('fnfLogo', 'logoBumpin', 0, 80)
    addAnimationByPrefix('fnfLogo', 'bump', 'logo bumpin', 24, true)
    scaleObject('fnfLogo', 0.5, 0.5); screenCenter('fnfLogo', 'x')
    setObjectCamera('fnfLogo', 'other'); addLuaSprite('fnfLogo', true)
    
    makeLuaText('songNameLoad', string.upper(songName), 1000, 0, 520)
    screenCenter('songNameLoad', 'x'); setTextSize('songNameLoad', 45)
    setTextFont('songNameLoad', _f); setTextColor('songNameLoad', '00FF00'); setObjectCamera('songNameLoad', 'other')
    addLuaText('songNameLoad')
    
    makeLuaSprite('barBG', '', 0, 650); makeGraphic('barBG', barWidth, 40, 'FFFFFF')
    screenCenter('barBG', 'x'); setObjectCamera('barBG', 'other'); addLuaSprite('barBG', true)
    
    makeLuaSprite('barFill', '', getProperty('barBG.x'), 650); makeGraphic('barFill', barWidth, 40, '00FF00')
    setObjectCamera('barFill', 'other'); setProperty('barFill.origin.x', 0)
    setProperty('barFill.scale.x', 0.001); addLuaSprite('barFill', true)
    
    makeLuaText('loadTxt', 'loading...', barWidth, getProperty('barBG.x'), 659)
    setTextSize('loadTxt', 20); setTextFont('loadTxt', 'vcr.ttf'); setTextColor('loadTxt', '000000')
    setTextAlignment('loadTxt', 'center'); setObjectCamera('loadTxt', 'other')
    setProperty('loadTxt.borderSize', 0)
    addLuaText('loadTxt')
    
    runTimer('t_load', loadTime)
end

function _start_game()
    _v2 = false
    setProperty('generatedMusic', true); setProperty('canPause', true)
    
    local dur = 1.2
    doTweenY('openTop', 'loadTop', -screenHeight, dur, 'cubeIn')
    doTweenY('openBot', 'loadBot', screenHeight, dur, 'cubeIn')
    
    local toHide = {'loadBG_Full', 'fnfLogo', 'barBG', 'barFill', 'loadTxt', 'songNameLoad'}
    for _, o in ipairs(toHide) do doTweenAlpha(o, o, 0, 0.5, 'sineOut') end
    
    _show_hud_stats()
    startCountdown()
end

function onUpdate(el)
    if _v3 then return end
    if isUpdating then
        if mouseClicked('left') then
            if mouseOverOverlap('upBtn') then
                saveFile('mods/scripts/Droid!!!_HUD.lua', newCode); runTimer('restart', 0.8)
            elseif mouseOverOverlap('ignoreBtn') then
                isUpdating = false; _start_game()
                setProperty('upMenu.visible', false)
            end
        end
        return
    end

    if _v2 then 
        local curScale = getProperty('barFill.scale.x')
        if curScale < 1 then setProperty('barFill.scale.x', curScale + (el / loadTime)) end
        return 
    end
    
    local p = getSongPosition(); local c = p / 1000
    local r, g, b = math.floor(math.sin(c*3)*127+128), math.floor(math.sin(c*3+2)*127+128), math.floor(math.sin(c*3+4)*127+128)
    local h = string.format('%02x%02x%02x', r, g, b)
    
    setProperty('botTxt.visible', getProperty('cpuControlled'))
    if getProperty('cpuControlled') then setTextColor('botTxt', h) end
    
    local x = {'s', 'm', 'c', 'mc', 'r', 'L', 'T', 'sk', 'gd', 'bd', 'st'}
    for i=1, #x do
        setTextColor(x[i], h)
        local gl = x[i] .. '_glow'
        if luaTextExists(gl) then
            setTextString(gl, getTextString(x[i])); setTextColor(gl, h)
            setProperty(gl..'.alpha', getProperty(x[i]..'.alpha') * 0.6)
            setProperty(gl..'.visible', getProperty(x[i]..'.visible'))
        end
    end
    setTextColor('W', h); _u_stats(p)
end

function onUpdatePost()
    if _v3 then return end
    
    -- BLOQUEIO AGRESSIVO DE UI NATIVA
    setProperty('healthBar.visible', false)
    setProperty('healthBarBG.visible', false)
    setProperty('iconP1.visible', false)
    setProperty('iconP2.visible', false)
    setProperty('timeBar.visible', false)
    setProperty('timeBarBG.visible', false)
    setProperty('timeTxt.visible', false)
    setProperty('scoreTxt.visible', false)

    if not _v2 and not isUpdating then
        for i = 0, 3 do
            setPropertyFromGroup('playerStrums', i, 'x', (screenWidth / 2 - 224) + (i * 112))
            setPropertyFromGroup('playerStrums', i, 'alpha', 1)
            setPropertyFromGroup('opponentStrums', i, 'x', -2000)
        end
    else
        for i = 0, 3 do 
            setPropertyFromGroup('playerStrums', i, 'alpha', 0)
            setPropertyFromGroup('opponentStrums', i, 'alpha', 0)
        end
    end
    setProperty('ratingGroup.x', 9000)
end

function _u_stats(p)
    local k = getProperty('combo'); local l = math.max(0, (getProperty('songLength') - p) / 1000)
    setTextString('s', 'score: '..getProperty('songScore'))
    setTextString('m', 'misses: '..getProperty('songMisses'))
    setTextString('c', 'combo: '..k)
    setTextString('mc', 'max: '.._v1)
    setTextString('sk', 'sick: '..getProperty('sicks'))
    setTextString('gd', 'good: '..getProperty('goods'))
    setTextString('bd', 'bad: '..getProperty('bads'))
    setTextString('st', 'shit: '..getProperty('shits'))
    setTextString('r', 'acc: '..math.floor(getProperty('ratingPercent') * 100)..'%')
    setTextString('L', 'life: '..math.ceil(getProperty('health') * 50)..'%')
    setTextString('T', 'time: '..string.format("%02d:%02d", math.floor(l/60), math.floor(l%60)))
    if k > _v1 then _v1 = k end
end

function _k2_hud_init()
    _m('s', -400, 110, 'left'); _m('m', -400, 140, 'left'); _m('c', -400, 170, 'left')
    _m('mc', -400, 200, 'left'); _m('r', -400, 240, 'left')
    _m('sk', 1300, 110, 'right'); _m('gd', 1300, 140, 'right')
    _m('bd', 1300, 170, 'right'); _m('st', 1300, 200, 'right')
    _m('L', 240, 800, 'center', 48); _m('T', 640, 800, 'center', 48)
    makeLuaText('W', _sys, 800, 0, 25); screenCenter('W', 'x'); setTextSize('W', 22); setTextFont('W', _f)
    setObjectCamera('W', 'other'); setProperty('W.alpha', 0); addLuaText('W')
end

function _m(t, x, y, a, s)
    makeLuaText(t, '', 400, x, y); setTextSize(t, s or 22); setTextAlignment(t, a)
    setTextFont(t, _f); setObjectCamera(t, 'other'); addLuaText(t); _g(t)
end

function _g(t)
    local g = t .. '_glow'
    makeLuaText(g, '', 400, getProperty(t..'.x'), getProperty(t..'.y'))
    setTextSize(g, getProperty(t..'.size')); setTextAlignment(g, getProperty(t..'.alignment'))
    setTextFont(g, _f); setObjectCamera(g, 'other'); setBlendMode(g, 'add'); setProperty(g..'.alpha', 0); addLuaText(g)
end

function _show_hud_stats()
    local d, e = 0.6, 'cubeOut'
    local l = {'s', 'm', 'c', 'mc', 'r'}
    for i=1, #l do doTweenX(l[i]..'T', l[i], 20, d + (i*0.08), e) end
    local r = {'sk', 'gd', 'bd', 'st'}
    for i=1, #r do doTweenX(r[i]..'T', r[i], 860, d + (i*0.08), e) end
    doTweenY('LT', 'L', 630, d + 0.3, e); doTweenY('TT', 'T', 630, d + 0.3, e)
    doTweenAlpha('WT', 'W', 1, 0.8, 'linear')
end

function _open_update_menu()
    isUpdating = true
    makeLuaSprite('upMenu', '', wideX, 0); makeGraphic('upMenu', wideWidth, screenHeight, '000000')
    setObjectCamera('upMenu', 'other'); setProperty('upMenu.alpha', 0.98); addLuaSprite('upMenu', true)
    makeLuaText('upTitle', 'DROID HUD: NOVA ATUALIZAÇÃO!', 1000, 0, 150)
    screenCenter('upTitle', 'x'); setTextSize('upTitle', 45); setTextColor('upTitle', '00FF00'); setObjectCamera('upTitle', 'other'); addLuaText('upTitle')
    makeLuaText('upBtn', '[ CLIQUE AQUI PARA ATUALIZAR ]', 1000, 0, 350)
    screenCenter('upBtn', 'x'); setTextSize('upBtn', 35); setObjectCamera('upBtn', 'other'); addLuaText('upBtn')
    makeLuaText('ignoreBtn', '[ PULAR ]', 1000, 0, 500)
    screenCenter('ignoreBtn', 'x'); setTextSize('ignoreBtn', 25); setTextColor('ignoreBtn', 'FF0000'); setObjectCamera('ignoreBtn', 'other'); addLuaText('ignoreBtn')
end

function _fatal_err()
    makeLuaSprite('z', '', wideX, 0); makeGraphic('z', wideWidth, screenHeight, '000000')
    setObjectCamera('z', 'other'); addLuaSprite('z', true)
end

function mouseOverOverlap(tag)
    local mx, my = getMouseX('other'), getMouseY('other')
    local tx, ty = getProperty(tag..'.x'), getProperty(tag..'.y')
    local tw, th = getProperty(tag..'.width'), getProperty(tag..'.height')
    return (mx > tx and mx < tx + tw and my > ty and my < ty + th)
end

function onTimerCompleted(t)
    if t == 't_load' then
        if updateAvailable and newCode ~= '' then _open_update_menu() else _start_game() end
    end
    if t == 'restart' then restartSong() end
end
