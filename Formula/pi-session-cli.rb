class PiSessionCli < Formula
  desc "Headless Pi Session Manager server with embedded web UI"
  homepage "https://github.com/Dwsy/pi-session-manager"
  url "https://github.com/Dwsy/pi-session-manager/archive/refs/tags/v0.4.5.tar.gz"
  sha256 "f4c677e87345ec856e50a347806f099ad87d23c14c3d1b18e683fb4e4aca4522"
  license "MIT"

  depends_on "node" => :build
  depends_on "rust" => :build

  def install
    ENV["npm_config_yes"] = "true"

    system "npm", "ci"
    system "npm", "run", "build"
    system "cargo", "build", "--release", "-p", "pi-session-cli"

    bin.install "target/release/pi-session-cli"
  end

  def caveats
    <<~EOS
      Start server:
        pi-session-cli

      Then open:
        http://127.0.0.1:52131

      Config file (optional):
        macOS: ~/Library/Application Support/pi-session-manager.json
        Linux: ~/.config/pi-session-manager.json
    EOS
  end

  test do
    ENV["HOME"] = testpath
    (testpath/"Library/Application Support").mkpath
    (testpath/".config").mkpath

    (testpath/"Library/Application Support/pi-session-manager.json").write <<~JSON
      {"http_enabled":false}
    JSON
    (testpath/".config/pi-session-manager.json").write <<~JSON
      {"http_enabled":false}
    JSON

    output = shell_output("#{bin}/pi-session-cli 2>&1")
    assert_match "HTTP server is disabled", output
  end
end
