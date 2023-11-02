local Translations = {
    error = {
        you_dont_have_pickaxe = "you don\'t have a pickaxe!",
        something_went_wrong = 'something went wrong!',
        no_stone = 'You have no more stone to wash!',
        destroyed_rock = 'You destroyed the rock. Luck ran out on this one! ',
    },
    success = {
        your_pickaxe_broke = 'your pickaxe broke!',
        smelting_successful = 'Successfully extracted '
    },
    primary = {
        you_are_busy_the_moment = 'you are busy at the moment!',
        small_haul_time = 'small haul time!',
        lucky_haul_time = 'Got lucky this time! ',
        medium_haul_this_time = 'medium haul this time!',
        largq_haul_this_time = 'large haul this time!',
    },
    menu = {
        start = 'Start ',
    },
    commands = {
        var = 'text goes here',
    },
    progressbar = {
        var = 'text goes here',
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
