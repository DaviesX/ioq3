if(NOT BUILD_CLIENT OR NOT BUILD_RENDERER_GL2)
    return()
endif()

include(utils/set_output_dirs)
include(renderer_common)

set(RENDERER_GL2_SOURCES
    ${SOURCE_DIR}/renderergl2/tr_animation.cpp
    ${SOURCE_DIR}/renderergl2/tr_backend.cpp
    ${SOURCE_DIR}/renderergl2/tr_bsp.cpp
    ${SOURCE_DIR}/renderergl2/tr_cmds.cpp
    ${SOURCE_DIR}/renderergl2/tr_curve.cpp
    ${SOURCE_DIR}/renderergl2/tr_dsa.cpp
    ${SOURCE_DIR}/renderergl2/tr_extramath.cpp
    ${SOURCE_DIR}/renderergl2/tr_extensions.cpp
    ${SOURCE_DIR}/renderergl2/tr_fbo.cpp
    ${SOURCE_DIR}/renderergl2/tr_flares.cpp
    ${SOURCE_DIR}/renderergl2/tr_glsl.cpp
    ${SOURCE_DIR}/renderergl2/tr_image.cpp
    ${SOURCE_DIR}/renderergl2/tr_image_dds.cpp
    ${SOURCE_DIR}/renderergl2/tr_init.cpp
    ${SOURCE_DIR}/renderergl2/tr_light.cpp
    ${SOURCE_DIR}/renderergl2/tr_main.cpp
    ${SOURCE_DIR}/renderergl2/tr_marks.cpp
    ${SOURCE_DIR}/renderergl2/tr_mesh.cpp
    ${SOURCE_DIR}/renderergl2/tr_model.cpp
    ${SOURCE_DIR}/renderergl2/tr_model_iqm.cpp
    ${SOURCE_DIR}/renderergl2/tr_postprocess.cpp
    ${SOURCE_DIR}/renderergl2/tr_scene.cpp
    ${SOURCE_DIR}/renderergl2/tr_shade.cpp
    ${SOURCE_DIR}/renderergl2/tr_shade_calc.cpp
    ${SOURCE_DIR}/renderergl2/tr_shader.cpp
    ${SOURCE_DIR}/renderergl2/tr_shadows.cpp
    ${SOURCE_DIR}/renderergl2/tr_sky.cpp
    ${SOURCE_DIR}/renderergl2/tr_surface.cpp
    ${SOURCE_DIR}/renderergl2/tr_vbo.cpp
    ${SOURCE_DIR}/renderergl2/tr_world.cpp
)

file(GLOB RENDERER_GL2_SHADER_SOURCES ${SOURCE_DIR}/renderergl2/glsl/*.glsl)

set(SHADERS_DIR ${CMAKE_BINARY_DIR}/shaders.dir)
file(MAKE_DIRECTORY ${SHADERS_DIR})

foreach(SHADER_FILE IN LISTS RENDERER_GL2_SHADER_SOURCES)
    get_filename_component(SHADER_NAME ${SHADER_FILE} NAME_WE)
    set(SHADER_C_FILE ${SHADERS_DIR}/${SHADER_NAME}.c)

    string(REPLACE "${CMAKE_BINARY_DIR}/" "" SHADER_C_FILE_COMMENT ${SHADER_C_FILE})

    add_custom_command(
        OUTPUT ${SHADER_C_FILE}
        COMMAND ${CMAKE_COMMAND}
            -DINPUT_FILE=${SHADER_FILE}
            -DOUTPUT_FILE=${SHADER_C_FILE}
            -DSHADER_NAME=${SHADER_NAME}
            -P ${CMAKE_SOURCE_DIR}/cmake/utils/stringify_shader.cmake
        DEPENDS ${SHADER_FILE}
        COMMENT "Stringify shader ${SHADER_C_FILE_COMMENT}")

    list(APPEND RENDERER_GL2_SHADER_C_SOURCES ${SHADER_C_FILE})
endforeach()

set(RENDERER_GL2_BASENAME renderer_opengl2)
set(RENDERER_GL2_BINARY ${RENDERER_GL2_BASENAME})

list(APPEND RENDERER_GL2_BINARY_SOURCES
    ${RENDERER_COMMON_SOURCES}
    ${RENDERER_GL2_SOURCES}
    ${RENDERER_GL2_SHADER_C_SOURCES}
    ${SDL_RENDERER_SOURCES}
    ${RENDERER_LIBRARY_SOURCES})

if(USE_RENDERER_DLOPEN)
    list(APPEND RENDERER_GL2_BINARY_SOURCES ${DYNAMIC_RENDERER_SOURCES})

    add_library(${RENDERER_GL2_BINARY} SHARED ${RENDERER_GL2_BINARY_SOURCES})

    target_link_libraries(      ${RENDERER_GL2_BINARY} PRIVATE ${RENDERER_LIBRARIES})
    target_include_directories( ${RENDERER_GL2_BINARY} PRIVATE ${RENDERER_INCLUDE_DIRS})
    target_compile_definitions( ${RENDERER_GL2_BINARY} PRIVATE ${RENDERER_DEFINITIONS})
    target_compile_options(     ${RENDERER_GL2_BINARY} PRIVATE ${RENDERER_COMPILE_OPTIONS})
    target_link_options(        ${RENDERER_GL2_BINARY} PRIVATE ${RENDERER_LINK_OPTIONS})

    set_output_dirs(${RENDERER_GL2_BINARY})
endif()

