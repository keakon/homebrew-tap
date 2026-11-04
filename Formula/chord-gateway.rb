class ChordGateway < Formula
  desc "IM gateway connecting WeChat, Feishu, and other IM platforms to Chord"
  homepage "https://github.com/keakon/chord-gateway"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/keakon/chord-gateway/releases/download/v0.3.4/chord-gateway-v0.3.4-darwin-arm64.tar.gz"
      sha256 "f4fb51c424b2c0f7691ccf4e5b887eb9fc13d19e8c1417fd78577068cd81f5a1"
    end
    on_intel do
      url "https://github.com/keakon/chord-gateway/releases/download/v0.3.4/chord-gateway-v0.3.4-darwin-amd64.tar.gz"
      sha256 "ae88ea5dfe9e3ad8e1cee9e3cfa3fa615fffc48ab1a500e56ce5a737cf4ad8d6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/keakon/chord-gateway/releases/download/v0.3.4/chord-gateway-v0.3.4-linux-arm64.tar.gz"
      sha256 "02a309ccbb38d485ec4b9fb8aff415b78a98560a751560792b620e439acf1584"
    end
    on_intel do
      url "https://github.com/keakon/chord-gateway/releases/download/v0.3.4/chord-gateway-v0.3.4-linux-amd64.tar.gz"
      sha256 "f6d7f6c1007908995c56f193c43889d177f0e29260b84b22d20cd2241698dc57"
    end
  end

  def install
    bin.install "chord-gateway"
    generate_completions_from_executable(bin/"chord-gateway", "completion")
  end

  test do
    # v0.3.4 archives were built without an explicit Dirty stamp and report a
    # trailing `*` from VCS metadata; later releases stamp Dirty=false.
    assert_match(/^chord-gateway version v#{Regexp.escape(version.to_s)}\*?(?: [0-9a-f]+)?$/,
                 shell_output("#{bin}/chord-gateway --version"))
    assert_match "remote control plane", shell_output("#{bin}/chord-gateway --help")
    assert_match "complete -o", shell_output("#{bin}/chord-gateway completion bash")
  end
end
