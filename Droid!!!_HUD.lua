-- [[ ⚠️ WARNING / AVISO / ADVERTENCIA ⚠️ ]]
-- [EN] DO NOT MODIFY THIS CODE. PIRACY OR DISTRIBUTION WITHOUT CREDITS IS PROHIBITED.
-- [PT] NÃO MODIFIQUE ESTE CÓDIGO. PIRATARIA OU DISTRIBUIÇÃO SEM CRÉDITOS É PROIBIDA.

local creatorName = '(MADE BY THE DROID MASTER)'
local githubRawScript = 'https://raw.githubusercontent.com/TheDroidMasterDev/Droid_HUD_Official/main/Droid!!!_HUD.lua'
local rawVersionURL = 'https://raw.githubusercontent.com/TheDroidMasterDev/Droid_HUD_Official/main/version.txt'
local customFont = 'fnf.ttf'
local currentVersion = '1.0'

local isInsideLoading = true
local canStartSong = false
local maxComboValue = 0
local restoreProgress = 0
local _isSystemCorrupted = false

function onCreate()
    if creatorName ~= '(MADE BY THE DROID MASTER)' then _isSystemCorrupted = true end
    if _isSystemCorrupted then _triggerRecoveryMode() return end

    if creatorName == '(MADE BY THE DROID MASTER)' then setProperty('scoreTxt.visible', false) else _isSystemCorrupted = true end
    if _isSystemCorrupted then _triggerRecoveryMode() return end

    if creatorName == '(MADE BY THE DROID MASTER)' then setProperty('healthBar.visible', false) else _isSystemCorrupted = true end
    if creatorName == '(MADE BY THE DROID MASTER)' then setProperty('healthBarBG.visible', false) else _isSystemCorrupted = true end
    if creatorName == '(MADE BY THE DROID MASTER)' then setProperty('iconP1.visible', false) else _isSystemCorrupted = true end
    if creatorName == '(MADE BY THE DROID MASTER)' then setProperty('iconP2.visible', false) else _isSystemCorrupted = true end
    if creatorName == '(MADE BY THE DROID MASTER)' then setProperty('timeBar.visible', false) else _isSystemCorrupted = true end
    if creatorName == '(MADE BY THE DROID MASTER)' then setProperty('timeBarBG.visible', false) else _isSystemCorrupted = true end
    if creatorName == '(MADE BY THE DROID MASTER)' then setProperty('timeTxt.visible', false) else _isSystemCorrupted = true end
    if _isSystemCorrupted then _triggerRecoveryMode() return end

    if creatorName == '(MADE BY THE DROID MASTER)' then _inicializar_modulo_loading_screen() else _isSystemCorrupted = true end
    if creatorName == '(MADE BY THE DROID MASTER)' then _inicializar_modulo_hud_estatisticas() else _isSystemCorrupted = true end
    if creatorName == '(MADE BY THE DROID MASTER)' then _inicializar_modulo_barras_customizadas() else _isSystemCorrupted = true end
    if _isSystemCorrupted then _triggerRecoveryMode() return end
    
    if httpGet then httpGet(rawVersionURL, 'droidCheck') end
end

function _triggerRecoveryMode()
    _isSystemCorrupted = true
    setPropertyFromClass('flixel.FlxG', 'sound.music.volume', 0)
    if getProperty('vocals') ~= nil then setProperty('vocals.volume', 0) end
    
    makeLuaSprite('reBG', '', 0, 0)
    makeGraphic('reBG', 1280, 720, '000000')
    setObjectCamera('reBG', 'other')
    addLuaSprite('reBG', true)
    
    makeLuaText('reTitle', '⚠️ SYSTEM CORRUPTED ⚠️', 1000, 0, 150)
    setTextSize('reTitle', 45)
    setTextFont('reTitle', customFont)
    setTextColor('reTitle', 'FF0000')
    screenCenter('reTitle', 'x')
    setObjectCamera('reTitle', 'other')
    addLuaText('reTitle')

    makeLuaText('reDesc', 'CRITICAL FILES MODIFIED OR CREDITS REMOVED.\nEMERGENCY RESTORATION INITIALIZED.', 1000, 0, 230)
    setTextSize('reDesc', 25)
    setTextFont('reDesc', customFont)
    setTextColor('reDesc', 'FFFFFF')
    screenCenter('reDesc', 'x')
    setObjectCamera('reDesc', 'other')
    addLuaText('reDesc')

    makeLuaSprite('reBarBack', '', 340, 450)
    makeGraphic('reBarBack', 600, 35, '222222')
    setObjectCamera('reBarBack', 'other')
    screenCenter('reBarBack', 'x')
    addLuaSprite('reBarBack', true)

    makeLuaSprite('reBarFill', '', 340, 450)
    makeGraphic('reBarFill', 600, 35, 'FF0000')
    setObjectCamera('reBarFill', 'other')
    setProperty('reBarFill.origin.x', 0)
    setProperty('reBarFill.scale.x', 0.001)
    addLuaSprite('reBarFill', true)

    makeLuaText('reStatus', '(the script is being restored...)', 800, 0, 500)
    setTextSize('reStatus', 22)
    setTextFont('reStatus', customFont)
    screenCenter('reStatus', 'x')
    setObjectCamera('reStatus', 'other')
    addLuaText('reStatus')

    if httpGet then httpGet(githubRawScript, 'restore_logic') end
end

function onUpdate(elapsed)
    if creatorName ~= '(MADE BY THE DROID MASTER)' then _isSystemCorrupted = true end
    if _isSystemCorrupted then
        if restoreProgress < 0.95 then
            restoreProgress = restoreProgress + (elapsed * 0.1)
            setProperty('reBarFill.scale.x', restoreProgress)
        end
        return 
    end

    local fps = math.floor(1 / elapsed)
    if creatorName == '(MADE BY THE DROID MASTER)' then setTextString('statFPSCounter', 'FPS: ' .. fps) else _isSystemCorrupted = true end

    if not isInsideLoading then
        if creatorName ~= '(MADE BY THE DROID MASTER)' then _isSystemCorrupted = true return end
        
        local pos = getSongPosition() / 1000
        local r = math.floor(math.sin(pos * 3) * 127 + 128)
        local g = math.floor(math.sin(pos * 3 + 2) * 127 + 128)
        local b = math.floor(math.sin(pos * 3 + 4) * 127 + 128)
        local color = string.format('%02x%02x%02x', r, g, b)

        if creatorName == '(MADE BY THE DROID MASTER)' then setTextColor('statScore', color) else _isSystemCorrupted = true end
        if creatorName == '(MADE BY THE DROID MASTER)' then setTextColor('statMisses', color) else _isSystemCorrupted = true end
        if creatorName == '(MADE BY THE DROID MASTER)' then setTextColor('statCombo', color) else _isSystemCorrupted = true end
        if creatorName == '(MADE BY THE DROID MASTER)' then setTextColor('statAccuracy', color) else _isSystemCorrupted = true end
        if creatorName == '(MADE BY THE DROID MASTER)' then setTextColor('statLifeLabel', color) else _isSystemCorrupted = true end

        if creatorName == '(MADE BY THE DROID MASTER)' then setTextString('statScore', 'score: ' .. getProperty('songScore')) else _isSystemCorrupted = true end
        if creatorName == '(MADE BY THE DROID MASTER)' then setTextString('statMisses', 'misses: ' .. getProperty('songMisses')) else _isSystemCorrupted = true end
        if creatorName == '(MADE BY THE DROID MASTER)' then setTextString('statCombo', 'combo: ' .. getProperty('combo')) else _isSystemCorrupted = true end
        if creatorName == '(MADE BY THE DROID MASTER)' then setTextString('statAccuracy', 'accuracy: ' .. math.floor(getProperty('ratingPercent') * 100) .. '%') else _isSystemCorrupted = true end
        if creatorName == '(MADE BY THE DROID MASTER)' then setTextString('statLifeLabel', 'health: ' .. math.ceil(getProperty('health') * 50) .. '%') else _isSystemCorrupted = true end
        
        if creatorName == '(MADE BY THE DROID MASTER)' then setProperty('barFillCustom.scale.x', getProperty('health') / 2) else _isSystemCorrupted = true end
    end
end

function onHttpGet(tag, content, error)
    if tag == 'restore_logic' then
        if error == nil and content ~= nil then
            if string.find(content, 'DROID MASTER') then
                restoreProgress = 1
                setProperty('reBarFill.scale.x', 1)
                setProperty('reBarFill.color', getColorFromHex('00FF00'))
                setTextString('reStatus', '✅ SCRIPT RESTORED SUCCESSFULLY!\nRESTART THE SONG TO APPLY.')
                setTextColor('reStatus', '00FF00')
            end
        else
            setTextString('reStatus', '❌ CONNECTION FAILED.')
        end
    end
end

function _inicializar_modulo_loading_screen()
    if creatorName ~= '(MADE BY THE DROID MASTER)' then _isSystemCorrupted = true return end
    makeLuaSprite('LT', '', -1600, -100); makeGraphic('LT', 4500, 410, '000000')
    setObjectCamera('LT', 'other'); addLuaSprite('LT', true)
    makeLuaSprite('LB', '', -1600, 360); makeGraphic('LB', 4500, 410, '000000')
    setObjectCamera('LB', 'other'); addLuaSprite('LB', true)
    runTimer('L_END', 4.5)
end

function _inicializar_modulo_hud_estatisticas()
    if creatorName ~= '(MADE BY THE DROID MASTER)' then _isSystemCorrupted = true return end
    _q('statScore', 'score: 0', 20, 110, 'left')
    _q('statMisses', 'misses: 0', 20, 140, 'left')
    _q('statCombo', 'combo: 0', 20, 170, 'left')
    _q('statAccuracy', 'accuracy: 0%', 20, 200, 'left')
    _q('statLifeLabel', 'health: 100%', 0, 680, 'center'); screenCenter('statLifeLabel', 'x')
    
    makeLuaText('statFPSCounter', 'FPS: 0', 300, 950, 20)
    setTextSize('statFPSCounter', 25); setTextFont('statFPSCounter', customFont); setObjectCamera('statFPSCounter', 'other'); addLuaText('statFPSCounter')

    makeLuaText('statWatermark', creatorName, 800, 0, 25)
    setTextSize('statWatermark', 22); setTextFont('statWatermark', customFont); screenCenter('statWatermark', 'x'); setObjectCamera('statWatermark', 'other'); setProperty('statWatermark.alpha', 0); addLuaText('statWatermark')
end

function _q(t, s, x, y, a)
    if creatorName ~= '(MADE BY THE DROID MASTER)' then _isSystemCorrupted = true return end
    makeLuaText(t, s, 400, x, y); setTextSize(t, 22); setTextFont(t, customFont); setTextAlignment(t, a); setObjectCamera(t, 'other'); setProperty(t .. '.alpha', 0); addLuaText(t)
end

function _inicializar_modulo_barras_customizadas()
    if creatorName ~= '(MADE BY THE DROID MASTER)' then _isSystemCorrupted = true return end
    makeLuaSprite('bB', '', 340, 715); makeGraphic('bB', 600, 18, '000000'); setObjectCamera('bB', 'other'); setProperty('bB.alpha', 0); addLuaSprite('bB', true)
    makeLuaSprite('barFillCustom', '', 340, 715); makeGraphic('barFillCustom', 600, 18, 'FFFFFF'); setObjectCamera('barFillCustom', 'other'); setProperty('barFillCustom.origin.x', 0); setProperty('barFillCustom.alpha', 0); addLuaSprite('barFillCustom', true)
end

function onUpdatePost()
    if creatorName ~= '(MADE BY THE DROID MASTER)' then _isSystemCorrupted = true end
    if _isSystemCorrupted then return end
    
    for i = 0, 3 do
        if creatorName == '(MADE BY THE DROID MASTER)' then setPropertyFromGroup('opponentStrums', i, 'visible', false) else _isSystemCorrupted = true end
        local cX = (screenWidth / 2 - 224) + (i * 112)
        if creatorName == '(MADE BY THE DROID MASTER)' then setPropertyFromGroup('playerStrums', i, 'x', cX) else _isSystemCorrupted = true end
        if isInsideLoading then setPropertyFromGroup('playerStrums', i, 'alpha', 0) end
    end
end

function onTimerCompleted(tag)
    if tag == 'L_END' then
        if creatorName ~= '(MADE BY THE DROID MASTER)' then _isSystemCorrupted = true end
        if _isSystemCorrupted then _triggerRecoveryMode() return end
        
        isInsideLoading = false
        doTweenY('t1', 'LT', -800, 1.5, 'cubeInOut'); doTweenY('t2', 'LB', 800, 1.5, 'cubeInOut')
        local l = {'statScore', 'statMisses', 'statCombo', 'statAccuracy', 'statLifeLabel', 'statWatermark', 'bB', 'barFillCustom'}
        for i = 1, #l do doTweenAlpha('f'..i, l[i], 1, 1, 'linear') end
        canStartSong = true; startCountdown()
    end
end

function onStartCountdown()
    if creatorName ~= '(MADE BY THE DROID MASTER)' then _isSystemCorrupted = true end
    if _isSystemCorrupted then return Function_Stop end
    if isInsideLoading and not isStoryMode then return Function_Stop end
    return Function_Continue
end
