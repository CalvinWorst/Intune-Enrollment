# 📘 Intune Enrollment via PsExec Script

This script is designed to enroll an Entra ID Joined device into Intune. It is intended for organizations that already many devices in Entra and are just now wanting to add Intune to their toolset. 

## Some Background (skip to Prerequisites if you want to get straight to the solution)
Traditionally, Intune is meant to be used when devices are onboarded. This is done by enabling tenant-wide or group-specific automatic enrollment in the Intune portal. Newly-onboarded devices will then be automatically enrolled into Intune when they join Entra ID. However, any existing devices in Entra ID will *not* be automatically enrolled. Enrolling these devices essentially involves re-joining them into Entra ID. 

From my research, I have found 3 ways to do this:
### 1. Disconnect and then reconnect the work or school account
This is probably the least-intrusive option if your organization operates on BYOB and you have a local administrator account. If that is not the case, however, then you essentially have to wipe your device. This process takes hours and is probably considered a mild form of torture in a POW treatment manual somewhere. 
### 2. Use a Windows Provisioning Package (Microsoft-recommended)
Microsoft's official solution for this issue is to create a provisioning package. From my understanding, applying the bulk token for Azure AD in the setup will re-join the device. I've had some success with this solution but when I tried it with my boss the infamous IT curse of "it was working right before the meeting" befell me and I couldn't get it to work again after that. I think the issues I had arose from some conflicts with existing enrollments but I'm not too sure. And frankly, when it did work it just took too long. 
### 3. Running a powershell script that enrolls it for you
This is the solution I ended up going with. It works by running the already-existing `deviceenroller.exe` program - Windows uses it to enroll devices into Intune - after (re)setting the necessary MDM enrollment URLs. These three blog posts came in handy during my research:
- https://blog.matrixpost.net/how-to-enroll-already-microsoft-entra-joined-former-azure-ad-joined-devices-to-microsoft-intune/
- https://whackasstech.com/microsoft/msintune/how-to-enroll-existing-entra-joined-devices-to-microsoft-intune/
- https://call4cloud.nl/enroll-existing-entra-azure-intune/


---

## ✅ Prerequisites

1. Ensure that:
   - The user has a valid **Intune license**.
   - The user is in an auto-enrollment group - assuming that you haven't set auto-enrollment to all. More information on that [here](https://learn.microsoft.com/en-us/intune/intune-service/enrollment/quickstart-setup-auto-enrollment).
   - The user's device is **Entra ID Joined**.
   - Users can register and join their devices to/with Entra. More information on that can be found [here](https://learn.microsoft.com/en-us/entra/identity/devices/manage-device-identities#configure-device-settings)
   - You have administrator access on the device. 

2. **PsExec** also needs to be installed. If it isn't, you can find it here:  
   https://learn.microsoft.com/sysinternals/downloads/psexec

---

## 🚀 Enrollment Instructions
If have a Remote Monitoring & Management (RMM) solution, I would reccomend pushing the script remotely instead. If not, you'll have to do the following steps on every device you want to enroll. 

### 1. Open an Administrator Command Prompt

### 2. Navigate to the directory containing `PsExec.exe`

### 3. Launch PsExec

```powershell
.\PsExec.exe -i -s powershell
```

> This opens a new PowerShell window running as SYSTEM. **Ensure that all future commands are ran in this new window.**

---

### 4. In the New PowerShell Window

#### Enable script execution:

```powershell
Set-ExecutionPolicy Unrestricted
```

> If prompted, type **`A`** or **`a`** and press **Enter** to confirm.

#### Navigate back to the directory the enrollment script is in

#### Then run the enrollment script:

```powershell
.\AutoEnrollMDM.ps1
```

> If prompted, type **`R`** or **`r`** and press **Enter** to confirm.

---

## ⏳ What to Expect

- After a few minutes, the device should be enrolled in Intune.
- Relevant apps and policies will begin downloading automatically.

---

## 🛠️ Troubleshooting

If you encounter issues, check the logs in **Event Viewer**:

```
Event Viewer >
Applications and Services Logs >
Microsoft >
Windows >
DeviceManagement-Enterprise-Diagnostics-Provider >
Admin
```

I've also included a file in this repo of Known Issues with the script. I'll try to update it every so often. 
