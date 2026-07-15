class Csl < Formula
  desc "Code search over local git checkouts with web UI, CLI, and MCP server"
  homepage "https://github.com/mad01/thismoon"
  url "https://github.com/mad01/thismoon/releases/download/csl/v0.7.1/csl_v0.7.1_darwin_arm64.tar.gz"
  version "0.7.1"
  sha256 "4a690a61f5129744b37d1afc35529c337d8b95155048ca86d446f3fb2e501d3a"
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
