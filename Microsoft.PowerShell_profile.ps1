# ===================== PowerShell Profile =====================
# Install (once, if missing):
#   Install-Module -Name Terminal-Icons -Repository PSGallery -Scope CurrentUser
#   Install-Module -Name PSReadLine -Force -Scope CurrentUser
#   Install-Module -Name posh-git -Scope CurrentUser
#   Install-Module -Name oh-my-posh -Scope CurrentUser
# Nerd Font: https://www.nerdfonts.com/font-downloads
# This gives you a JSON file you can edit (warp.omp.json in your home folder).
#   oh-my-posh config export --output "$HOME\warp.omp.json"
# ===============================================================

# Load modules for icons, completion, and git info
Import-Module Terminal-Icons      # Adds file/folder icons to ls/dir output
Import-Module PSReadLine          # Enhanced command line editing & completion
Import-Module posh-git            # Git status/info in prompt

# PSReadLine settings for better UX
Set-PSReadLineOption -PredictionSource HistoryAndPlugin   # Use history + plugins for suggestions
Set-PSReadLineOption -PredictionViewStyle InlineView      # Show suggestions as ghost text
Set-PSReadLineOption -Colors @{ InLinePrediction = '#5C6370' }  # Set ghost text color
Set-PSReadLineOption -EditMode Windows                    # Use Windows-style editing
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete  # Tab cycles through completions
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward   # Up arrow searches history
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward  # Down arrow searches history

# Oh My Posh prompt setup (custom theme)
$theme = "$HOME\pickleboxer.omp.json"                     # Path to custom theme
oh-my-posh init pwsh --config $theme | Invoke-Expression  # Initialize Oh My Posh with theme

# Aliases for faster git commands
Set-Alias gs 'git status'                                 # 'gs' runs 'git status'
Set-Alias glog 'git log --oneline --graph --decorate'     # 'glog' shows pretty git log

# This key handler shows the entire or filtered history using Out-GridView. The
# typed text is used as the substring pattern for filtering. A selected command
# is inserted to the command line without invoking. Multiple command selection
# is supported, e.g. selected by Ctrl + Click.
Set-PSReadLineKeyHandler -Key F7 `
                         -BriefDescription History `
                         -LongDescription 'Show command history' `
                         -ScriptBlock {
    $pattern = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$pattern, [ref]$null)
    if ($pattern)
    {
        $pattern = [regex]::Escape($pattern)
    }

    $history = [System.Collections.ArrayList]@(
        $last = ''
        $lines = ''
        foreach ($line in [System.IO.File]::ReadLines((Get-PSReadLineOption).HistorySavePath))
        {
            if ($line.EndsWith('`'))
            {
                $line = $line.Substring(0, $line.Length - 1)
                $lines = if ($lines)
                {
                    "$lines`n$line"
                }
                else
                {
                    $line
                }
                continue
            }

            if ($lines)
            {
                $line = "$lines`n$line"
                $lines = ''
            }

            if (($line -cne $last) -and (!$pattern -or ($line -match $pattern)))
            {
                $last = $line
                $line
            }
        }
    )
    $history.Reverse()

    $command = $history | Out-GridView -Title History -PassThru
    if ($command)
    {
        [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert(($command -join "`n"))
    }
}


# CaptureScreen is good for blog posts or email showing a transaction
# of what you did when asking for help or demonstrating a technique.
Set-PSReadLineKeyHandler -Chord 'Ctrl+d,Ctrl+c' -Function CaptureScreen

# ===============================================================
# Features:
# - Ghost text inline completions
# - Directory icons
# - Git integration
# - Aliases for speed
# ===============================================================
# ===============================================================
# Extra tips:
# - List installed Oh My Posh themes: Get-ChildItem $env:POSH_THEMES_PATH
# - Try a theme temporarily: oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\paradox.omp.json" | Invoke-Expression
# - Export and edit a theme: oh-my-posh config export > mytheme.omp.json
# ===============================================================
