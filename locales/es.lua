local Translations = {
    error = {
        you_dont_have_pickaxe = "¡No tienes un pico!",
        something_went_wrong = '¡algo salió mal!',
    },
    success = {
        your_pickaxe_broke = '¡Se rompió el pico!',
    },
    primary = {
        you_are_busy_the_moment = 'Estas ocupado!',
        small_haul_time = 'hora de un pequeño botín!',
        lucky_haul_time = 'Caiste con suerte esta vez! ',
        destroyed_rock = 'Destruistes la piedra, Ya no hay mas suerte con esta! ',
        medium_haul_this_time = 'hora de un mediano botín!',
        largq_haul_this_time = 'hora de un gran botín!',
    },
    menu = {
        start = 'Inciar ',
    },
    commands = {
        var = 'text goes here',
    },
    progressbar = {
        var = 'text goes here',
    },
}

if GetConvar('rsg_locale', 'en') == 'es' then
  Lang = Locale:new({
      phrases = Translations,
      warnOnMissing = true,
      fallbackLang = Lang,
  })
end
