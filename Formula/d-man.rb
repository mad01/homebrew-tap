class DMan < Formula
  desc "Local .this front door: managed /etc/hosts entries and reverse proxy"
  homepage "https://github.com/mad01/thismoon"
  url "https://github.com/mad01/thismoon/releases/download/d-man/v0.6.0/d-man_v0.6.0_darwin_arm64.tar.gz"
  version "0.6.0"
  sha256 "6fb1f3efd93f12c50660aee000e4f58d28f840e6716adfdaad51f4b9d734bcbe"
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
