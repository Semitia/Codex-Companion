# Codex Companion Pets

[Chinese README](./README.zh-CN.md)

This repository contains custom companion pets that can be installed into Codex. Each pet is packaged as its own directory with at least:

- `pet.json`
- `spritesheet.webp`

Some pets also include a `qa/` directory with contact sheets, per-state animation GIFs, and validation results.

## Available Pets

| Pet | Package | Preview |
| --- | --- | --- |
| Kaguya-Tsukuyomi | [`kaguya-tsukuyomi/`](./kaguya-tsukuyomi/) | [`qa/contact-sheet.png`](./kaguya-tsukuyomi/qa/contact-sheet.png) |
| Kaguya | [`kaguya/`](./kaguya/) | [`qa/contact-sheet.png`](./kaguya/qa/contact-sheet.png) |

## Install A Pet

Clone the repository, then run one of the install commands from the repository root.

### Windows PowerShell

```powershell
.\scripts\install-pet.ps1 kaguya-tsukuyomi
```

### macOS / Linux

```bash
chmod +x ./scripts/install-pet.sh
./scripts/install-pet.sh kaguya-tsukuyomi
```

The scripts copy the selected package to:

- Windows: `%USERPROFILE%\.codex\pets\<pet-id>\`
- macOS / Linux: `~/.codex/pets/<pet-id>/`

After installing, restart Codex or reload the pet picker if the app does not show the new pet immediately.

## Manual Install

You can also copy a pet package manually. The destination folder name should match the `id` in `pet.json`.

Windows PowerShell:

```powershell
$pet = "kaguya-tsukuyomi"
New-Item -ItemType Directory -Force "$env:USERPROFILE\.codex\pets\$pet" | Out-Null
Copy-Item ".\$pet\pet.json", ".\$pet\spritesheet.webp" "$env:USERPROFILE\.codex\pets\$pet" -Force
```

macOS / Linux:

```bash
pet="kaguya-tsukuyomi"
mkdir -p "$HOME/.codex/pets/$pet"
cp "$pet/pet.json" "$pet/spritesheet.webp" "$HOME/.codex/pets/$pet/"
```

## Pet Package Layout

```text
pet-name/
  pet.json
  spritesheet.webp
  README.md
  qa/
    contact-sheet.png
    review.json
    validation.json
    previews/
      idle.gif
      running-right.gif
      running-left.gif
      waving.gif
      jumping.gif
      failed.gif
      waiting.gif
      running.gif
      review.gif
```

`spritesheet.webp` uses the Codex pet atlas layout:

- 8 columns by 9 rows
- 192 x 208 pixels per cell
- 1536 x 1872 pixels total

Row order:

1. `idle`
2. `running-right`
3. `running-left`
4. `waving`
5. `jumping`
6. `failed`
7. `waiting`
8. `running`
9. `review`

## Repository Notes

`pet-runs/` is intentionally ignored. It contains large generation and repair artifacts, while the checked-in pet directories contain the final installable packages and QA outputs.
