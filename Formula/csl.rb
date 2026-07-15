class Csl < Formula
  desc "Code search over local git checkouts with web UI, CLI, and MCP server"
  homepage "https://github.com/mad01/thismoon"
  url "https://github.com/mad01/thismoon/releases/download/csl/v0.7.2/csl_v0.7.2_darwin_arm64.tar.gz"
  version "0.7.2"
  sha256 "b2c3bf15946a1d9bd7d796e6f4e32419159dff24e71939e35c6c550a8284b4d8"
  license "BSD-3-Clause"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "csl"
  end

  service do
    run [opt_bin/"csl", "web"]
    keep_alive true
    log_path var/"log/csl.log"
    error_log_path var/"log/csl.log"
  end

  def caveats
    <<~EOS
      First run: tell csl where your repos live, then build the index:
        mkdir -p ~/.config/csl
        printf 'dirs:\n  - ~/code\n' > ~/.config/csl/config.yaml
        csl index --all

      Start the web UI (http://127.0.0.1:7424) as a background service:
        brew services start mad01/tap/csl

      Register the MCP server with Claude Code:
        claude mcp add csl -- csl mcp
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/csl version")
  end
end
