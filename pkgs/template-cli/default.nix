{ pkgs }:
let
  inherit (pkgs) writeShellScriptBin jq gum;
in

writeShellScriptBin "template-cli" ''
  set -euo pipefail

  # Configuration
  FLAKE_URL="github:andre-brandao/nixos"

  echo "🔍 Fetching available templates from $FLAKE_URL..."

  # Get the flake output as JSON
  FLAKE_JSON=$(nix flake show "$FLAKE_URL" --json 2>/dev/null)

  # Extract template names and descriptions using jq
  TEMPLATES=$(echo "$FLAKE_JSON" | ${jq}/bin/jq -r '
    .templates // {} |
    to_entries |
    map("\(.key)|\(.value.description // "No description")") |
    .[]
  ')

  # Check if any templates exist
  if [ -z "$TEMPLATES" ]; then
    echo "❌ No templates found in the flake."
    exit 1
  fi

  # Create formatted list for gum
  TEMPLATE_LIST=$(echo "$TEMPLATES" | while IFS='|' read -r name desc; do
    printf "%-20s %s\n" "$name" "$desc"
  done)

  # Use gum to select a template
  echo ""
  SELECTED=$(echo "$TEMPLATE_LIST" | ${gum}/bin/gum choose --header "Select a template:")

  # Extract just the template name (first column)
  TEMPLATE_NAME=$(echo "$SELECTED" | awk '{print $1}')

  if [ -z "$TEMPLATE_NAME" ]; then
    echo "❌ No template selected."
    exit 1
  fi

  # Initialize the template
  # check if current dir is dirty
  if [ -n "$(ls -A)" ]; then
    echo "❗ Warning: The current directory is not empty. Files may be overwritten."
  fi

  # print crrent dir

  echo "📁 Target directory: $(pwd)"

  if ! ${gum}/bin/gum confirm "Do you want to continue? ($TEMPLATE_NAME)"; then
    echo "❌ Initialization cancelled."
    exit 1
  fi

  echo ""
  echo "🚀 Initializing template '$TEMPLATE_NAME' in '$(pwd)'..."

  nix flake init -t "$FLAKE_URL#$TEMPLATE_NAME"

  echo ""
  echo "✅ Template '$TEMPLATE_NAME' has been initialized successfully!"
''
