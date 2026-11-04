# Chord Homebrew tap

[English](./README.md) | 简体中文

安装 [Chord](https://github.com/keakon/chord)：

```bash
brew install keakon/tap/chord
```

升级：

```bash
brew update
brew upgrade chord
```

配方直接安装 [Chord Release](https://github.com/keakon/chord/releases) 中的二进制包，支持 macOS 和 Linux 的 arm64、x86_64，无需 Go。每个平台的下载地址固定到具体版本，并校验 SHA256。安装时同时生成 Bash、Zsh 和 Fish 补全。配方不提供源码编译回退。

## 发布版本

版本 tag 在 `keakon/chord` 中维护。本仓库只需维护 `main`，不创建每版本分支、tag 或 Release。

主仓库推送 `vX.Y.Z` tag 后，`release.yml` 构建并上传安装包，成功后调用 `homebrew.yml`：

1. 确认是最新正式 Release，且版本高于 tap 当前版本；首次添加配方也允许。
2. 从 Release 的 `SHA256SUMS` 生成配方。
3. 在 macOS ARM64、Intel 和 Linux ARM64、x86_64 上运行 Homebrew 安装、测试及 audit。
4. 全部通过后，再次确认 Release 和配方一致，直接提交到本仓库的 `main`。

构建和发布验证全部在 `keakon/chord` 中运行。本仓库不配置 Actions 工作流或 Dependabot，push 和 PR 均不运行 Actions。草稿、预发布、旧版本及已更新的版本不会更新 tap。

更新失败后，可以在主仓库单独重试：

```bash
gh workflow run homebrew.yml --repo keakon/chord --ref main -f tag=v0.8.2
```

将 tag 替换为待更新的正式版本。重试复用已有 Release，不重建发布包。验证失败时 tap 保持原版本；推送遇到并发更新会失败，不会强制覆盖 `main`。

配方由主仓库的 `scripts/homebrew/chord.rb.erb` 生成。修改安装或测试逻辑时，应更新该模板及本仓库配方，避免下次发布覆盖修改，并在主仓库验证这些变更。文档更新按普通 PR 合并。

## 首次启用

创建公开 GitHub 仓库 `keakon/homebrew-tap`，将本项目放入默认分支 `main`。在 `keakon/chord` 启用 Actions；本仓库不需要 Actions。

在 `keakon/chord` 配置 Actions secret `HOMEBREW_TAP_TOKEN`，使用只授权本仓库、拥有 Contents 读写权限的细粒度个人访问令牌，无需 Pull requests 权限。`main` 的分支规则必须允许该身份直接推送。此令牌只用于最后的提交步骤，安装测试使用只读权限。

创建发布 tag 前，需要先提交并推送主仓库的 `homebrew.yml`、生成脚本和模板。对于已有 Release，待这些文件进入主仓库远端 `main` 后，即可手动运行更新任务。

## 本地验证

```bash
brew install keakon/tap/chord
brew test keakon/tap/chord
brew audit --strict keakon/tap/chord
```

在主仓库验证生成与更新逻辑：

```bash
ruby scripts/test_homebrew.rb
```

本地验证只覆盖当前平台，四个平台的完整结果以主仓库 `homebrew.yml` 的运行结果为准。
