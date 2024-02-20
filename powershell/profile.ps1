#Set-Alias swap ChangeExPolicy
Set-Alias touch New-File
Set-Alias ip Get-Ip
Set-Alias connect connect_to_wifi
Set-Alias disconnect disconnect_from_wifi
Set-Alias ds4 C:\Users\Timmy\Documents\DS4Windows\DS4Windows.exe
Set-Alias run javarun
Set-Alias push git_push
Set-Alias search search_history
Set-Alias init New-NodeApp
Set-Alias pum  Update-PythonModules

$dev = (Get-Item (split-path -parent  $MyInvocation.MyCommand.Definition)).parent.parent
function New-File { # Write docs
    param(
        [Parameter()]
        [string]
        $name
    )
    if($null -eq $name){
        Write-Output "No name provided"
    } elseif (Test-Path $name) {
        Write-Output "File already exists"
    } else {
        New-Item -Name $name
    }   
}
function push { # Write docs
    param(
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]
        $message
    )
    if($null -eq $message){
        Write-Output "Message is missing! Please add a message!"
    } else {
        git add *
        git commit -m "$message"
        git push
    }
}
function dev { # Write docs
    Set-Location $dev
}
function nighty { # TODO
    param()
    python C:\Users\Timmy\Documents\snippets\windows\go_to_bed.py
}
function Update-PythonModules { # TODO
    param()
    Set-Location C:\dev\scripts
    ./update_python_modules.ps1
}
function Get-Ip { # Write docs
    param()
    $out = (ipconfig.exe | findstr.exe 'IPv4')
    Write-Output ($out | findstr.exe '\.1\.')
}
function javarun { # TODO
    param (
        [Parameter()]
            [string]
            $x
    )
    C:\Users\Timmy\Documents\jdk-16\bin\javac.exe $x".java"
    C:\Users\Timmy\Documents\jdk-16\bin\java.exe $x
    Remove-Item $x".class";
}
function ChangeExPolicy { # Write docs
    param (
            [Parameter()]
            [string]
            $u=$null
    )
    $a=Get-ExecutionPolicy
    if($null -eq $u){
        try {
            if ($a -eq "Restricted") {
                Set-ExecutionPolicy Unrestricted
                Write-Output 'Execution Policy Set To Unrestricted'
            }else {
                Set-ExecutionPolicy Restricted
                Write-Output 'Execution Policy Set To Restricted'
                Write-Output "u=$u"
            }
        }
        catch {
            Write-Output 'Please run terminal as admin or use option /x'
        }
    }else {
        try {
            if ($a -eq "Restricted") {
                Set-ExecutionPolicy Unrestricted -Scope CurrentUser
                Write-Output 'Execution Policy Set To Unrestricted'
            }else {
                Set-ExecutionPolicy Restricted -Scope CurrentUser
                Write-Output 'Execution Policy Set To Restricted'
            }
        }
        catch {
            Write-Output 'Please run terminal as admin or use option -u'
        }
    }
    
}
function connect_to_wifi { # Write docs
    param (
        [Parameter(Mandatory)]
        [string]
        $name
    )
    try {
        netsh.exe wlan connect $name
        Write-Output 'Connected to network'
    }
    catch {
        Write-Output 'Err'
    }
}
function disconnect_from_wifi { # Write docs
    param ()
    netsh.exe wlan disconnect
}
function git_push { # Write docs
    param(
        [Parameter()]
        [string]
        $msg
    )
    git add *;
    git commit -m $msg
    git push
}
function search_history { # Write docs
    param (
        [Parameter()]
        [string]
        $search_text
    )
    Get-Content (Get-PSReadlineOption).HistorySavePath | Where-Object { $_ -like "*${search_text}*" }    
}
function New-NodeApp {
    <#
    .SYNOPSIS
        Generates a new Node application.
    .DESCRIPTION
        New-NodeApp uses npm/npx to generate apps.
        The current options available are:
            - Vue : vue
            - React (With or without Vite) : react/react-no-vite
            - Next : next
            - Svelte : svelte
            - Solid : solid
            - Qwik : qwik
            - Lit : lit
            - React + Express : vite-express
            - Vue + Express : vite-express
            - Express : express
            - Express-TS : express-ts
    .PARAMETER Framework
        Specify the framework you're going to use.
        For utility purposes, the options are shown in description 
    .PARAMETER Name
        Give a name to your project.
    .NOTES
        This function works on Windows and Linux running PowerShell 7+
    .LINK
        Be sure to check out more of my code experiments on https://github.com/17lxve
    .EXAMPLE
        New NodeApp react_app
        Creates a React Application without Vite
    #>
    param (
        [Parameter(Mandatory)]
        [string]
        $Framework,
        [Parameter()]
        [string]
        $Name=""
    )

    # Default options available
    $frameworks = @{
        "react"         = "npx create-vite@latest ${Name} -- --template react-ts";
        "svelte"        = "npx create-vite@latest ${Name} -- --template svelte-ts";
        "solid"         = "npx create-vite@latest ${Name} -- --template solid-ts";
        "qwik"          = "npx create-vite@latest ${Name} -- --template qwik-ts";
        "lit"           = "npx create-vite@latest ${Name} -- --template lit-ts";
        "react-no-vite" = "npx create-react-app@latest ${Name} --use-npm";
        "next"          = "npx create-next-app@latest ${Name} --use-npm";
        "vue"           = "npm init vue@latest ${Name}";
        "vite-express"  = "npx create-vite-express@latest ${Name}";
        "express"       = "git clone https://github.com/17lxve/server-js ${Name}";
        "express-ts"    = "git clone https://github.com/17lxve/server-ts ${Name}";
        "test"          = "Write-Output 'I survived 2023 just to die at GREYDAY'"
        "help"          = "Get-Help New-NodeApp"
    }
    Write-Output "Starting...`n"
    # Run
    try {
        Invoke-Expression $frameworks[$Framework]
    }
    catch {
        Write-Error "Bro, there was an error here: $($_.Exception.Message)"
    }
    finally {
        Write-Output "`nWe are finished here.`nGood luck, Voyager."
    }
}