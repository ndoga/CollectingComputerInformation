# Configurazione delle impostazioni di sicurezza
secedit /export /cfg C:\secpol.cfg

# Modifica del file di configurazione
(gc C:\secpol.cfg) -replace 'AuditAccountManage = ".*"', 'AuditAccountManage = "2"' |
                    -replace 'AuditLogonEvents = ".*"', 'AuditLogonEvents = "3"' |
                    -replace 'AuditPolicyChange = ".*"', 'AuditPolicyChange = "3"' |
                    -replace 'AuditSystemEvents = ".*"', 'AuditSystemEvents = "3"' |
                    Out-File C:\secpol.cfg

# Importa il file di configurazione modificato
secedit /configure /db secedit.sdb /cfg C:\secpol.cfg /areas SECURITYPOLICY

# Rimuovi il file di configurazione temporaneo
Remove-Item C:\secpol.cfg

# Ottiene il nome del computer
$hostname = (wmic computersystem get name | Select-Object -Skip 1).Trim()
$outputFile = "C:\TMP\$hostname.txt"

# Verifica se la directory TMP esiste, altrimenti la crea
if (-Not (Test-Path -Path "C:\TMP")) {
    New-Item -ItemType Directory -Path "C:\TMP"
}

# Raccolta delle informazioni di sistema e scrittura su file
$output = @"
===============================
  Computer Information Report
===============================

1. Computer ID:
$(wmic computersystem get name | Select-Object -Skip 1)

2. Make, Model & Serial Number:
$(wmic csproduct get vendor,name,identifyingnumber | Select-Object -Skip 1)

3. Operating System, Version and Install Date:
$(wmic os get name,version,installdate | Select-Object -Skip 1)

4. System Information:
$(systeminfo | Out-String)

5. NIC and IP Details:
$(ipconfig /all | Out-String)

6. Detailed License Information:
$(slmgr /dlv | Out-String)

7. License Expiration Date:
$(slmgr /xpr | Out-String)

8. Last Patch Installed:
$(wmic qfe get csname,installedon | Select-Object -Skip 1)

9. User Accounts:
$(wmic useraccount get name,domain,disabled | Select-Object -Skip 1)

"@

$output | Out-File -FilePath $outputFile

Write-Output "Informazioni salvate in $outputFile"
