# Generate a .env file with some keys set to random 16-byte values, encoded as base64
# The keys are: STRAPI_APP_KEYS, STRAPI_ADMIN_JWT_SECRET, STRAPI_JWT_SECRET, STRAPI_API_TOKEN_SALT, STRAPI_TRANSFER_TOKEN_SALT

# The .env file will be generated in the same directory as this script

# Exit on error
$ErrorActionPreference = "Stop"

# Function to generate a random 16 bytes value as a base64 string
function Generate-Key {
  # Generate random bytes (alternative approach)
  $randomChars = -join ((48..57) + (65..90) + (97..122) | Get-Random -Count 16 | ForEach-Object {[char]$_})
  $randomBytes = [System.Text.Encoding]::UTF8.GetBytes($randomChars)
  # Convert bytes to Base64 string
  $base64EncodedString = [Convert]::ToBase64String($randomBytes)
  return $base64EncodedString
}

# Generate the .env file
$envContent = @"
STRAPI_APP_KEYS=$(Generate-Key),$(Generate-Key),$(Generate-Key),$(Generate-Key)
STRAPI_ADMIN_JWT_SECRET=$(Generate-Key)
STRAPI_JWT_SECRET=$(Generate-Key)
STRAPI_API_TOKEN_SALT=$(Generate-Key)
STRAPI_TRANSFER_TOKEN_SALT=$(Generate-Key)
"@

# Get the directory of the script
$scriptDir = Get-Location
$envFilePath = Join-Path -Path $scriptDir -ChildPath ".env"

# Write the content to the .env file
$envContent | Out-File -FilePath $envFilePath -Encoding ascii

Write-Host "The .env file has been generated in $envFilePath"