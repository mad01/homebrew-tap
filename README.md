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
| catalog | Service catalog from `service-info.yaml` files | 7575 |
| deps | Dependency scanner against OSV.dev advisories | 7429 |
| events | Local event and audit log | 7430 |
| status | Uptime page for the local fleet | 7426 |
| d-man | `.this` front door: `/etc/hosts` + reverse proxy | 80/443 (root) |
| belt | Claude Code guard hooks | — |
| suspenders | Git secret scanner + pre-commit hooks | — |
| t-man | Declarative launchd manager | — |
| ralph | Fleet installer, reconciles TOML recipes | — |

Install with the tap-qualified name (`brew install mad01/tap/keep`, not
`keep`): homebrew casks named `keep` and `status` already exist, and the
qualified form never collides.

## Running services: brew services or t-man

Every service formula ships a service block, so Homebrew's own launchd
integration runs it:

```sh
brew services start mad01/tap/csl     # web UI on http://127.0.0.1:7424
```

t-man, the fleet's launchd manager, does the same job. Pick ONE manager per
service — both write launchd jobs, and two jobs running the same binary
fight over the port.

### d-man, the root exception

d-man is what turns `127.0.0.1:7424` into `http://csl.this/`: it keeps a
managed block in `/etc/hosts` and reverse-proxies `:80`/`:443` by hostname,
which needs root. Two ways to run it:

- **brew services** (needs d-man 0.3.1 or later): put your routes at
  `/etc/d-man/routes.toml`, then `sudo brew services start mad01/tap/d-man`.
- **t-man**, one-time registration against a per-user routes file:

  ```sh
  sudo t-man --daemon add --name d-man -- \
    $(brew --prefix)/bin/d-man serve --config $HOME/.config/d-man/routes.toml
  ```

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
