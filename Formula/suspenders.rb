class Suspenders < Formula
  desc "Git secret scanner and pre-commit hook orchestrator"
  homepage "https://github.com/mad01/thismoon"
  url "https://github.com/mad01/thismoon/releases/download/suspenders/v0.3.1/suspenders_v0.3.1_darwin_arm64.tar.gz"
  version "0.3.1"
  sha256 "550cc79365e95328a3197d930cda2f8271c2cef3052bbcfd53f411187c92c684"
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
    # The v0.3.1 tarball was built without version ldflags and reports
    # "suspenders dev"; match the name until a rebuilt release ships.
    assert_match "suspenders", shell_output("#{bin}/suspenders version")
  end
end
