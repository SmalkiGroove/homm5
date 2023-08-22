$zip = @{
  Path = ".\scripts"
  CompressionLevel = "Optimal"
  DestinationPath = ".\mod-scripts.zip"
}
Compress-Archive @zip

Move-Item ".\mod-scripts.zip" "..\mod-scripts.pak" -Force

# Read-Host