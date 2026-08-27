class TMan < Formula
  desc "Declarative launchd agent and daemon manager for macOS"
  homepage "https://github.com/mad01/thismoon"
  url "https://github.com/mad01/thismoon/releases/download/t-man/v0.5.0/t-man_v0.5.0_darwin_arm64.tar.gz"
  version "0.5.0"
  sha256 "eb4e4990ecc00135556c5f3ebc011be92ff1cf53e4443c65fdc8ab2dbfc2cf7c"
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
