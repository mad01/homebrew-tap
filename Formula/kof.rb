class Kof < Formula
  desc "keeper-of-facts: assertion store with evidence pins, claims go stale with the code"
  homepage "https://github.com/mad01/thismoon"
  url "https://github.com/mad01/thismoon/releases/download/keeper-of-facts/v0.11.1/kof_v0.11.1_darwin_arm64.tar.gz"
  version "0.11.1"
  sha256 "98c2a7caf616683475987f104cb507eef3e94ef715dfc9962ca7018213fc118d"
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
