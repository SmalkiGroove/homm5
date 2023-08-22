$zip = @{
  Path = ".\GameMechanics", ".\MapObjects", ".\Characters", ".\types.xml"
  CompressionLevel = "Optimal"
  DestinationPath = ".\mod-data.zip"
}
Compress-Archive @zip

Move-Item ".\mod-data.zip" "..\mod-data.pak" -Force

# Read-Host