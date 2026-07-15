# mad01/homebrew-tap

Homebrew formulas for [thismoon](https://github.com/mad01/thismoon)
components, plus other mad01 tools. The thismoon binaries target macOS on
Apple Silicon (darwin/arm64) and come from each component's GitHub Release,
built and signed by CI.

## Usage

```sh
brew tap mad01/tap
brew install mad01/tap/csl     # code search: web UI, CLI, MCP server
brew install mad01/tap/keep    # assertion store with evidence pins
brew install mad01/tap/t-man   # declarative launchd manager
```

Use the tap-qualified name (`mad01/tap/keep`, not `keep`): a homebrew cask
named `keep` already exists, and the qualified form never collides.

csl and keep run as background services through Homebrew's own launchd
integration:

```sh
brew services start mad01/tap/csl    # web UI on http://127.0.0.1:7424
brew services start mad01/tap/keep   # store on http://127.0.0.1:7431
```

Installing the whole thismoon fleet (every service, `.this` hostnames,
config overlays) goes through [ralph](https://github.com/mad01/ralph)
instead — see the [thismoon README](https://github.com/mad01/thismoon).

## Note while thismoon is private

Formulas download release tarballs from the thismoon repo. Until that repo
is public, `brew install` gets a 404 — this tap is prepared ahead of the
flip and starts working the moment thismoon does.

## License

BSD-3-Clause, see [LICENSE](LICENSE).
