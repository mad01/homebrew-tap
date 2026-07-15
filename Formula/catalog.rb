class Catalog < Formula
  desc "Service catalog built from service-info.yaml files across your repos"
  homepage "https://github.com/mad01/thismoon"
  url "https://github.com/mad01/thismoon/releases/download/catalog/v0.2.0/catalog_v0.2.0_darwin_arm64.tar.gz"
  version "0.2.0"
  sha256 "f5aafb8b8ff13590b6de2eb2f421e199081b43a11b4469f5647e13ab62507bb6"
  license "BSD-3-Clause"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "catalog"
  end

  service do
    run [opt_bin/"catalog", "web"]
    keep_alive true
    log_path var/"log/catalog.log"
    error_log_path var/"log/catalog.log"
  end

  def caveats
    <<~EOS
      Start the web UI (http://127.0.0.1:7575) as a background service:
        brew services start mad01/tap/catalog
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/catalog version")
  end
end
