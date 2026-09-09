class Ccdirenv < Formula
  desc "direnv-style automatic Claude Code and Codex CLI account switching"
  homepage "https://github.com/SuguruOoki/ccdirenv"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/SuguruOoki/ccdirenv/releases/download/v0.4.0/ccdirenv-aarch64-apple-darwin.tar.xz"
      sha256 "215104adc6636ab2b77cd0c886be6c089844d2709140c4c6fa93110ae3e17689"
    end
    if Hardware::CPU.intel?
      url "https://github.com/SuguruOoki/ccdirenv/releases/download/v0.4.0/ccdirenv-x86_64-apple-darwin.tar.xz"
      sha256 "d000c0d82220460d97336b49c380eb72bda6f3ad1be536e55d4f9207db3719c9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/SuguruOoki/ccdirenv/releases/download/v0.4.0/ccdirenv-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "47f58e8d10f7c507e7cb88714867c6e5fb4a696c2eeb92b186fb5dc9d3d1c8dd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/SuguruOoki/ccdirenv/releases/download/v0.4.0/ccdirenv-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "923176f0b4e384ca2cc03397e91b582bcc84af71126ad799480034afe6ccc40e"
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
