#!/usr/bin/env bash
# Bumps version and hashes in package.nix to the latest Fluxer stable release.
# Needs: curl, jq, nix
set -euo pipefail

pkg="$(dirname "$(readlink -f "$0")")/package.nix"

declare -A arch_for=(
  [x86_64-linux]=x64
  [aarch64-linux]=arm64
)

version=
declare -A hash_for=()

for system in "${!arch_for[@]}"; do
  latest=$(curl -sSfL "https://pkgs.fluxer.com/desktop/stable/linux/${arch_for[$system]}/latest.json")

  current_version=$(jq -er '.version' <<<"$latest")
  current_hash=$(nix hash convert --hash-algo sha256 --to sri \
    "$(jq -er '.files.appimage.sha256' <<<"$latest")")

  if [[ -n $version && $version != "$current_version" ]]; then
    echo "error: $system published $current_version, expected $version" >&2
    exit 1
  fi

  version=$current_version
  hash_for[$system]=$current_hash
done

old_version=$(sed -n 's/^  version = "\(.*\)";/\1/p' "$pkg")
if [[ $old_version == "$version" ]]; then
  echo "fluxer is already at $version"
  exit 0
fi

sed -i "s|^  version = \".*\";|  version = \"$version\";|" "$pkg"
for system in "${!arch_for[@]}"; do
  # Only touch the hash inside this system's block in `sources`
  sed -i "/^    $system = {/,/^    };/ s|hash = \".*\";|hash = \"${hash_for[$system]}\";|" "$pkg"
done

echo "fluxer: $old_version -> $version"
