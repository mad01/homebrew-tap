class DMan < Formula
  desc "Local .this front door: managed /etc/hosts entries and reverse proxy"
  homepage "https://github.com/mad01/thismoon"
  url "https://github.com/mad01/thismoon/releases/download/d-man/v0.3.0/d-man_v0.3.0_darwin_arm64.tar.gz"
  version "0.3.0"
  sha256 "70c8739d33cf9f99ad1d2fd1fee6332da3fdc88c03fa224238f62fb65bdf60b6"
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
      root:
        sudo brew services start mad01/tap/d-man

      Configure routes first; `d-man list` shows what is active.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/d-man version")
  end
end
