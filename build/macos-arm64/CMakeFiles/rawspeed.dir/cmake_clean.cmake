file(REMOVE_RECURSE
  "lib/librawspeed.a"
  "lib/librawspeed.pdb"
)

# Per-language clean rules from dependency scanning.
foreach(lang CXX)
  include(CMakeFiles/rawspeed.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
