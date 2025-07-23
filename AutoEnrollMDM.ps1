# Make sure to run with Admin Rights/PsExec

# Set MDM Enrollment URL's 
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