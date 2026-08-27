class Present < Formula
  desc "Single-page HTML briefings, authored as structured JSON"
  homepage "https://github.com/mad01/thismoon"
  url "https://github.com/mad01/thismoon/releases/download/present/v1.0.0/present_v1.0.0_darwin_arm64.tar.gz"
  version "1.0.0"
  sha256 "b40b02cdb328472c5af23bdc457e6f8cab0940b8c3aac55c0e739aa8ff5c3def"
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
