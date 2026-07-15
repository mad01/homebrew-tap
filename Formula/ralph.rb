class Ralph < Formula
  desc "Declarative machine reconciler driven by TOML recipes"
  homepage "https://github.com/mad01/ralph"
  url "https://github.com/mad01/ralph/releases/download/v0.2.0/ralph_0.2.0_darwin_arm64.tar.gz"
  version "0.2.0"
  sha256 "ba2d4587d1578869d1a55c1846ab5aa4ea41c432c2466bea93e57891bb80f8f7"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "ralph"
  end

  def caveats
    <<~EOS
      Create a config, then converge the machine:
        ralph init
        ralph up
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ralph version")
  end
end
