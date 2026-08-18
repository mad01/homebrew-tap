class Speak < Formula
  desc "Reads markdown aloud through a local TTS model"
  homepage "https://github.com/mad01/thismoon"
  url "https://github.com/mad01/thismoon/releases/download/speak/v0.3.0/speak_v0.3.0_darwin_arm64.tar.gz"
  version "0.3.0"
  sha256 "167fa4803db6701e954e2fc1326dfcbcf318571ee5db41c85a9f5b0364ec5d61"
  license "BSD-3-Clause"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "speak"
  end

  service do
    run [opt_bin/"speak", "serve"]
    keep_alive true
    log_path var/"log/speak.log"
    error_log_path var/"log/speak.log"
  end

  def caveats
    <<~EOS
      Start the server (http://127.0.0.1:7425) as a background service:
        brew services start mad01/tap/speak

      speak fronts an OpenAI-compatible TTS server on 127.0.0.1:8765 and does
      not install one. Without it the page loads but audio requests return
      502. Run a local engine (e.g. mlx-audio serving Kokoro) on that port,
      or point speak at another engine with --tts-url / SPEAK_TTS_URL.

      Register the MCP server with Claude Code:
        claude mcp add speak -- speak mcp
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/speak version")
  end
end
