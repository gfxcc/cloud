#
# author: <gfxcc_stevens@outlook.com>
# please modify this file before use it

# -----------------------------------------------
# cmake setting
# -----------------------------------------------

cmake_minimum_required(VERSION 2.8.11)

# In-source builds are disabled.
if (${CMAKE_SOURCE_DIR} STREQUAL ${CMAKE_BINARY_DIR})
    message(FATAL_ERROR
        "CMake generation is not possible within the source directory!"
        "\n Remove the CMakeCache.txt file and try again from another folder, e.g.:"
        "\n "
        "\n rm CMakeCache.txt"
        "\n mkdir build"
        "\n cd build"
        "\n cmake .."
    )
endif()

project (unittest)
message (STATUS "Project: ${PROJECT_NAME}")
file (GLOB_RECURSE header ${PROJECT_SOURCE_DIR}/*.h)
file (GLOB_RECURSE source ${PROJECT_SOURCE_DIR}/*.cc )


# -----------------------------------------------
# COMPILE FLAG
# -----------------------------------------------

set (output_dir ${CMAKE_BINARY_DIR}/bin)
set (CMAKE_RUNTIME_OUTPUT_DIRECTORY ${output_dir})

set (CMAKE_BUILD_TYPE "Debug")
set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
set (CMAKE_CXX_FLAGS_DEBUG "$ENV{CXXFLAGS} -Wall -g -ggdb")
set (CMAKE_CXX_FLAGS_RELEASE "$ENV{CXXFLAGS} -O3 -Wall")


# link_directories (${PROJECT_SOURCE_DIR}/thirdparty/ltp/lib/)
# include_directories ()

# -----------------------------------------------
# ADD EXECUTABLE TARGET
# -----------------------------------------------

add_executable (unittest ${source})

target_link_libraries (
  gtest
  gtest_main
)
