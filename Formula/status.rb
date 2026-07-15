class Status < Formula
  desc "Uptime page with 30-day history for the local service fleet"
  homepage "https://github.com/mad01/thismoon"
  url "https://github.com/mad01/thismoon/releases/download/status/v0.2.0/status_v0.2.0_darwin_arm64.tar.gz"
  version "0.2.0"
  sha256 "bb0661c90a56a12e5109b95cc034ec94231eac9609574e97af8532ffbe2bacd0"
  license "BSD-3-Clause"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "status"
  end

  service do
    run [opt_bin/"status", "serve"]
    keep_alive true
    log_path var/"log/status.log"
    error_log_path var/"log/status.log"
  end

  def caveats
    <<~EOS
      Start the status page (http://127.0.0.1:7426) as a background service:
        brew services start mad01/tap/status

      Use the tap-qualified name: a homebrew cask named "status" exists.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/status version")
  end
end
