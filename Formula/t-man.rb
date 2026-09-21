class TMan < Formula
  desc "Declarative launchd agent and daemon manager for macOS"
  homepage "https://github.com/mad01/thismoon"
  url "https://github.com/mad01/thismoon/releases/download/t-man/v0.5.3/t-man_v0.5.3_darwin_arm64.tar.gz"
  version "0.5.3"
  sha256 "b397cb6bc0deed64c49dff2b8e7107cc8ce789c8b2ba0040d6216032ec3f3416"
  license "BSD-3-Clause"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "t-man"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/t-man version")
  end
end
