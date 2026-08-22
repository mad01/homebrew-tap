class TossBin < Formula
  desc "Safe rm replacement for macOS that trashes to dated ~/.Trash folders"
  homepage "https://github.com/mad01/thismoon"
  url "https://github.com/mad01/thismoon/releases/download/toss-bin/v1.3.0/toss-bin_v1.3.0_darwin_arm64.tar.gz"
  version "1.3.0"
  sha256 "dec041578bef597059ccd9f93b3e999ea8bf5ed2e92f6f495d9222923fcadebd"
  license "BSD-3-Clause"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "toss-bin"
  end

  def caveats
    <<~EOS
      Files go to ~/.Trash/my-trash/YYYY-MM-DD/ instead of being deleted.
      Add machine-local protected paths (optional):
        mkdir -p ~/.config/toss-bin
        printf 'protected_trees:\n  - ~/code/archive\n' > ~/.config/toss-bin/config.yaml

      Optional shell wrapper, add to ~/.zshrc to route rm through the trash:
        rm() {
          if command -v toss-bin >/dev/null 2>&1; then
            toss-bin --safe-mode "$@"
          else
            command rm "$@"
          fi
        }
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/toss-bin --version")
  end
end
