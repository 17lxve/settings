Set-Alias touch touch_file

function touch_file {
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

function push {
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