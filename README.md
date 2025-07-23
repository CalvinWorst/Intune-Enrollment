# 📘 Intune Enrollment via PsExec Script

This guide walks you through enrolling a Microsoft Entra ID-joined Windows 11 device into Intune using a PowerShell script executed via PsExec.

---

## ✅ Prerequisites

1. Ensure the user:
   - Has a valid **Intune license**.
   - Is a member of the **MDMUsers** group.

2. Ensure that **PsExec** is installed. If not, you can find it here:  
   https://learn.microsoft.com/sysinternals/downloads/psexec

---

## 🚀 Enrollment Instructions

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