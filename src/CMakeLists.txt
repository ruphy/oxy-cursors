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

set(PACKAGES)
foreach(color ${COLORS})
    add_subdirectory(theme-${color})
    list(APPEND PACKAGES package-${color})
    list(APPEND PACKAGES package-${color}-big)
    message(STATUS "Added themes for ${color}")
endforeach(color)
add_custom_target(packages DEPENDS ${PACKAGES})
