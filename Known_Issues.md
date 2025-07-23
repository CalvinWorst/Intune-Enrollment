# Known Errors and Issues

## Unable to find the COP URI (non fatal)
### Error Code
```
MDM ConfigurationManager: Command failure status. Configuration Source ID: (EC94548B-0358-4D20-84A7-78199025C0AA), Enrollment Name: (MDMDeviceWithAAD), Provider Name: (Policy), Command Type: (Add: from Replace or Add), CSP URI: (./Device/Vendor/MSFT/Policy/ConfigOperations/ADMXInstall/Receiver/Properties/Policy/FakePolicy/Version), Result: (The system cannot find the file specified.).
```
### Reason
I'm not entirely sure why this happens or what it means but it shows up as an error in the logs. In my experience it has been non-fatal, though. After a few minutes the device showed up in intune and the configurations were applied. 
