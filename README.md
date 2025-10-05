# PowerShell Development Profile

<img width="1293" height="916" alt="image" src="https://github.com/user-attachments/assets/7bab0608-f35b-4fe1-9e36-b383c9fa1f59" />


Custom PowerShell profile for enhanced terminal experience:
- Ghost text inline completions
- Directory icons
- Git integration
- Oh My Posh theme (pickleboxer.omp.json)
- Useful aliases

## Setup

1. Copy `Microsoft.PowerShell_profile.ps1` to your PowerShell profile location:
   - Run `$PROFILE` in PowerShell to see the path.

2. Copy `pickleboxer.omp.json` to your home directory.

3. Install required modules:
   ```powershell
   Install-Module Terminal-Icons, PSReadLine, posh-git, oh-my-posh -Scope CurrentUser
   ```

4. Use a [Nerd Font](https://www.nerdfonts.com/font-downloads) for best icons
