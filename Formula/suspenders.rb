class Suspenders < Formula
  desc "Git secret scanner and pre-commit hook orchestrator"
  homepage "https://github.com/mad01/thismoon"
  url "https://github.com/mad01/thismoon/releases/download/suspenders/v0.3.2/suspenders_v0.3.2_darwin_arm64.tar.gz"
  version "0.3.2"
  sha256 "9136efb2b2639937a21baef6b81ad7767e7ba136478ea62bd3f3201586dde473"
  license "BSD-3-Clause"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "suspenders"
  end

  def caveats
    <<~EOS
      Install the pre-commit hook in a repo:
        suspenders hook install
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/suspenders version")
  end
end
