class Belt < Formula
  desc "Guard hooks for Claude Code: blocks push-to-main and unsafe writes"
  homepage "https://github.com/mad01/thismoon"
  url "https://github.com/mad01/thismoon/releases/download/belt/v0.16.0/belt_v0.16.0_darwin_arm64.tar.gz"
  version "0.16.0"
  sha256 "553e349b2b248bd71e9cb67e592b820e8f661d83ed5d9c22cf01d66ff23f9c2d"
  license "BSD-3-Clause"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "belt"
  end

  def caveats
    <<~EOS
      Wire belt into ~/.claude/settings.json — the event argument is belt's
      guard event (lowercase), not the Claude Code tool name:

        "hooks": {
          "PreToolUse": [
            {"matcher": "Bash",
             "hooks": [{"type": "command", "command": "belt hook bash"}]},
            {"matcher": "Write|Edit",
             "hooks": [{"type": "command", "command": "belt hook write"}]}
          ]
        }

      Hook changes take effect in the next Claude Code session.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/belt version")
  end
end
