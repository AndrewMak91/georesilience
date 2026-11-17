#include <gtest/gtest.h>

#include "georesilience/io/gdal_env.hpp"

TEST(GdalEnv, RegistersDrivers) {
  georesilience::io::initialize_gdal();
  EXPECT_GT(georesilience::io::gdal_driver_count(), 0);
}

TEST(GdalEnv, ReportsVersion) { EXPECT_FALSE(georesilience::io::gdal_version().empty()); }
