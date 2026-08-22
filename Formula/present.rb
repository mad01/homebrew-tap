class Present < Formula
  desc "Single-page HTML briefings, authored as structured JSON"
  homepage "https://github.com/mad01/thismoon"
  url "https://github.com/mad01/thismoon/releases/download/present/v0.5.1/present_v0.5.1_darwin_arm64.tar.gz"
  version "0.5.1"
  sha256 "e3d057a54251da6e41ca6cc7c036a544c8012aa268d51cda048c5864ec6b56e3"
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
