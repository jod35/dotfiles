if status is-interactive
   fastfetch
   alias cls="clear"
   alias ag="~/Antigravity/antigravity &"
   alias code="~/.code/code"
   alias node="/home/jod35/.nvm/versions/node/v24.12.0/bin/node"
   alias npm="/home/jod35/.nvm/versions/node/v24.12.0/bin/npm"
   
end

# pnpm
set -gx PNPM_HOME "/home/jod35/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
