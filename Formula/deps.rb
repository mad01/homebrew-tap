class Deps < Formula
  desc "Supply-chain scanner: checks dependencies against OSV.dev advisories"
  homepage "https://github.com/mad01/thismoon"
  url "https://github.com/mad01/thismoon/releases/download/deps/v0.3.0/deps_v0.3.0_darwin_arm64.tar.gz"
  version "0.3.0"
  sha256 "5aec261776fa1002de9c50a40704b7fe38163a6b19b514623a727921543b8046"
  license "BSD-3-Clause"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "deps"
  end

  service do
    run [opt_bin/"deps", "serve"]
    keep_alive true
    log_path var/"log/deps.log"
    error_log_path var/"log/deps.log"
  end

  def caveats
    <<~EOS
      Start the server (http://127.0.0.1:7429) as a background service:
        brew services start mad01/tap/deps

      Register the MCP server with Claude Code:
        claude mcp add deps -- deps mcp
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/deps version")
  end
end
