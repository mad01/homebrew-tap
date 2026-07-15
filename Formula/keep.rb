class Keep < Formula
  desc "Assertion store: evidence-pinned claims about code that go stale with it"
  homepage "https://github.com/mad01/thismoon"
  url "https://github.com/mad01/thismoon/releases/download/keep/v0.2.0/keep_v0.2.0_darwin_arm64.tar.gz"
  version "0.2.0"
  sha256 "3f091fc9878eab2aeb190d18b2afaca4c99dd0f02f9dc95d016993daac7af008"
  license "BSD-3-Clause"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "keep"
  end

  service do
    run [opt_bin/"keep", "serve"]
    keep_alive true
    log_path var/"log/keep.log"
    error_log_path var/"log/keep.log"
  end

  def caveats
    <<~EOS
      Start the store (http://127.0.0.1:7431) as a background service:
        brew services start mad01/tap/keep

      Register the MCP server with Claude Code:
        claude mcp add keep -- keep mcp
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/keep version")
  end
end
