include(cursors.cmake)
include(config.cmake)
include(setup.cmake)

set(COLORS
    black
    blue
    brown
    emerald
    green
    grey
    hot_orange
    navy
    purple
    red
    red-argentina
    sea_blue
    violet
    viorange
    white
    yellow
   )

foreach(color ${COLORS})
    add_subdirectory(theme-${color})
    message(STATUS "Added themes for ${color}")
endforeach(color)
add_custom_target(packages ${PACKAGES})
