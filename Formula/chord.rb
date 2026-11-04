class Chord < Formula
  desc "AI coding assistant with multi-agent orchestration"
  homepage "https://github.com/keakon/chord"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/keakon/chord/releases/download/v0.8.3/chord-v0.8.3-darwin-arm64.tar.gz"
      sha256 "68616f159786144b6d31d5eff8d2588348e107ce49d8fdc69be4419c7d87f43e"
    end
    on_intel do
      url "https://github.com/keakon/chord/releases/download/v0.8.3/chord-v0.8.3-darwin-amd64.tar.gz"
      sha256 "342db17a819fb0bcb1b34585b99b7751181bcac95aa55c47321cafe72a825dff"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/keakon/chord/releases/download/v0.8.3/chord-v0.8.3-linux-arm64.tar.gz"
      sha256 "f7e519e5f271a0aaaeefa5cc432b02c972d85739a33a8fb4129386a98d589670"
    end
    on_intel do
      url "https://github.com/keakon/chord/releases/download/v0.8.3/chord-v0.8.3-linux-amd64.tar.gz"
      sha256 "31b0959c5f276b94ef5e8e02b454766ab65706565e7992473e6c14e4102f3eb6"
    end
  end

  def install
    bin.install "chord"
    generate_completions_from_executable(bin/"chord", "completion")
  end

  test do
    assert_match(/^chord version v#{Regexp.escape(version.to_s)}(?: [0-9a-f]+)?$/,
                 shell_output("#{bin}/chord --version"))
    assert_match "headless", shell_output("#{bin}/chord --help")
    assert_match "complete -o", shell_output("#{bin}/chord completion bash")
    assert_match "session id or --session-dir is required",
                 shell_output("#{bin}/chord sessions project 2>&1", 1)
  end
end
