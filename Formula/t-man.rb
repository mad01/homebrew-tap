class TMan < Formula
  desc "Declarative launchd agent and daemon manager for macOS"
  homepage "https://github.com/mad01/thismoon"
  url "https://github.com/mad01/thismoon/releases/download/t-man/v0.1.0/t-man_v0.1.0_darwin_arm64.tar.gz"
  version "0.1.0"
  sha256 "04b2101ca445f6f9113951198b411eac4b2d179bbe03c43d25ed1cb953023fa6"
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
