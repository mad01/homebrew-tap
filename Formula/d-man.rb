class DMan < Formula
  desc "Local .this front door: managed /etc/hosts entries and reverse proxy"
  homepage "https://github.com/mad01/thismoon"
  url "https://github.com/mad01/thismoon/releases/download/d-man/v0.3.1/d-man_v0.3.1_darwin_arm64.tar.gz"
  version "0.3.1"
  sha256 "3ea6d588b5da45bad988d2415a68a24075ae4f328ccbd297802ffb404a0884e4"
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
