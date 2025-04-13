<#
.SYNOPSIS
    Ensures only Administrators and Users groups are assigned the "Allow log on locally" right.
    Aligns with STIG ID: WN10-UR-000025

.DESCRIPTION
    This script configures the local security policy to allow only authorized groups to log on locally.

.NOTES
    Author          : Britt Parks
    STIG-ID         : WN10-UR-000025
    Date Created    : 2025-04-13
    Tested On       : Windows 10 Pro, 22H2
#>

# Save the current security policy
secedit /export /cfg "$env:TEMP\secpol.cfg" /quiet

# Replace or insert the correct policy line
$config = Get-Content "$env:TEMP\secpol.cfg"
$config = $config -replace 'SeInteractiveLogonRight\s*=.*', 'SeInteractiveLogonRight = *S-1-5-32-544,*S-1-5-32-545'

# Save updated config
$config | Set-Content "$env:TEMP\secpol.cfg"

# Apply new settings
secedit /configure /db secedit.sdb /cfg "$env:TEMP\secpol.cfg" /quiet

# Clean up
Remove-Item "$env:TEMP\secpol.cfg" -Force

Write-Host "Logon locally rights updated to include only Administrators and Users."
