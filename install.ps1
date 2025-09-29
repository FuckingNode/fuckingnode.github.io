$ErrorActionPreference = "Stop"

$APP_NAME = @{
    CASED = "FuckingNode"
    CLI   = "fuckingnode"
}
$INSTALL_DIR = "C:\$($APP_NAME.CASED)"
$EXE_PATH = Join-Path -Path $INSTALL_DIR -ChildPath "$($APP_NAME.CLI).exe"

Function Remove-IfNeeded() {
   if ($null -ne $args[0] -as [double]) {
        Stop-Process -Id $args[0] -Force
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

# creates a .bat shortcut to allow for fknode to exist alongside fuckingnode in the CLI
Function New-Shortcuts {
    try {
        Write-Host "Creating shortcuts for CLI..."

        # all aliases should be
        # (appName).exe <a command> [ANY ARGS PASSED]
        # so e.g. fkclean "b" = (appName).exe <command> "b"

        $appName = $APP_NAME.CLI

        if (-not (Test-Path $INSTALL_DIR -PathType Container)) {
            Throw "Error: Install directory '$INSTALL_DIR' does not exist."
        }

        $commands = @{
            "fknode"      = ""
            "fkn"         = ""
            "fkclean"     = "clean"
            "fkstart"     = "kickstart"
            "fklaunch"    = "launch"
            "fkcommit"    = "commit"
            "fkuncommit"  = "uncommit"
            "fkbuild"     = "build"
            "fkrelease"   = "release"
            "fksurrender" = "surrender"
            "fkadd"       = "add"
            "fkrem"       = "remove"
            "fklist"      = "list"
            "fkaudit"     = "audit"
            "fkstats"     = "stats"
            "fksetup"     = "setup"
            "fkmigrate"   = "migrate"
        }

        foreach ($name in $commands.Keys) {
            $cmd = $commands[$name]
            $batContent = "@echo off`n%~dp0$($appName).exe $cmd %*"
            $batPath = Join-Path -Path $INSTALL_DIR -ChildPath "$name.bat"
            Set-Content -Path $batPath -Value $batContent -Encoding ASCII
            Write-Host "Shortcut created successfully at $batPath"
        }
    }
    catch {
        Write-Error "Failed to create .bat shortcuts for the CLI: $_"
        Throw $_
    }
}

# download the app
Function Install-App {
    param (
        [string]$url
    )
    try {
        Write-Host "Downloading from $url..."

        if (-not (Test-Path $INSTALL_DIR)) {
            New-Item -ItemType Directory -Path $INSTALL_DIR | Out-Null
        }

        Invoke-WebRequest -Uri $url -OutFile $EXE_PATH
        Write-Host "Downloaded successfully to $EXE_PATH"
    }
    catch {
        Throw "Failed to download or save the file: $_"
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
        Write-Host "Adding shorthand to PATH..."

        if ([string]::IsNullOrWhiteSpace($INSTALL_DIR)) {
            Throw "Install DIR is undefined or empty."
        }

        $Path = (Get-Env -Key "Path") -split ';'

        # Add INSTALL_DIR to PATH if not already present
        if ($Path -notcontains $INSTALL_DIR) {
            $Path += $INSTALL_DIR
            Write-Env -Key 'Path' -Value ($Path -join ';')
            $env:PATH = $Path -join ';'
            Write-Host "Added $INSTALL_DIR to PATH"
        }
        else {
            Write-Host "'${INSTALL_DIR}' is already in your PATH."
        }
    }
    catch {
        Write-Error "Error adding to PATH: $_"
        Throw $_
    }
}

Function Installer {
    try {
        Write-Host "Hi! We'll install $($APP_NAME.CASED) for you. Just a sec!"
        Remove-IfNeeded
        Install-App -url (Get-LatestReleaseUrl)
        Add-AppToPath
        Write-Host "You may have seen our documentation mention shortcuts like 'fknode', 'fkn', 'fkclean'..."
        Write-Host "These are made by creating a bunch of scripts (fknode.bat, fkn.bat...) next to the main installation."
        Write-Host "We highly recommend them, but JUST IN CASE they conflicted with any other local command, we let you choose."

        $response = Read-Host "Do you wish to create these shortcuts? [Y/N]"

        if ($response -match '^[Yy]$') {
            New-Shortcuts
        }
        else {
            Write-Host "Okay, we WON'T create shortcuts. Beware, as documentation and help menus might still use them to refer to commands."
        }
        Write-Host "Installed successfully! Restart your terminal for it to work."
    }
    catch {
        Write-Error $_
    }
}

# start installation
Installer
