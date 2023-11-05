local Translations = {
    error = {
        you_dont_have_pickaxe = "¡No tienes un pico!",
        you_dont_have_the_required_items = "¡Te hacen Falta materiles! ",
        something_went_wrong = '¡algo salió mal!',
        no_stone = 'No tienes mas piedra para lavar!',
        destroyed_rock = 'Destruistes la piedra, Ya no hay mas suerte con esta! ',
    },
    success = {
        your_pickaxe_broke = '¡Se rompió el pico!',
        smelting_successful = 'Extgraistes con exito '
    },
    primary = {
        you_are_busy_the_moment = 'Estas ocupado!',
        small_haul_time = 'hora de un pequeño botín!',
        lucky_haul_time = 'Caiste con suerte esta vez! ',
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
