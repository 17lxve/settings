$PROFILE = "$(split-path  $MyInvocation.MyCommand.Definition)\powershell "
$deps = @(
    "gcc","python",  "jdk20", "jdk8", "oraclejdk", "kotlinc","rust"
    "vim", "nvm",
    "reaper", "vscode", "microsoft-windows-terminal", "mongodb",
    "mongodb-compass", "postman", "notion", "brave", "spotify",
    "discord"
)

# Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

Set-ExecutionPolicy Bypass -Scope Process -Force; # Avoid permission-based errors
Invoke-WebRequest https://chocolatey.org/install.ps1 -UseBasicParsing | Invoke-Expression; # Install Chocolatey
. $PROFILE
foreach ($dependency in $deps) {
    choco install $dependency -y
}

