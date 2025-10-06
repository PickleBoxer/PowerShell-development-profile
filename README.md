# PowerShell Development Profile

<img width="1174" height="698" alt="image" src="https://github.com/user-attachments/assets/1d04c09f-529e-445f-810b-ee2c732a07ea" />

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
