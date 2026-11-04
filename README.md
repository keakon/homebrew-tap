# Chord Homebrew tap

English | [简体中文](./README_CN.md)

Install [Chord](https://github.com/keakon/chord):

```bash
brew install keakon/tap/chord
```

To upgrade:

```bash
brew update
brew upgrade chord
```

The formula installs binaries from [Chord Releases](https://github.com/keakon/chord/releases) for macOS and Linux on arm64 and x86_64, without Go. Each platform's download URL is pinned to a specific version and verified with SHA256. Installation also generates Bash, Zsh, and Fish completions. The formula does not fall back to compiling from source.

## Publishing releases

Version tags are maintained in `keakon/chord`. This repository uses `main` and does not create branches, tags, or releases for individual versions.

Pushing a `vX.Y.Z` tag to the upstream repository runs `release.yml` to build and upload the archives. Once that succeeds, it calls `homebrew.yml` to:

1. Confirm that this is the latest stable release and is newer than the tap's current version. Adding the formula for the first time is also supported.
2. Generate the formula from the release's `SHA256SUMS`.
3. Run Homebrew installation, tests, and audit on macOS ARM64 and Intel, and Linux ARM64 and x86_64.
4. After all checks pass, verify that the release and formula still match, then commit directly to this repository's `main`.

All builds and release validation run in `keakon/chord`. This tap has no Actions workflows or Dependabot configuration; pushes and pull requests do not run Actions. Drafts, prereleases, older releases, and versions already present in the tap do not update it.

If an update fails, retry it separately in the upstream repository:

```bash
gh workflow run homebrew.yml --repo keakon/chord --ref main -f tag=v0.8.2
```

Replace the tag with the stable version to publish. Retries reuse the existing release without rebuilding its archives. Validation failures leave the tap at its current version. A push that conflicts with a concurrent update fails without overwriting `main`.

The formula is generated from `scripts/homebrew/chord.rb.erb` in the upstream repository. When changing installation or test logic, update both the template and this repository's formula so the next release preserves the changes, and validate the changes in the upstream repository. Documentation updates use regular pull requests.

## Initial setup

Create the public GitHub repository `keakon/homebrew-tap` and push this project to its default branch `main`. Enable Actions in `keakon/chord`; this tap does not need Actions.

In `keakon/chord`, set the Actions secret `HOMEBREW_TAP_TOKEN` to a fine-grained personal access token with Contents read/write access only to this repository. Pull requests permission is not required. The branch rules for `main` must allow this identity to push directly. Only the final publishing step uses this token; installation tests use read-only permissions.

Commit and push the upstream repository's `homebrew.yml`, generator script, and template before creating a release tag. For an existing release, run the update workflow manually after these files are available on the upstream repository's `main`.

## Local validation

```bash
brew install keakon/tap/chord
brew test keakon/tap/chord
brew audit --strict keakon/tap/chord
```

In the upstream repository, test formula generation and updates:

```bash
ruby scripts/test_homebrew.rb
```

Local validation covers only the current platform. Check the upstream repository's `homebrew.yml` run for results on all four platforms.
