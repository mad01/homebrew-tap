class DMan < Formula
  desc "Local .this front door: managed /etc/hosts entries and reverse proxy"
  homepage "https://github.com/mad01/thismoon"
  url "https://github.com/mad01/thismoon/releases/download/d-man/v0.4.0/d-man_v0.4.0_darwin_arm64.tar.gz"
  version "0.4.0"
  sha256 "f36091d13f85e831f971f5fef1afdbac3f281052659e666ac85c20bbc59eea18"
  license "BSD-3-Clause"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "d-man"
  end

  service do
    run [opt_bin/"d-man", "serve"]
    require_root true
    keep_alive true
    log_path var/"log/d-man.log"
    error_log_path var/"log/d-man.log"
  end

  def caveats
    <<~EOS
      d-man rewrites /etc/hosts and binds low ports, so the service runs as
      root. Root has no useful HOME, so put the routes file at the system
      path, then start the service:
        sudo mkdir -p /etc/d-man
        sudo cp your-routes.toml /etc/d-man/routes.toml
        sudo brew services start mad01/tap/d-man

      `d-man list` shows the active routes. After a brew upgrade, restart:
        sudo brew services restart mad01/tap/d-man
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/d-man version")
  end
end
