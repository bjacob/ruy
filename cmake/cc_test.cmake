# Copyright 2019-2021 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Forked from IREE's iree_cc_test.cmake.

include(CMakeParseArguments)

# cc_test()
# 
# CMake function to imitate Bazel's cc_test rule.
function(cc_test)
  cmake_parse_arguments(
    _RULE
    ""
    "NAME"
    "SRCS;COPTS;LINKOPTS;DEPS;TAGS"
    ${ARGN}
  )

  if(NOT RUY_ENABLE_TESTS)
    return()
  endif()

  set(_NAME "${_RULE_NAME}")

  add_executable(${_NAME} "")
  target_sources(${_NAME}
    PRIVATE
      ${_RULE_SRCS}
  )
  set_target_properties(${_NAME} PROPERTIES OUTPUT_NAME "${_RULE_NAME}")
  target_include_directories(${_NAME}
    PUBLIC
      "${PROJECT_SOURCE_DIR}"
  )
  target_compile_options(${_NAME}
    PRIVATE
      ${_RULE_COPTS}
  )
  target_link_options(${_NAME}
    PRIVATE
      ${_RULE_LINKOPTS}
  )
  target_link_libraries(${_NAME}
    PUBLIC
      ${_RULE_DEPS}
  )
  if(ANDROID)
    add_test(
      NAME
        ${_NAME}_on_android_device
      COMMAND
        "${CMAKE_SOURCE_DIR}/cmake/run_android_test.sh"
        "${CMAKE_CURRENT_BINARY_DIR}/${_NAME}"
    )
  else()
    add_test(
        NAME
          ${_NAME}
        COMMAND
          "$<TARGET_FILE:${_NAME}>"
        )
  endif()
endfunction()
