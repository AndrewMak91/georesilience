#pragma once

#include <string>

namespace georesilience::io {

// Registers all GDAL/OGR drivers. Safe to call more than once.
void initialize_gdal();

// GDAL release name, e.g. "3.8.4".
std::string gdal_version();

// Number of registered raster+vector drivers (sanity check that GDAL loaded).
int gdal_driver_count();

}  // namespace georesilience::io
