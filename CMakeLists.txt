cmake_minimum_required(VERSION 3.22)

project(GeoResilience
  VERSION 0.0.1
  DESCRIPTION "Geospatial environmental screening engine"
  LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

option(GEORES_BUILD_TESTS "Build unit tests" ON)

find_package(GDAL CONFIG QUIET)
if(NOT GDAL_FOUND)
  find_package(GDAL REQUIRED)   # CMake's FindGDAL module
endif()

configure_file(
  ${CMAKE_CURRENT_SOURCE_DIR}/include/georesilience/version.hpp.in
  ${CMAKE_CURRENT_BINARY_DIR}/generated/georesilience/version.hpp
  @ONLY)

# Core library: everything except main(). Tests link against this.
add_library(georesilience_core
  src/io/gdal_env.cpp)
target_include_directories(georesilience_core
  PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/include
    ${CMAKE_CURRENT_BINARY_DIR}/generated)
target_link_libraries(georesilience_core PUBLIC GDAL::GDAL)

if(MSVC)
  target_compile_options(georesilience_core PRIVATE /W4 /permissive-)
else()
  target_compile_options(georesilience_core PRIVATE -Wall -Wextra -Wpedantic)
endif()

add_executable(georesilience src/cli/main.cpp)
target_link_libraries(georesilience PRIVATE georesilience_core)

if(GEORES_BUILD_TESTS)
  enable_testing()
  add_subdirectory(tests)
endif()
