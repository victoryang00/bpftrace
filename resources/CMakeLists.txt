add_library(resources headers.cpp)

target_include_directories(resources PUBLIC ../src)

function(embed_headers output)
  file(WRITE ${output} "#include \"headers.h\"\n\nnamespace bpftrace {\n")
  file(GLOB headers *.h)
  foreach(header ${headers})
    set_property(DIRECTORY APPEND PROPERTY CMAKE_CONFIGURE_DEPENDS ${header})
    get_filename_component(filename ${header} NAME)
    string(MAKE_C_IDENTIFIER ${filename} varname)
    file(READ ${header} contents)
    file(APPEND ${output} "const std::string_view ${varname} = R\"CONTENTS(${contents})CONTENTS\";\n\n")
  endforeach()
  file(APPEND ${output} "} // namespace bpftrace")
endfunction()

embed_headers(${CMAKE_BINARY_DIR}/resources/headers.cpp)
