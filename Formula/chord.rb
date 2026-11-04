class Chord < Formula
  desc "AI coding assistant with multi-agent orchestration"
  homepage "https://github.com/keakon/chord"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/keakon/chord/releases/download/v0.8.2/chord-v0.8.2-darwin-arm64.tar.gz"
      sha256 "940eaed07697f43110009df12a049a1d7cb714c353dfd7a9e9a4926bb4514f5b"
    end
    on_intel do
      url "https://github.com/keakon/chord/releases/download/v0.8.2/chord-v0.8.2-darwin-amd64.tar.gz"
      sha256 "94d2f85e0035f9af671562f9c0f3bb719fdc56cab2ddb22e3c650781890e0a92"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/keakon/chord/releases/download/v0.8.2/chord-v0.8.2-linux-arm64.tar.gz"
      sha256 "7632f912dc19a13b79e7b3776f0da6dbc8948402758ed10f83a595c81cd82aa7"
    end
    on_intel do
      url "https://github.com/keakon/chord/releases/download/v0.8.2/chord-v0.8.2-linux-amd64.tar.gz"
      sha256 "18c63d55eb42da9b6982d097a85eb7e3dffe038b081919acbe6b68ca2614b04c"
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
