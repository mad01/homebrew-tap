class TMan < Formula
  desc "Declarative launchd agent and daemon manager for macOS"
  homepage "https://github.com/mad01/thismoon"
  url "https://github.com/mad01/thismoon/releases/download/t-man/v0.4.0/t-man_v0.4.0_darwin_arm64.tar.gz"
  version "0.4.0"
  sha256 "c914f2959f4c72c186a5d1a1402fabe39a8974e0ace28256f44ad39cce21a99d"
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
