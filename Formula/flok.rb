class Flok < Formula
  desc "Window grouping CLI for macOS — create app groups and cycle between them"
  homepage "https://github.com/mad01/flok"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/mad01/flok/releases/download/v#{version}/flok-#{version}-darwin-arm64.tar.gz"
      # sha256 "UPDATE_WITH_ACTUAL_SHA256"
    end
    on_intel do
      url "https://github.com/mad01/flok/releases/download/v#{version}/flok-#{version}-darwin-amd64.tar.gz"
      # sha256 "UPDATE_WITH_ACTUAL_SHA256"
    end
  end

  def install
    bin.install "flok"
  end

  def caveats
    <<~EOS
      flok CLI is installed. You also need the Flok.app for window management:
        Download from: https://github.com/mad01/flok/releases

      After installing Flok.app:
        1. Grant Accessibility permission in System Settings
        2. Launch Flok.app (it runs in the menu bar)
        3. Use 'flok group create Dev --apps "Safari,kitty"' to create groups
    EOS
  end

  test do
    assert_match "flok", shell_output("#{bin}/flok version")
  end
end
