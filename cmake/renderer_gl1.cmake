if(NOT BUILD_CLIENT OR NOT BUILD_RENDERER_GL1)
    return()
endif()

include(utils/set_output_dirs)
include(renderer_common)

set(RENDERER_GL1_SOURCES
    ${SOURCE_DIR}/renderergl1/tr_altivec.cpp
    ${SOURCE_DIR}/renderergl1/tr_animation.cpp
    ${SOURCE_DIR}/renderergl1/tr_backend.cpp
    ${SOURCE_DIR}/renderergl1/tr_bsp.cpp
    ${SOURCE_DIR}/renderergl1/tr_cmds.cpp
    ${SOURCE_DIR}/renderergl1/tr_curve.cpp
    ${SOURCE_DIR}/renderergl1/tr_flares.cpp
    ${SOURCE_DIR}/renderergl1/tr_image.cpp
    ${SOURCE_DIR}/renderergl1/tr_init.cpp
    ${SOURCE_DIR}/renderergl1/tr_light.cpp
    ${SOURCE_DIR}/renderergl1/tr_main.cpp
    ${SOURCE_DIR}/renderergl1/tr_marks.cpp
    ${SOURCE_DIR}/renderergl1/tr_mesh.cpp
    ${SOURCE_DIR}/renderergl1/tr_model.cpp
    ${SOURCE_DIR}/renderergl1/tr_model_iqm.cpp
    ${SOURCE_DIR}/renderergl1/tr_scene.cpp
    ${SOURCE_DIR}/renderergl1/tr_shade.cpp
    ${SOURCE_DIR}/renderergl1/tr_shade_calc.cpp
    ${SOURCE_DIR}/renderergl1/tr_shader.cpp
    ${SOURCE_DIR}/renderergl1/tr_shadows.cpp
    ${SOURCE_DIR}/renderergl1/tr_sky.cpp
    ${SOURCE_DIR}/renderergl1/tr_surface.cpp
    ${SOURCE_DIR}/renderergl1/tr_world.cpp
)

set(RENDERER_GL1_BASENAME renderer_opengl1)
set(RENDERER_GL1_BINARY ${RENDERER_GL1_BASENAME})

list(APPEND RENDERER_GL1_BINARY_SOURCES
    ${RENDERER_COMMON_SOURCES}
    ${RENDERER_GL1_SOURCES}
    ${SDL_RENDERER_SOURCES}
    ${RENDERER_LIBRARY_SOURCES})

if(USE_RENDERER_DLOPEN)
    list(APPEND RENDERER_GL1_BINARY_SOURCES ${DYNAMIC_RENDERER_SOURCES})

    add_library(${RENDERER_GL1_BINARY} SHARED ${RENDERER_GL1_BINARY_SOURCES})

    target_link_libraries(      ${RENDERER_GL1_BINARY} PRIVATE ${RENDERER_LIBRARIES})
    target_include_directories( ${RENDERER_GL1_BINARY} PRIVATE ${RENDERER_INCLUDE_DIRS})
    target_compile_definitions( ${RENDERER_GL1_BINARY} PRIVATE ${RENDERER_DEFINITIONS})
    target_compile_options(     ${RENDERER_GL1_BINARY} PRIVATE ${RENDERER_COMPILE_OPTIONS})
    target_link_options(        ${RENDERER_GL1_BINARY} PRIVATE ${RENDERER_LINK_OPTIONS})

    set_output_dirs(${RENDERER_GL1_BINARY})
endif()

