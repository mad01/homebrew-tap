class Present < Formula
  desc "Single-page HTML briefings, authored as structured JSON"
  homepage "https://github.com/mad01/thismoon"
  url "https://github.com/mad01/thismoon/releases/download/present/v0.1.1/present_v0.1.1_darwin_arm64.tar.gz"
  version "0.1.1"
  sha256 "e2b074202ef7fe99d5d986bcc06d3e7ec947aef20ce845c35a9c7d97b379f098"
  license "BSD-3-Clause"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "present"
  end

  service do
    run [opt_bin/"present", "serve"]
    keep_alive true
    log_path var/"log/present.log"
    error_log_path var/"log/present.log"
  end

  def caveats
    <<~EOS
      Start the page server (http://127.0.0.1:7423) as a background service:
        brew services start mad01/tap/present

      Register the MCP server with Claude Code:
        claude mcp add present -- present mcp
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/present version")
  end
end
