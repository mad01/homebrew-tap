class Ralph < Formula
  desc "Declarative machine reconciler driven by TOML recipes"
  homepage "https://github.com/mad01/ralph"
  url "https://github.com/mad01/ralph/releases/download/v0.3.0/ralph_0.3.0_darwin_arm64.tar.gz"
  version "0.3.0"
  sha256 "29b5fd25bcb67d5bb079d9bea41d1e07360e7d2ab149a9d4b9d48a1e8cac80a8"
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
