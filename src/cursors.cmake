macro(add_cursor cursor color theme dpi)
    add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/oxy-${theme}/svg/${cursor}.svg
                       DEPENDS ${MAKE_SVG} ${CMAKE_CURRENT_SOURCE_DIR}/colors.in ${SVGDIR}/${cursor}.svg
                       COMMAND ${MAKE_SVG} ${CMAKE_CURRENT_SOURCE_DIR}/colors.in
                                           ${SVGDIR}/${cursor}.svg
                                           ${CMAKE_BINARY_DIR}/oxy-${theme}/svg/${cursor}.svg
                      )
    add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/oxy-${theme}/png/${cursor}.png
                       DEPENDS ${CMAKE_BINARY_DIR}/oxy-${theme}/svg/${cursor}.svg
                       COMMAND ${INKSCAPE} --without-gui --export-dpi=${dpi}
                                           --export-png=${CMAKE_BINARY_DIR}/oxy-${theme}/png/${cursor}.png
                                           ${CMAKE_BINARY_DIR}/oxy-${theme}/svg/${cursor}.svg
                      )
endmacro(add_cursor)

macro(add_x_cursor theme cursor)
    set(inputs)
    foreach(png ${${cursor}_inputs})
        list(APPEND inputs ${CMAKE_BINARY_DIR}/oxy-${theme}/png/${png})
    endforeach(png)
    # TODO rewrite input for dpi
    add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/oxy-${theme}/cursors/${cursor}
                       DEPENDS ${inputs}
                       COMMAND ${XCURSORGEN} -p ${CMAKE_BINARY_DIR}/oxy-${theme}/png
                                             ${CONFIGDIR}/${cursor}.in
                                             ${CMAKE_BINARY_DIR}/oxy-${theme}/cursors/${cursor}
                      )
endmacro(add_x_cursor)

macro(add_theme color theme dpi)
    file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/oxy-${theme}/png)
    file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/oxy-${theme}/svg)
    file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/oxy-${theme}/cursors)
    set(${theme}_cursors)
    foreach(svg ${SVGS})
        string(REGEX REPLACE ".*/" "" cursor ${svg})
        string(REGEX REPLACE "[.]svg" "" cursor ${cursor})
        add_cursor(${cursor} ${color} ${theme} ${dpi})
    endforeach(svg)
    foreach(cursor ${CURSORS})
        add_x_cursor(${theme} ${cursor})
        list(APPEND ${theme}_cursors ${CMAKE_BINARY_DIR}/oxy-${theme}/cursors/${cursor})
    endforeach(cursor)
    add_custom_target(theme-${theme} ALL DEPENDS ${${theme}_cursors})
    configure_file(${CMAKE_CURRENT_SOURCE_DIR}/index.theme
                   ${CMAKE_BINARY_DIR}/oxy-${theme}/index.theme COPYONLY)
    add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/oxy-${theme}.tar.bz2
                       DEPENDS ${${theme}_cursors} ${CMAKE_BINARY_DIR}/oxy-${theme}/index.theme
                       COMMAND ${TAR} cjf ${CMAKE_BINARY_DIR}/oxy-${theme}.tar.bz2
                                      oxy-${theme}/cursors
                                      oxy-${theme}/index.theme
                       WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
                      )
    add_custom_target(package-${theme} DEPENDS ${CMAKE_BINARY_DIR}/oxy-${theme}.tar.bz2)
endmacro(add_theme)
