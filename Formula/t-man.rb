class TMan < Formula
  desc "Declarative launchd agent and daemon manager for macOS"
  homepage "https://github.com/mad01/thismoon"
  url "https://github.com/mad01/thismoon/releases/download/t-man/v0.2.0/t-man_v0.2.0_darwin_arm64.tar.gz"
  version "0.2.0"
  sha256 "d1470c21d79b747727819034703fa314a200106d906250fde45f2d85accd3ab1"
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
