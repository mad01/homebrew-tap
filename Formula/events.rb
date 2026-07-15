class Events < Formula
  desc "Local event and audit log with a web timeline, archive-only JSONL store"
  homepage "https://github.com/mad01/thismoon"
  url "https://github.com/mad01/thismoon/releases/download/events/v0.1.0/events_v0.1.0_darwin_arm64.tar.gz"
  version "0.1.0"
  sha256 "ffba6bc4fb4bd43dd1dfcd8373100afdc26c76edf1a9f367e6be172e2a3af374"
  license "BSD-3-Clause"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "events"
  end

  service do
    run [opt_bin/"events", "serve"]
    keep_alive true
    log_path var/"log/events.log"
    error_log_path var/"log/events.log"
  end

  def caveats
    <<~EOS
      Start the server (http://127.0.0.1:7430) as a background service:
        brew services start mad01/tap/events

      Register the MCP server with Claude Code:
        claude mcp add events -- events mcp
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/events version")
  end
end
