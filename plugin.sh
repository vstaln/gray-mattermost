#!/bin/sh
here="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
sys="$(uname -s)"
case "$sys" in
MINGW* | MSYS* | CYGWIN*) rel="x86_64-pc-windows-msvc/mattermost.exe" ;;
Darwin*)
    case "$(uname -m)" in
    arm64) rel="aarch64-apple-darwin/mattermost" ;;
    *) rel="x86_64-apple-darwin/mattermost" ;;
    esac ;;
*)
    case "$(uname -m)" in
    aarch64 | arm64) rel="aarch64-unknown-linux-musl/mattermost" ;;
    *) rel="x86_64-unknown-linux-musl/mattermost" ;;
    esac ;;
esac
if [ -x "$here/$rel" ]; then exec "$here/$rel" "$@"; fi
for cand in "$here/target/release/mattermost.exe" "$here/target/release/mattermost" "$here/target/debug/mattermost.exe" "$here/target/debug/mattermost"; do
    if [ -x "$cand" ]; then exec "$cand" "$@"; fi
done
echo "mattermost binary not found in $here" >&2
exit 1
