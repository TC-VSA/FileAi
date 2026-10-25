# Nexus File Explorer

Local-first browser file inventory and naming-intelligence workspace.

## First run on Windows
Double-click `run_scripts\00-master-menu.bat`, then choose **1**.

## Core features
- Multiple user-authorized root folders using File System Access API
- `webkitdirectory` fallback
- Recursive scan, Office temp exclusion, exact known filename error logging
- IndexedDB inventory, search, sorting, filters, details panel
- Naming analysis and suggestion-only approval workflow
- Dashboard, Admin Panel, audit history, CSV/JSON exports
- Dark/light themes, responsive layouts, keyboard shortcut Ctrl/Cmd+K
- CSP, safe CSV escaping, no silent upload or rename

## Browser limitations
Use current Chromium-based browsers for `showDirectoryPicker`. Other browsers use folder-upload fallback. Browsers do not expose absolute Windows paths, NTFS owner, created time, SharePoint Modified By, or guaranteed atomic rename. This release therefore exports approved rename plans instead of claiming direct rename execution.

## Production build
`npm run validate` creates `dist/`. The included server exposes `/health`.

See `docs/` and `run_scripts/README.md`.
