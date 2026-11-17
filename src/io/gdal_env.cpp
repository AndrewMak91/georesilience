#include "georesilience/io/gdal_env.hpp"

#include <gdal_priv.h>

namespace georesilience::io {

void initialize_gdal() { GDALAllRegister(); }

std::string gdal_version() { return GDALVersionInfo("RELEASE_NAME"); }

int gdal_driver_count() { return GetGDALDriverManager()->GetDriverCount(); }

}  // namespace georesilience::io
