$zip = @{
  Path = ".\scripts"
  CompressionLevel = "Optimal"
  DestinationPath = ".\scripts.zip"
}
Compress-Archive @zip

Move-Item ".\scripts.zip" "..\scripts.pak" -Force

# Read-Host