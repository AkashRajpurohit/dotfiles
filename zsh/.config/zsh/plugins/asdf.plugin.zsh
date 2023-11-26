ASDF_DIR="${ASDF_DIR:-$HOME/.asdf}"
ASDF_COMPLETIONS="$ASDF_DIR/completions"

if [[ -f "$ASDF_DIR/asdf.sh" ]]; then
  source "$ASDF_DIR/asdf.sh"
  # Load completions
  if [[ -f "$ASDF_COMPLETIONS/_asdf" ]]; then
    fpath+=("$ASDF_COMPLETIONS")
    autoload -Uz _asdf
  fi
fi
