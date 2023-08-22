$zip = @{
  Path = ".\bin", ".\_(Model)", ".\_(AnimSet)", ".\ArenaObjects", ".\Effects", ".\Textures", ".\UI"
  CompressionLevel = "Optimal"
  DestinationPath = ".\mod-visuals.zip"
}
Compress-Archive @zip

Move-Item ".\mod-visuals.zip" "..\mod-visuals.pak" -Force

# Read-Host