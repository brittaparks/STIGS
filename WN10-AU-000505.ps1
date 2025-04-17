<#
.SYNOPSIS
    This script configures the policy for the Event Log Service to set the maximum log file size to 1024000 KB or greater.

.DESCRIPTION
    This script will modify the Group Policy setting for the maximum log size under 
    Computer Configuration >> Administrative Templates >> Windows Components >> Event Log Service >> Security.
    
.NOTES
    Author          : Britt Parks
    LinkedIn        : linkedin.com/in/brittaparks
    GitHub          : github.com/brittaparks
    Date Created    : 2025-04-17
    Last Modified   : 2025-04-17
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000505

.TESTED ON
    Date(s) Tested  : 2025-04-17
    Tested By       : Britt Parks
    Systems Tested  : Windows 10 Pro, Build 22H2
    PowerShell Ver. : 5.1.19041.5737

.USAGE
    Run the script with administrative privileges.

        Example:
        PS C:\> .\WN10-AU-000505.ps1
#>

$logSize = 1024000  # Maximum log size in KB

# Set registry key for Event Log Service - Security Log maximum size
$regKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Security"
$regValueName = "MaxSize"

# Check if the registry key exists, if not create it
if (-not (Test-Path $regKeyPath)) {
    New-Item -Path $regKeyPath -Force
}

# Set the maximum log file size
Set-ItemProperty -Path $regKeyPath -Name $regValueName -Value $logSize

# Confirm the change
$logSizeValue = Get-ItemProperty -Path $regKeyPath -Name $regValueName
Write-Host "Configured maximum log file size to: $($logSizeValue.$regValueName) KB"
