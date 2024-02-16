$deps = [
    "vim",
    "nvm",
    "python",
    "jdk20",
    "jdk8",
    "oraclejdk",
    "kotlinc",
    "reaper",
    "vscode",
    "microsoft-windows-terminal",
    "mongodb",
    "mongodb-compass",
    "postman",
    "notion",
    "brave"
]


# Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
Set-ExecutionPolicy Bypass -Scope Process -Force;
Invoke-WebRequest https://chocolatey.org/install.ps1 -UseBasicParsing | Invoke-Expression;
