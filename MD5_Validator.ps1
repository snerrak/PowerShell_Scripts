Clear-Host

$ErrorActionPreference = "SilentlyContinue"

Write-Host "
╔════════════════════════════════════════════════════════════╗
║                                                            ║
║                MD5 FILE HASH CHECKING TOOL                 ║
║                                                            ║
╠════════════════════════════════════════════════════════════╣
║                                                            ║
║ Enter the posted MD5 hash from the download site.          ║
║                                                            ║
╚════════════════════════════════════════════════════════════╝
"

$MD5_Hash = Read-Host "MD5 HASH"

$MD5_Formated = $MD5_Hash.ToUpper()

Clear-Host

Write-Host "
╔════════════════════════════════════════════════════════════╗
║                                                            ║
║                MD5 FILE HASH CHECKING TOOL                 ║
║                                                            ║
╠════════════════════════════════════════════════════════════╣
║                                                            ║
║ Please select the file you want to check the hash against. ║
║                                                            ║
╚════════════════════════════════════════════════════════════╝"

$openFileDialog = New-Object windows.forms.openfiledialog   
    $openFileDialog.initialDirectory = "$env:SystemDrive\Users\$env:USERNAME\Downloads"
    $openFileDialog.filter = "All files (*.*)| *.*"   
    $result = $openFileDialog.ShowDialog()

$Selected_File = $OpenFileDialog.filename

$File_Hash = Get-FileHash -Algorithm MD5 -Path $Selected_File | Select-Object hash | Format-Table -HideTableHeaders | Out-String 
$File_Converted = $File_Hash.Trim()

Clear-Host

Write-Host "
╔════════════════════════════════════════════════════════════╗
║                                                            ║
║                MD5 FILE HASH CHECKING TOOL                 ║
║                                                            ║
╠════════════════════════════════════════════════════════════╣
║                                                            ║
║ Your input Hash is: $MD5_Formated       ║
║ Your file  Hash is: $File_Converted       ║
║                                                            ║
╠════════════════════════════════════════════════════════════╣
║                                                            ║"

if ($MD5_Formated -eq $File_Converted) {
        Write-Host "║ Your file has NOT been altered!                            ║
║                                                            ║
╚════════════════════════════════════════════════════════════╝"
    }
else {
    Write-Host "║ BEWARE: Your file has been altered!                        ║
║                                                            ║
╚════════════════════════════════════════════════════════════╝"
    }

Write-Host ""