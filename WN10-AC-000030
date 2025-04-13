<#
.SYNOPSIS
    Configures the 'Minimum password age' policy to 1 day, complying with STIG ID WN10-AC-000030.

.DESCRIPTION
    This script modifies the local security policy to set the minimum password age to 1 day. This setting prevents users from changing their passwords immediately after resetting them, thereby enforcing password history policies effectively.

.NOTES
    Author          : Britt Parks
    LinkedIn        : linkedin.com/in/brittaparks
    GitHub          : github.com/brittaparks
    Date Created    : 2025-04-13
    Last Modified   : 2025-04-13
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000030

.TESTED ON
    Date(s) Tested  : 2025-04-13
    Tested By       : Britt Parks
    Systems Tested  : Windows 10 Pro, Build 22H2
    PowerShell Ver. : 5.1.19041.5737

.USAGE
    Run this script with administrative privileges to apply the required security setting.

    Example:
        PS C:\> .\WN10-AC-000030.ps1

    What it does:
        - Exports the current local security policy
        - Modifies the 'MinimumPasswordAge' value to 1 day
        - Applies the updated policy using secedit

    Requirements:
        - Must be run as Administrator
        - PowerShell 5.1 or later
        - Windows 10 Pro (Tested on Build 22H2)
#>

# Define temporary INF file path
$infPath = "$env:TEMP\secpol.inf"

# Export current security settings
secedit /export /cfg $infPath

# Read the INF file content
$content = Get-Content $infPath

# Update or add the MinimumPasswordAge setting
if ($content -match "MinimumPasswordAge") {
    $content = $content -replace "MinimumPasswordAge\s*=\s*\d+", "MinimumPasswordAge = 1"
} else {
    $index = $content.IndexOf("[System Access]")
    if ($index -ge 0) {
        $insertIndex = $content.IndexOf("", $index)
        $content = $content[0..$insertIndex] + @("MinimumPasswordAge = 1") + $content[($insertIndex+1)..($content.Length - 1)]
    }
}

# Save the modified settings back to the INF file
$content | Set-Content $infPath

# Apply the updated security settings
secedit /configure /db secedit.sdb /cfg $infPath /quiet

Write-Host "'Minimum password age' has been set to 1 day successfully."
