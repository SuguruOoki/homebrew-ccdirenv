class Ccdirenv < Formula
  desc "direnv-style automatic Claude Code account switching"
  homepage "https://github.com/SuguruOoki/ccdirenv"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/SuguruOoki/ccdirenv/releases/download/v0.3.1/ccdirenv-aarch64-apple-darwin.tar.xz"
      sha256 "7afdba05ce7269f4d7faa70cb9b65174ddebf029488a904c0645ded40a45c0f7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/SuguruOoki/ccdirenv/releases/download/v0.3.1/ccdirenv-x86_64-apple-darwin.tar.xz"
      sha256 "b4e11a3c78b23caef14a51f9e224f382d59cddf2a0f2825615564ad0badfc439"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/SuguruOoki/ccdirenv/releases/download/v0.3.1/ccdirenv-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bb09eb3ff11ba3db3a419134d24f44ff743ebe4b12e8ae084e9d39e35d0673d9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/SuguruOoki/ccdirenv/releases/download/v0.3.1/ccdirenv-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5defcc945280548324eccd75a9b31d9063d85304c045e8ae62e8a591f6de3543"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-unknown-linux-gnu": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "ccdirenv"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "ccdirenv"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "ccdirenv"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "ccdirenv"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
