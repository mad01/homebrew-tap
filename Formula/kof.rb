class Kof < Formula
  desc "keeper-of-facts: assertion store with evidence pins, claims go stale with the code"
  homepage "https://github.com/mad01/thismoon"
  url "https://github.com/mad01/thismoon/releases/download/keeper-of-facts/v0.7.1/kof_v0.7.1_darwin_arm64.tar.gz"
  version "0.7.1"
  sha256 "9291417e9086361ff5251af037330e3bb57f1c15009c52baecbd89fbbbff448a"
  license "BSD-3-Clause"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "kof"
  end

  service do
    run [opt_bin/"kof", "serve"]
    keep_alive true
    log_path var/"log/kof.log"
    error_log_path var/"log/kof.log"
  end

  def caveats
    <<~EOS
      Start the store (http://127.0.0.1:7431) as a background service:
        brew services start mad01/tap/kof

      Register the MCP server with Claude Code:
        claude mcp add kof -- kof mcp

      Upgrading from the old `keep` formula: `kof serve` migrates a
      ~/.local/share/keep store to ~/.local/share/kof on first start.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kof version")
  end
end
