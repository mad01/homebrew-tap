# mad01/homebrew-tap

Homebrew formulas for [thismoon](https://github.com/mad01/thismoon)
components and [ralph](https://github.com/mad01/ralph). The binaries target
macOS on Apple Silicon (darwin/arm64) and come from each component's GitHub
Release, built and signed by CI.

## Usage

```sh
brew tap mad01/tap
brew install mad01/tap/csl          # code search: web UI, CLI, MCP server
brew install mad01/tap/keep         # assertion store with evidence pins
brew install mad01/tap/present      # HTML briefing pages, authored as JSON
brew install mad01/tap/speak        # reads markdown aloud (local TTS)
brew install mad01/tap/d-man        # .this front door: /etc/hosts + proxy
brew install mad01/tap/belt         # Claude Code guard hooks
brew install mad01/tap/suspenders   # git secret scanner + pre-commit hooks
brew install mad01/tap/t-man        # declarative launchd manager
brew install mad01/tap/ralph        # fleet installer, reconciles TOML recipes
```

Use the tap-qualified name (`mad01/tap/keep`, not `keep`): a homebrew cask
named `keep` already exists, and the qualified form never collides.

The services run in the background through Homebrew's own launchd
integration:

```sh
brew services start mad01/tap/csl        # web UI on http://127.0.0.1:7424
brew services start mad01/tap/keep       # store on http://127.0.0.1:7431
brew services start mad01/tap/present    # pages on http://127.0.0.1:7423
brew services start mad01/tap/speak      # server on http://127.0.0.1:7425
sudo brew services start mad01/tap/d-man # root: rewrites /etc/hosts, low ports
```

Installing the whole thismoon fleet (every service, `.this` hostnames,
config overlays) goes through [ralph](https://github.com/mad01/ralph)
instead — see the [thismoon README](https://github.com/mad01/thismoon).

## Note while thismoon is private

The thismoon formulas download release tarballs from the thismoon repo.
Until that repo is public, their `brew install` gets a 404 — this tap is
prepared ahead of the flip and starts working the moment thismoon does.
`ralph` comes from a public repo and installs today.

## License

BSD-3-Clause, see [LICENSE](LICENSE).
