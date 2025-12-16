class GitAdr < Formula
  desc "Architecture Decision Records management using git notes"
  homepage "https://github.com/zircote/git-adr"
  license "MIT"
  version "0.2.0"

  on_macos do
    on_arm do
      url "https://github.com/zircote/git-adr/releases/download/v0.2.0/git-adr-macos-arm64.tar.gz"
      sha256 "f060671b215ace159bce356bb4709bbed3bec07817a7d242306c9532be2c5f06"
    end

    on_intel do
      # Intel Macs: No binary available, Homebrew will fail
      # Use: pip install git-adr
      odie "Pre-built binaries not available for Intel Macs. Use: pip install 'git-adr[all]'"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/zircote/git-adr/releases/download/v0.2.0/git-adr-linux-x86_64.tar.gz"
      sha256 "7f9a30e1e718049fb154c7bf182a6a52df997592cbc609b1f4851f70156f939b"
    end
  end

  def install
    # PyInstaller onedir mode: binary + _internal directory must stay together
    if OS.mac? && Hardware::CPU.arm?
      libexec.install "git-adr-macos-arm64/git-adr"
      libexec.install "git-adr-macos-arm64/_internal"
    elsif OS.linux? && Hardware::CPU.intel?
      libexec.install "git-adr-linux-x86_64/git-adr"
      libexec.install "git-adr-linux-x86_64/_internal"
    end
    bin.install_symlink libexec/"git-adr"
  end

  def caveats
    <<~EOS
      To use git-adr as a git subcommand, add this alias:
        git config --global alias.adr '!git-adr'

      Then you can use: git adr <command>
    EOS
  end

  test do
    system bin/"git-adr", "--version"
  end
end
