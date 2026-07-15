class Belt < Formula
  desc "Guard hooks for Claude Code: blocks push-to-main and unsafe writes"
  homepage "https://github.com/mad01/thismoon"
  url "https://github.com/mad01/thismoon/releases/download/belt/v0.2.0/belt_v0.2.0_darwin_arm64.tar.gz"
  version "0.2.0"
  sha256 "4031af02c91b22a23012d8acf08457e34067ea63f14840503d363651160a220f"
  license "BSD-3-Clause"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "belt"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/belt version")
  end
end
