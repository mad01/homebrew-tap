# mad01/homebrew-tap

Homebrew formulas for [thismoon](https://github.com/mad01/thismoon)
components and [ralph](https://github.com/mad01/ralph). The binaries target
macOS on Apple Silicon (darwin/arm64) and come from each component's GitHub
Release, built and signed by CI.

## Install

```sh
brew tap mad01/tap
brew install mad01/tap/csl
```

| Formula | What it is | Service port |
|---------|------------|--------------|
| csl | Code search: web UI, CLI, MCP server | 7424 |
| keep | Assertion store with evidence pins | 7431 |
| present | HTML briefing pages, authored as JSON | 7423 |
| speak | Reads markdown aloud (local TTS) | 7425 |
| d-man | `.this` front door: `/etc/hosts` + reverse proxy | 80/443 (root) |
| belt | Claude Code guard hooks | — |
| t-man | Declarative launchd manager | — |
| ralph | Fleet installer, reconciles TOML recipes | — |

Install with the tap-qualified name (`brew install mad01/tap/keep`, not
`keep`): a homebrew cask named `keep` already exists, and the qualified
form never collides.

## Running services: t-man or brew services

t-man (in this tap) is the recommended manager: one `t-man add` line is
idempotent across re-runs, and `--sandbox-profile` wraps the service in a
seatbelt sandbox through `sandbox-exec`, which brew services can't do.

```sh
brew install mad01/tap/t-man
t-man add --name csl-web -- $(brew --prefix)/bin/csl web
```

Every service formula also ships a service block, so Homebrew's own launchd
integration works with zero setup:

```sh
brew services start mad01/tap/csl     # web UI on http://127.0.0.1:7424
```

Whichever you choose, pick ONE manager per service — both write launchd
jobs, and two jobs running the same binary fight over the port.

### d-man, the root exception

d-man is what turns `127.0.0.1:7424` into `http://csl.this/`: it keeps a
managed block in `/etc/hosts` and reverse-proxies `:80`/`:443` by hostname,
which needs root. Two ways to run it:

- **t-man**, one-time registration against a per-user routes file:

  ```sh
  sudo t-man --daemon add --name d-man -- \
    $(brew --prefix)/bin/d-man serve --config $HOME/.config/d-man/routes.toml
  ```

- **brew services** (needs d-man 0.3.1 or later): put your routes at
  `/etc/d-man/routes.toml`, then `sudo brew services start mad01/tap/d-man`.

Without d-man everything still works on `http://127.0.0.1:<port>` — the
hostnames are the only thing you lose.

## The whole stack, the fleet way

The brew path installs tools one at a time and you manage the services. The
alternative is [ralph](https://github.com/mad01/ralph): recipes in the
thismoon repo build every component from source, register the services with
t-man, and every `ralph up` converges the machine — see the
[thismoon README](https://github.com/mad01/thismoon). Machine wiring that
lives outside this tap either way: which `.this` routes exist, MCP
registration, and private companions like the speak TTS engine.

## Note while thismoon is private

The thismoon formulas download release tarballs from the thismoon repo.
Until that repo is public, their `brew install` gets a 404 — this tap is
prepared ahead of the flip and starts working the moment thismoon does.
`ralph` comes from a public repo and installs today.

## License

BSD-3-Clause, see [LICENSE](LICENSE).
