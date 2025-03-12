# Chrome Policy Remover for Windows

```asciidoc
   ____ _                                ____       _ _            
 / ___| |__  _ __ ___  _ __ ___   ___  |  _ \ ___ | (_) ___ _   _ 
| |   | '_ \| '__/ _ \| '_ ` _ \ / _ \ | |_) / _ \| | |/ __| | | |
| |___| | | | | | (_) | | | | | |  __/ |  __/ (_) | | | (__| |_| |
 \____|_| |_|_|  \___/|_| |_| |_|\___| |_|   \___/|_|_|\___|\__, |
|  _ \ ___ _ __ ___   _____   _____ _ __                    |___/ 
| |_) / _ \ '_ ` _ \ / _ \ \ / / _ \ '__|                         
|  _ <  __/ | | | | | (_) \ V /  __/ |                            
|_| \_\___|_| |_| |_|\___/ \_/ \___|_|                                                
```

A powerful utility to remove stubborn Chrome policies that come with virus's such as TabSearch etc

![Windows Compatible](https://img.shields.io/badge/Windows-10%2F11-0078D6?logo=windows)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![Admin Required](https://img.shields.io/badge/Admin%20Privileges-Required-red)

## 🚀 Features

- 💥 **Nuclear Option** - Removes all Chrome/Chromium policies
- 🛡️ **Automatic Admin Elevation** - Self-elevates to admin privileges
- 🔍 **Comprehensive Cleanup** - Targets:
  - Group Policy folders
  - Windows Registry entries
  - Enterprise enrollment tokens
  - 32-bit/64-bit policy locations
- ✅ **Verification System** - Checks cleanup effectiveness
- 📋 **Step-by-Step Progress** - Clear visual feedback
- 🧹 **Residual Files Removal** - Force deletes locked files

## 📥 Installation

1. Download the latest release:
```bash
curl -O https://raw.githubusercontent.com/EthanSpleefan/ChromePolicyRemover/main/chrome_cleaner.bat
```

2. Right-click the batch file  
3. Select **"Run as administrator"**

## 🖥️ Usage

```powershell
# Run with default options
> .\chrome_cleaner.bat

# Advanced options (edit batch file):
# - Add custom registry paths
# - Modify directory targets
# - Enable verbose logging
```


## ⚠️ Important Notes

- 🔒 **Backup First!** - Can cause Chrome settings reset
- 🛑 **Antivirus Alert** - Registry edits may trigger warnings
- 💾 **Data Loss** - Removes all Chrome policies indiscriminately
- ⚡ **Reboot Required** - For changes to take full effect

## ❓ FAQ

**Q: My AV flagged this as suspicious. Is it safe?**  
A: This is a false positive due to registry modifications. Review the source code before running.

**Q: Will this remove my Chrome bookmarks?**  
A: No, only resets policies and managed settings. User data remains intact.

**Q: Can I recover removed policies?**  
A: Not directly. You'll need to reapply policies through your MDM/GPO system.

## 🛠️ Technical Details

```text
Target Locations Removed:
├── Registry Paths (8)
├── System32 Folders (2)
├── Program Files Folders (2)
└── Enterprise Enrollment Keys

Post-Cleanup Actions:
1. Forces gpupdate
2. Removes residual files
3. Verifies cleanup
```

## 📄 License

MIT License - See [LICENSE](LICENSE) for full text

---

**⚠ DISCLAIMER**: Use at your own risk. Not affiliated with Google LLC.