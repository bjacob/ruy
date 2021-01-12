# Copyright 2020 Google LLC
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

# Forked from IREE's iree_add_all_subidrs.cmake.

# add_all_subidrs
#
# CMake function to add all subdirectories of the current directory that contain
# a CMakeLists.txt file
#
# Takes no arguments.
function(ruy_add_all_subdirs)
  FILE(GLOB _CHILDREN RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/*)
  SET(_DIRLIST "")
  foreach(_CHILD ${_CHILDREN})
    if((NOT(subdir MATCHES third_party)) AND
       (IS_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/${_CHILD}) AND
       (EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/${_CHILD}/CMakeLists.txt))
      LIST(APPEND _DIRLIST ${_CHILD})
    endif()
  endforeach()

  foreach(subdir ${_DIRLIST})
    add_subdirectory(${subdir})
  endforeach()
endfunction()
