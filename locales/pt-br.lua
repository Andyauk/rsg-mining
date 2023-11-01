local Translations = {
error = {
    you_dont_have_pickaxe = "você não possui uma picareta!",
    something_went_wrong = 'algo deu errado!',
},
success = {
    your_pickaxe_broke = 'sua picareta quebrou!',
},
primary = {
    you_are_busy_the_moment = 'você está ocupado no momento!',
    small_haul_time = 'tempo de pequena carga!',
    lucky_haul_time = 'Got lucky this time! ',  -- Please translate
    destroyed_rock = 'You destroyed the rock. Luck ran out on this one! ',   -- Please translate
    medium_haul_this_time = 'tempo de média carga desta vez!',
    largq_haul_this_time = 'tempo de grande carga desta vez!',
},
menu = {
    start = 'Iniciar ',
},
commands = {
    var = 'o texto vai aqui',
},
progressbar = {
    var = 'o texto vai aqui',
},
}

if GetConvar('rsg_locale', 'en') == 'pt-br' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
