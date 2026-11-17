// GeoResilience CLI entry point.
// M0 smoke test only: proves the toolchain and GDAL link work.
// Week 3 adds: `georesilience info <path>` (vector + raster metadata).

#include <iostream>
#include <string_view>

#include "georesilience/io/gdal_env.hpp"
#include "georesilience/version.hpp"

namespace {

void print_usage() { std::cout << "Usage: georesilience [--version | --help]\n"; }

}  // namespace

int main(int argc, char* argv[]) {
  georesilience::io::initialize_gdal();

  if (argc < 2) {
    print_usage();
    return 0;
  }

  const std::string_view arg{argv[1]};
  if (arg == "--version") {
    std::cout << "georesilience " << georesilience::kVersion << '\n'
              << "GDAL " << georesilience::io::gdal_version() << " ("
              << georesilience::io::gdal_driver_count() << " drivers)\n";
    return 0;
  }
  if (arg == "--help" || arg == "-h") {
    print_usage();
    return 0;
  }

  std::cerr << "Unknown argument: " << arg << '\n';
  print_usage();
  return 2;
}
