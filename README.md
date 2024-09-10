# Windows Security Settings and System Information Script

This PowerShell script automates both the configuration of Windows security settings and the collection of detailed system information. It adjusts local security policies, gathers key system information such as computer details, network configurations, and license data, and saves it to a report.

## Features

### 1. **Security Settings Configuration**
   - Exports current security settings using `secedit`.
   - Modifies specific audit policies:
     - **AuditAccountManage** set to 2 (Success).
     - **AuditLogonEvents**, **AuditPolicyChange**, and **AuditSystemEvents** set to 3 (Success and Failure).
   - Imports the modified settings to apply the changes.
   
### 2. **System Information Collection**
   - Gathers and stores the following system information:
     1. **Computer ID**: Retrieves the computer's name.
     2. **Make, Model & Serial Number**: Details about the hardware vendor and serial number.
     3. **Operating System, Version, and Install Date**: Information about the installed OS.
     4. **System Information**: Detailed output from the `systeminfo` command.
     5. **NIC and IP Details**: Network adapter details and IP configurations from `ipconfig /all`.
     6. **Detailed License Information**: Output of Windows license details (`slmgr /dlv`).
     7. **License Expiration Date**: Checks the Windows license expiration date (`slmgr /xpr`).
     8. **Last Patch Installed**: Lists the most recent patches installed (`wmic qfe get csname,installedon`).
     9. **User Accounts**: Displays active user accounts and their domain status.

### 3. **Output**
   - The script saves all gathered information in a text file located in `C:\TMP\[ComputerName].txt`.
   - If the `C:\TMP` directory doesn't exist, it creates the folder.

## Usage Instructions

1. **Clone the Repository or Download the Script**:
   - Clone this repository using Git or download the `.ps1` file directly.

2. **Run the Script**:
   - Open PowerShell as Administrator.
   - Run the following command:
     ```powershell
     .\script.ps1
     ```

3. **Review the Report**:
   - The script will generate a report file saved to the `C:\TMP` folder. The report contains comprehensive system and security information.

## Customizable Variables

- **Audit Policy Settings**: You can modify the audit policy values in the script if needed. The current configuration is:
  - `AuditAccountManage` set to `2` (Success).
  - `AuditLogonEvents`, `AuditPolicyChange`, `AuditSystemEvents` set to `3` (Success and Failure).

- **Output File Location**: The default location is `C:\TMP\[ComputerName].txt`. You can change the folder path or file name by editing this line in the script:
  ```powershell
  $outputFile = "C:\TMP\$hostname.txt"
  ```

- **Temporary Configuration File Path**: The script uses `C:\secpol.cfg` as a temporary file to store security settings. You can adjust this path if necessary.

## Warnings

- **Permanent Changes**: The security settings changes made by the script are permanent until manually reverted or reconfigured. Ensure you have backed up your original settings before running the script.

- **Administrative Privileges**: The script requires administrative rights, as it modifies security settings and collects system-level information.

## License
This project is licensed under the MIT License. See the LICENSE file for more details.

## Contributions
Feel free to contribute by opening issues or submitting pull requests to improve the script. Any feedback is appreciated!
