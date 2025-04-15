<#
.SYNOPSIS
    Remediates STIG control WN10-SO-000025 by renaming the built-in Guest account to a non-default name.
    The change is applied via `secedit` to ensure visibility in secpol.msc and enforce policy.

.NOTES
    Author          : Britt Parks
    LinkedIn        : linkedin.com/in/brittaparks
    GitHub          : github.com/brittaparks
    Date Created    : 2025-04-15
    Last Modified   : 2025-04-15
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000025

.TESTED ON
    Date(s) Tested  : 2025-04-15
    Tested By       : Britt Parks
    Systems Tested  : Windows 10 Pro, Build 22H2
    PowerShell Ver. : 5.1.19041.5737

.USAGE
    Run with Administrator privileges.
    Change the `$NewGuestName` variable if a different name is desired.

    Example:
    PS C:\> .\WN10-SO-000025.ps1
#>

# --- USER CONFIGURABLE SECTION ---
$NewGuestName = "GuestChangeThisName"

# --- DO NOT MODIFY BELOW THIS LINE UNLESS NEEDED ---
# Rename the Guest account directly
Write-Output "Attempting to rename the Guest account to '$NewGuestName'..."
$guest = Get-WmiObject -Class Win32_UserAccount -Filter "Name='Guest' AND LocalAccount=True"
if ($guest) {
    Rename-LocalUser -Name "Guest" -NewName $NewGuestName
    Write-Output "✅ Guest account renamed to '$NewGuestName'"
} else {
    Write-Output "⚠️ Guest account not found or already renamed."
}

# Apply via secedit to reflect in secpol.msc
$tempInf = "$env:TEMP\RenameGuest.inf"
$tempSdb = "$env:TEMP\RenameGuest.sdb"

@"
[Unicode]
Unicode=yes
[System Access]
NewGuestName = $NewGuestName
[Version]
signature="\$CHICAGO$"
Revision=1
"@ | Set-Content -Path $tempInf -Encoding ASCII

secedit /configure /db $tempSdb /cfg $tempInf /quiet
Write-Output "✅ Local Security Policy updated to reflect new Guest account name in secpol.msc."

# Cleanup
Remove-Item $tempInf -Force -ErrorAction SilentlyContinue
Remove-Item $tempSdb -Force -ErrorAction SilentlyContinue
