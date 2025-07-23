# INSTRUCTIONS #
#
# Ensure User has an Intune license and is in the MDMUsers group
#
# Install PsExec on their machine
#
# Open an adminstrator command prompt
#
# Navigate to the same directory PsExec is in
#
# Open a PsExec instance with the command:
#   .\PsExec.exe -i -s powershell
#
# A new window will open, ENSURE THAT THE FOLLOWING COMMANDS ARE TYPED IN THIS NEW WINDOW
#
# Enable scripts with the command:
#   Set-ExecutionPolicy Unrestricted
# 
# if prompted, type the letter "a" and hit enter
#
# Finally, run the script:
#   .\AutoEnrollMDM.ps1
#
# After a few minutes, the device should be enrolled in Intune and any relevant programs downloaded

# TROUBLESHOOTING #
#
# If you run into any errors, logs can be found at:
#    Event Viewer > Applications and Services Logs > Microsoft > Windows > DeviceManagement-Enterprise-Diagnostics-Provider > Admin


# Set MDM Enrollment URLs 
$key = 'SYSTEM\CurrentControlSet\Control\CloudDomainJoin\TenantInfo\*' 
$keyinfo = Get-Item "HKLM:\$key" 
$url = $keyinfo.name 
$url = $url.Split("\")[-1] 
$path = "HKLM:\SYSTEM\CurrentControlSet\Control\CloudDomainJoin\TenantInfo\$url"

New-ItemProperty -LiteralPath $path -Name 'MdmEnrollmentUrl' -Value 'https://enrollment.manage.microsoft.com/enrollmentserver/discovery.svc' -PropertyType String -Force -ea SilentlyContinue; 
New-ItemProperty -LiteralPath $path -Name 'MdmTermsOfUseUrl' -Value 'https://portal.manage.microsoft.com/TermsofUse.aspx' -PropertyType String -Force -ea SilentlyContinue; 
New-ItemProperty -LiteralPath $path -Name 'MdmComplianceUrl' -Value 'https://portal.manage.microsoft.com/?portalAction=Compliance' -PropertyType String -Force -ea SilentlyContinue; 

# Trigger AutoEnroll 
C:\Windows\system32\deviceenroller.exe /c /AutoEnrollMDM