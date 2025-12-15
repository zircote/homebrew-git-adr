class GitAdr < Formula
  include Language::Python::Virtualenv

  desc "Manage Architecture Decision Records using git notes"
  homepage "https://github.com/zircote/git-adr"
  url "https://files.pythonhosted.org/packages/source/g/git-adr/git_adr-0.1.0.tar.gz"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  license "MIT"
  head "https://github.com/zircote/git-adr.git", branch: "main"

  depends_on "libyaml"
  depends_on "python@3.12"

  resource "typer" do
    url "https://files.pythonhosted.org/packages/8f/28/7c85c8032b91dbe79725b6f17d2fffc595dff06a35c7a30a37bef73a1ab4/typer-0.20.0.tar.gz"
    sha256 "1aaf6494031793e4876fb0bacfa6a912b551cf43c1e63c800df8b1a866720c37"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/fb/d2/8920e102050a0de7bfabeb4c4614a49248cf8d5d7a8d01885fbb24dc767a/rich-14.2.0.tar.gz"
    sha256 "73ff50c7c0c1c77c8243079283f4edb376f0f6442433aecb8ce7e6d0b92d1fe4"
  end

  resource "python-frontmatter" do
    url "https://files.pythonhosted.org/packages/96/de/910fa208120314a12f9a88ea63e03707261692af782c99283f1a2c8a5e6f/python-frontmatter-1.1.0.tar.gz"
    sha256 "7118d2bd56af9149625745c58c9b51fb67e8d1294a0c76796dafdc72c36e5f6d"
  end

  resource "mistune" do
    url "https://files.pythonhosted.org/packages/d7/02/a7fb8b21d4d55ac93cdcde9d3638da5dd0ebdd3a4fed76c7725e10b81cbe/mistune-3.1.4.tar.gz"
    sha256 "b5a7f801d389f724ec702840c11d8fc48f2b33519102fc7ee739e8177b672164"
  end

  resource "pyyaml" do
    url "https://files.pythonhosted.org/packages/05/8e/961c0007c59b8dd7729d542c61a4d537767a59645b82a0b521206e1e25c2/pyyaml-6.0.3.tar.gz"
    sha256 "d76623373421df22fb4cf8817020cbb7ef15c725b9d5e45f17e189bfc384190f"
  end

  # Transitive dependencies for typer
  resource "click" do
    url "https://files.pythonhosted.org/packages/b9/2e/0090cbf739cee7d23781ad4b89a9894a41538e4fcf4c31dcdd705b78eb8b/click-8.1.8.tar.gz"
    sha256 "ed53c9d8990d83c2a27deae68e4ee337473f6330c040a31d4225c9574d16096a"
  end

  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/df/db/f35a00659bc03fec321ba8bce9420de607a1d37f8342eee1863174c69557/typing_extensions-4.12.2.tar.gz"
    sha256 "1a7ead55c7e559dd4dee8856e3a88b41225abfe1ce8df57b7c13915fe121ffb8"
  end

  # Transitive dependencies for rich
  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/38/71/3b932df36c1a044d397a1f92d1cf91ee0a503d91e470cbd670aa66b07571/markdown-it-py-3.0.0.tar.gz"
    sha256 "e3f60a94fa066dc52ec76661e37c851cb232d92f9886b15cb560aaada2df8feb"
  end

  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/d6/54/cfe61301667036ec958cb99bd3ead613a44f1c43a9b10700e397e96cd812/mdurl-0.1.2.tar.gz"
    sha256 "bb413d29f5eea38f31dd4754dd7377d4465116fb207585f97bf925588687c1ba"
  end

  resource "pygments" do
    url "https://files.pythonhosted.org/packages/7c/2d/c3338d48ea6cc0feb8446d8e6937e1408088a72a39937982cc6111d17f84/pygments-2.19.1.tar.gz"
    sha256 "61c16d2a8576dc0649d9f39e089b5f02bcd27fba10d8fb4dcc28173f7a45151f"
  end

  def install
    virtualenv_install_with_resources

    # Generate and install shell completions
    generate_completions_from_executable(bin/"git-adr", "completion", shells: [:bash, :zsh, :fish])

    # Install man pages if they exist in the distribution
    man1.install Dir["share/man/man1/*.1"] if Dir.exist?("share/man/man1")
  end

  def caveats
    <<~EOS
      To use git-adr as a git subcommand, add a git alias:

        git config --global alias.adr '!git-adr'

      Then you can use: git adr new "My Decision"

      For shell completion, you may need to restart your shell or run:
        source #{bash_completion}/git-adr (bash)
        source #{zsh_completion}/_git-adr (zsh)
    EOS
  end

  test do
    assert_match "git-adr", shell_output("#{bin}/git-adr --version")
    assert_match "Usage:", shell_output("#{bin}/git-adr --help")

    # Test basic command structure
    system bin/"git-adr", "--help"
  end
end
