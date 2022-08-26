$zip = @{
  Path = ".\**"
  CompressionLevel = "Optimal"
  DestinationPath = ".\mod.zip"
}
Compress-Archive @zip

Move-Item ".\mod.zip" "..\mod.pak" -Force

# Read-Host