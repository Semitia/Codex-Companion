# Codex Companion Pets

[English README](./README.md)

这个仓库存放可直接安装到 Codex 的自定义 companion pet。每个 pet 都是一个独立目录，目录里至少包含：

- `pet.json`
- `spritesheet.webp`

部分 pet 还带有 `qa/` 目录，用来查看 contact sheet、逐行动画 GIF 和验证结果。

## 可用 Pet

| Pet | 包目录 | 预览 |
| --- | --- | --- |
| Kaguya-Tsukuyomi | [`kaguya-tsukuyomi/`](./kaguya-tsukuyomi/) | [`qa/contact-sheet.png`](./kaguya-tsukuyomi/qa/contact-sheet.png) |
| Kaguya | [`kaguya/`](./kaguya/) | [`qa/contact-sheet.png`](./kaguya/qa/contact-sheet.png) |

## 安装 Pet

克隆仓库后，在仓库根目录运行对应系统的安装命令。

### Windows PowerShell

```powershell
.\scripts\install-pet.ps1 kaguya-tsukuyomi
```

### macOS / Linux

```bash
chmod +x ./scripts/install-pet.sh
./scripts/install-pet.sh kaguya-tsukuyomi
```

脚本会把选中的 pet 包复制到：

- Windows：`%USERPROFILE%\.codex\pets\<pet-id>\`
- macOS / Linux：`~/.codex/pets/<pet-id>/`

安装后，如果 Codex 没有立即显示新的 pet，请重启 Codex 或刷新 pet 选择器。

## 手动安装

你也可以手动复制 pet 包。目标文件夹名称应与 `pet.json` 里的 `id` 保持一致。

Windows PowerShell：

```powershell
$pet = "kaguya-tsukuyomi"
New-Item -ItemType Directory -Force "$env:USERPROFILE\.codex\pets\$pet" | Out-Null
Copy-Item ".\$pet\pet.json", ".\$pet\spritesheet.webp" "$env:USERPROFILE\.codex\pets\$pet" -Force
```

macOS / Linux：

```bash
pet="kaguya-tsukuyomi"
mkdir -p "$HOME/.codex/pets/$pet"
cp "$pet/pet.json" "$pet/spritesheet.webp" "$HOME/.codex/pets/$pet/"
```

## Pet 包结构

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

`spritesheet.webp` 使用 Codex pet atlas 布局：

- 8 列 x 9 行
- 每个 cell 为 192 x 208 像素
- 总尺寸为 1536 x 1872 像素

行顺序：

1. `idle`
2. `running-right`
3. `running-left`
4. `waving`
5. `jumping`
6. `failed`
7. `waiting`
8. `running`
9. `review`

## 仓库说明

`pet-runs/` 会被刻意忽略。它包含体积较大的生成过程文件、修复产物和中间素材；仓库只提交最终可安装的 pet 包和 QA 输出。

