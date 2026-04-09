$ErrorActionPreference = "Stop"

$INSTALL_DIR = "C:\FuckingNode"
$EXE_PATH = Join-Path -Path $INSTALL_DIR -ChildPath "fkn.exe"

# DETACH PROCESS
$IsIex = -not $PSCommandPath

if (-not $IsIex -and $args[1] -ne "NA") {
    Write-Output "(Detaching)"
    Start-Sleep -Seconds 1
    # powershell path (pwsh on PS Core, powershell on Windows PS)
    $exe = if ($PSVersionTable.PSEdition -eq "Core") { "pwsh" } else { "powershell" }
    $script = $PSCommandPath

    Start-Process -FilePath $exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$script`" _ NA"
    # quit parent
    Write-Output "(Quitting)"
    Start-Sleep -Seconds 1
    exit
}

Start-Sleep -Seconds 1
Write-Output "(Check... DETACHED $PID)"

Function Remove-IfNeeded {
    if ($args.Count -eq 1) {   
        $procId = $args[0] -as [int]
    }
    else {
        $proc = Get-Process -Name "fkn" -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($proc) { $procId = $proc.Id }
    }
    
    if ($procId) {
        Write-Output "FuckingNode found to be running. Removing existing install (PID $procId) for updating."
        Stop-Process -Id $procId -Force
        Remove-Item $EXE_PATH -Force
    }
}

# get latest release URL
Function Get-LatestReleaseUrl {
    try {
        Write-Host "Fetching latest release from GitHub..."
        $response = Invoke-RestMethod -Uri "https://api.github.com/repos/FuckingNode/FuckingNode/releases/latest"
        $asset = $response.assets | Where-Object { $_.name -notlike "*.asc" -and $_.name -like "*.exe" }
        if (-not $asset) {
            Throw "No .exe file found in the latest release."
        }
        Write-Host "Fetched."
        return $asset.browser_download_url
    }
    catch {
        if ($null -ne $_.Exception.Response) {
            $errorResponse = $_.Exception.Response.GetResponseStream()
            $reader = New-Object System.IO.StreamReader($errorResponse)
            $errorContent = $reader.ReadToEnd() | ConvertFrom-Json

            if ($errorContent.message -match "API rate limit exceeded") {
                Write-Error "API rate limit exceeded. To avoid this, authenticate your requests with a GitHub token."
                Write-Error "Visit the following documentation for more information: $($errorContent.documentation_url)"
            }
            else {
                Write-Error "An error occurred: $($errorContent.message)"
            }
        }
        else {
            Write-Error "An unknown error occurred: $($_.Exception.Message)"
        }
    }
}

# download the app
Function Install-App {
    param (
        [string]$url
    )
    try {
        Write-Output "Downloading from $url..."

        if (-not (Test-Path $INSTALL_DIR)) {
            New-Item -ItemType Directory -Path $INSTALL_DIR | Out-Null
        }

        Invoke-WebRequest -Uri $url -OutFile $EXE_PATH
        Write-Output "Downloaded successfully to $EXE_PATH"
    }
    catch {
        Throw "Failed to download fkn.exe: $_"
    }
}

# ngl copied this from bun.sh/install.ps1
# 'HKCU:' = hkey_current_user btw
# i don't know what does this shi- do but it works flawlessly so it'll do i guess
function Publish-Env {
    if (-not ("Win32.NativeMethods" -as [Type])) {
        Add-Type -Namespace Win32 -Name NativeMethods -MemberDefinition @"
  [DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
  public static extern IntPtr SendMessageTimeout(
      IntPtr hWnd, uint Msg, UIntPtr wParam, string lParam,
      uint fuFlags, uint uTimeout, out UIntPtr lpdwResult);
"@
    }
    $HWND_BROADCAST = [IntPtr] 0xffff
    $WM_SETTINGCHANGE = 0x1a
    $result = [UIntPtr]::Zero
    [Win32.NativeMethods]::SendMessageTimeout($HWND_BROADCAST,
        $WM_SETTINGCHANGE,
        [UIntPtr]::Zero,
        "Environment",
        2,
        5000,
        [ref] $result
    ) | Out-Null
}

function Write-Env {
    param([String]$Key, [String]$Value)

    $RegisterKey = Get-Item -Path 'HKCU:'

    $EnvRegisterKey = $RegisterKey.OpenSubKey('Environment', $true)
    if ($null -eq $Value) {
        $EnvRegisterKey.DeleteValue($Key)
    }
    else {
        $RegistryValueKind = if ($Value.Contains('%')) {
            [Microsoft.Win32.RegistryValueKind]::ExpandString
        }
        elseif ($EnvRegisterKey.GetValue($Key)) {
            $EnvRegisterKey.GetValueKind($Key)
        }
        else {
            [Microsoft.Win32.RegistryValueKind]::String
        }
        $EnvRegisterKey.SetValue($Key, $Value, $RegistryValueKind)
    }

    Publish-Env
}

function Get-Env {
    param([String] $Key)

    $RegisterKey = Get-Item -Path 'HKCU:'
    $EnvRegisterKey = $RegisterKey.OpenSubKey('Environment')
    $EnvRegisterKey.GetValue($Key, $null, [Microsoft.Win32.RegistryValueOptions]::DoNotExpandEnvironmentNames)
}
  
# Function: Add App to PATH
Function Add-AppToPath {
    try {
        Write-Output "Adding shorthand to PATH..."

        if ([string]::IsNullOrWhiteSpace($INSTALL_DIR)) {
            Throw "Install DIR is undefined or empty."
        }

        $Path = (Get-Env -Key "Path") -split ';'

        # Add INSTALL_DIR to PATH if not already present
        if ($Path -notcontains $INSTALL_DIR) {
            $Path += $INSTALL_DIR
            Write-Env -Key 'Path' -Value ($Path -join ';')
            $env:PATH = $Path -join ';'
            Write-Output "Added $INSTALL_DIR to PATH"
        }
        else {
            Write-Output "'${INSTALL_DIR}' is already in your PATH."
        }
    }
    catch {
        Write-Error "Error adding to PATH: $_"
        Throw $_
    }
}

Function Installer {
    try {
        Write-Output "Hi! We'll install FuckingNode for you. Just a sec!"
        Remove-IfNeeded
        Install-App -url (Get-LatestReleaseUrl)
        Add-AppToPath
        Write-Output "Installed successfully! Restart your terminal for it to work."
    }
    catch {
        Write-Error $_
    }
}

# start installation
Installer
