# Author: Wader Chan

Param(
    [string]$TexHome
)

function Get-TEXMFOS([string]$TexHome)
{
    $TexHome=$TexHome.TrimEnd("\")

    $TEXMFOS="$TexHome\texmf-mswin-64"
    if (Test-Path "$TEXMFOS\bin\mtxrun.exe") { return $TEXMFOS }

    $TEXMFOS="$TexHome\texmf-win64"
    if (Test-Path "$TEXMFOS\bin\mtxrun.exe") { return $TEXMFOS }

    $TEXMFOS="$TexHome\texmf-mswin"
    if (Test-Path "$TEXMFOS\bin\mtxrun.exe") { return $TEXMFOS }

    $TEXMFOS="$TexHome\texmf-win32"
    if (Test-Path "$TEXMFOS\bin\mtxrun.exe") { return $TEXMFOS }

    return $NULL
}

if ("" -eq $TexHome) {
    $script:TexHome="D:\SDK\ConTeXt\tex"
}

$TEXMFOS = Get-TEXMFOS $TexHome

if ($NULL -ne $TEXMFOS ) {
    $env:PATH="$TEXMFOS\bin;"+$env:PATH
    $env:CTXMINIMAL="yes"
    Write-Host "Setting ConTeXt Env successful."
} else {
    Write-Host "Setting ConTeXt Env failed."
}

function global:Exec-Cmd([string]$cmd) {
    Write-Host $cmd
    Invoke-Expression $cmd
}

function global:Ctx-FontsReload {
    Exec-Cmd "mtxrun --script fonts --reload"
}

function global:Ctx-FontsList {
    Exec-Cmd "mtxrun --script fonts --list --all"
}

function global:Ctx-LuatoolsGenerate {
    Exec-Cmd "luatools --generate"    
}
