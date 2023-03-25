#Region Settings
# IP address of our server
$IpAddress = "127.0.0.1"
# The public key for our server
$PublicKeyString = "12345678"
# The temporary folder where we will store and run the installer
$TempFolder = "C:\Temp\"
#EndRegion Settings


#Check latest version of rustdesk
$response = Invoke-WebRequest -Uri "https://api.github.com/repos/rustdesk/rustdesk/releases/latest" -UseBasicParsing
$json = $response.Content | ConvertFrom-Json
$ver = $json.tag_name 

# Check if RustDesk is already installed and exit if it is installed
if ((Test-Path -Path "C:\Program Files\RustDesk\RustDesk.exe")) {
    "RustDesk already installed."
    exit 0
}

# Create our temp folder if it doesn't exist
if (!(Test-Path -Path $TempFolder)) {
    New-Item -ItemType Directory -Force -Path $TempFolder
}

# Change the current location to the temp folder
Set-Location $TempFolder

# Download last version of rustdesk
Invoke-WebRequest -Uri "https://github.com/rustdesk/rustdesk/releases/download/$ver/rustdesk-$ver-windows_x64.zip" -Outfile rustdesk.zip

# Extract the installer
Expand-Archive rustdesk.zip

# Change the current location to the rustdesk folder from the zip file
Set-Location rustdesk

# Rename the installer to configure the installer
Rename-Item -Path .\rustdesk-$ver-putes.exe -NewName "rustdesk-host=$IpAddress,key=$PublicKeyString.exe"

# Run the installer silently
$Process = Start-Process -FilePath ".\rustdesk-host=$IpAddress,key=$PublicKeyString.exe" -ArgumentList "--silent-install" -PassThru -Verb runAs -Wait

# Exit with what ever exit code the installer returns
exit $Process.ExitCode