$zip = @{
  Path = ".\Text"
  CompressionLevel = "Optimal"
  DestinationPath = ".\mod-texts.zip"
}
Compress-Archive @zip

Move-Item ".\mod-texts.zip" "..\mod-texts.pak" -Force

# Read-Host