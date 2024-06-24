<script>
  winrm quickconfig -q & winrm set winrm/config @{MaxTimeoutms="1800000"} & winrm set winrm/config/service @{AllowUnencrypted="true"} & winrm set winrm/config/service/auth @{Basic="true"}
</script>
<powershell>
  netsh advfirewall firewall add rule name="WinRM HTTP" protocol=TCP dir=in profile=any localport=5985 remoteip=any localip=any action=allow
  netsh advfirewall firewall add rule name="WinRM HTTPS" protocol=TCP dir=in profile=any localport=5986 remoteip=any localip=any action=allow
  net stop winrm
  sc.exe config winrm start=auto
  net start winrm
  Invoke-WebRequest -Uri "https://github.com/vamsi8977/win_ansible/blob/main/ConfigureRemotingForAnsible.ps1" -OutFile ConfigureRemotingForAnsible.ps1
  Invoke-WebRequest -Uri "https://github.com/vamsi8977/win_ansible/blob/main/commands.ps1" -OutFile "windows commands.ps1"
  powershell -Command "& '.\windows commands.ps1'" -ExecutionPolicy Unrestricted
</powershell>
