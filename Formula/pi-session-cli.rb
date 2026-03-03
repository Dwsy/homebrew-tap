class PiSessionCli < Formula
  desc "Headless Pi Session Manager server with embedded web UI"
  homepage "https://github.com/Dwsy/pi-session-manager"
  version "0.4.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Dwsy/pi-session-manager/releases/download/v#{version}/pi-session-cli-macos-arm64.tar.gz"
      sha256 "27d023d0f39c1a4ceff065136abe466468ee706d01ca250097e7b3e0886be6d5"

      def install
        bin.install "pi-session-cli-macos-arm64" => "pi-session-cli"
      end
    else
      url "https://github.com/Dwsy/pi-session-manager/releases/download/v#{version}/pi-session-cli-macos-x64.tar.gz"
      sha256 "2b2623291e7b586c24f0998b2924abb5fa424996ca4eaafeaf723719418e728a"

      def install
        bin.install "pi-session-cli-macos-x64" => "pi-session-cli"
      end
    end
  end

  on_linux do
    url "https://github.com/Dwsy/pi-session-manager/releases/download/v#{version}/pi-session-cli-linux-x64.tar.gz"
    sha256 "52f24a70423e8210e47ca8874e00673cf76b576ad78c4b9646bc1a4b01f71f44"

    def install
      bin.install "pi-session-cli-linux-x64" => "pi-session-cli"
    end
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
    assert_predicate bin/"pi-session-cli", :exist?
  end
end
