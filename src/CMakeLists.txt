include(cursors.cmake)
include(config.cmake)
include(setup.cmake)

set(COLORS
    blue
    yellow
    brown
    grey
    green
    violet
    viorange
    red
    purple
    navy
    sea_blue
    emerald
    hot_orange
    white
    black
    red-argentina
   )

foreach(color ${COLORS})
    add_subdirectory(theme-${color})
    message(STATUS "Added themes for ${color}")
endforeach(color)
