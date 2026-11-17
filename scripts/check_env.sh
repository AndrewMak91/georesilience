#!/usr/bin/env bash
# Verifies the WSL/Ubuntu toolchain for GeoResilience. Read-only: installs nothing.
# Usage: ./scripts/check_env.sh

ok()   { printf '  \033[32mOK\033[0m       %-16s %s\n' "$1" "$2"; }
miss() { printf '  \033[31mMISSING\033[0m  %-16s %s\n' "$1" "$2"; MISSING=$((MISSING+1)); }
warn() { printf '  \033[33mWARN\033[0m     %-16s %s\n' "$1" "$2"; }
MISSING=0

ver_ge() { [ "$(printf '%s\n%s\n' "$2" "$1" | sort -V | head -n1)" = "$2" ]; }

echo "== Core build tools"
if command -v g++ >/dev/null; then
  v=$(g++ -dumpfullversion)
  if echo 'int main(){ auto x = [](auto a){ return a; }; return x(0); }' | g++ -std=c++20 -x c++ - -o /dev/null 2>/dev/null; then
    ok g++ "$v (C++20 works)"
  else miss g++ "$v but C++20 test failed"; fi
else miss g++ "sudo apt install build-essential"; fi

if command -v cmake >/dev/null; then
  v=$(cmake --version | head -n1 | awk '{print $3}')
  if ver_ge "$v" 3.22; then ok cmake "$v"; else miss cmake "$v (need >= 3.22)"; fi
else miss cmake "sudo apt install cmake"; fi

command -v ninja >/dev/null && ok ninja "$(ninja --version)" || miss ninja "sudo apt install ninja-build"
command -v git   >/dev/null && ok git "$(git --version | awk '{print $3}')" || miss git "sudo apt install git"
command -v gdb   >/dev/null && ok gdb "$(gdb --version | head -n1 | awk '{print $NF}')" || warn gdb "optional: sudo apt install gdb"
command -v clang-format >/dev/null && ok clang-format "$(clang-format --version | grep -o '[0-9]*\.[0-9.]*' | head -n1)" || warn clang-format "optional: sudo apt install clang-format"

echo "== Geospatial libraries"
if command -v gdal-config >/dev/null; then
  ok libgdal-dev "$(gdal-config --version)"
else miss libgdal-dev "sudo apt install libgdal-dev"; fi
command -v ogrinfo >/dev/null && ok gdal-bin "ogrinfo/gdalinfo present" || miss gdal-bin "sudo apt install gdal-bin"
[ -f /usr/include/gtest/gtest.h ] && ok googletest "system headers" || warn googletest "not found; CMake will download it (or: sudo apt install libgtest-dev)"
[ -f /usr/include/nlohmann/json.hpp ] && ok nlohmann-json "headers present" || warn nlohmann-json "needed from Week 12: sudo apt install nlohmann-json3-dev"

echo "== Python (M4/M5)"
command -v python3 >/dev/null && ok python3 "$(python3 --version | awk '{print $2}')" || miss python3 "sudo apt install python3"
python3 -c 'import venv' 2>/dev/null && ok python3-venv "available" || warn python3-venv "sudo apt install python3-venv"

echo "== GitHub and Claude"
if command -v gh >/dev/null; then
  if gh auth status >/dev/null 2>&1; then ok gh "logged in"; else warn gh "installed, run: gh auth login"; fi
else miss gh "sudo apt install gh"; fi
command -v claude >/dev/null && ok claude-code "$(claude --version 2>/dev/null | head -n1)" || warn claude-code "curl -fsSL https://claude.ai/install.sh | bash"

echo "== Cost and conflict checks"
if [ -n "${ANTHROPIC_API_KEY:-}" ]; then
  warn ANTHROPIC_API_KEY "is SET: Claude Code will bill this API key instead of your subscription. Unset it unless intended."
else ok ANTHROPIC_API_KEY "not set (Claude Code uses your subscription)"; fi
if [ -n "${CONDA_PREFIX:-}" ]; then
  warn conda "environment active ($CONDA_PREFIX). Run 'conda deactivate' before building to avoid GDAL/PROJ conflicts."
else ok conda "no active environment"; fi
case "$PWD" in
  /mnt/*) warn location "repo is on the Windows drive ($PWD). Works, but builds are slower than inside ~/." ;;
esac
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  [ "$(git config core.autocrlf)" = "true" ] && warn git-autocrlf "core.autocrlf=true; run: git config core.autocrlf false"
fi

echo
if [ "$MISSING" -eq 0 ]; then echo "All required tools found."; else echo "$MISSING required item(s) missing."; exit 1; fi
