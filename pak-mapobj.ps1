$zip = @{
  Path = ".\MapObjects"
  CompressionLevel = "Optimal"
  DestinationPath = ".\mapobj.zip"
}
Compress-Archive @zip

Move-Item ".\mapobj.zip" "..\mapobj.pak" -Force

# Read-Host