class Ccdirenv < Formula
  desc "direnv-style automatic Claude Code account switching"
  homepage "https://github.com/SuguruOoki/ccdirenv"
  version "0.3.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/SuguruOoki/ccdirenv/releases/download/v0.3.2/ccdirenv-aarch64-apple-darwin.tar.xz"
      sha256 "6b99c19cab74c95b76c18996d1d9d0c9651fc565fbce4d029e4765a1ef04b7ab"
    end
    if Hardware::CPU.intel?
      url "https://github.com/SuguruOoki/ccdirenv/releases/download/v0.3.2/ccdirenv-x86_64-apple-darwin.tar.xz"
      sha256 "f25d5bccd5b1decac453cca6eae3bee0e3a2ce8a8763f67b1000593c6b808e10"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/SuguruOoki/ccdirenv/releases/download/v0.3.2/ccdirenv-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9ca0c3ecf8908bdfddf825d6d90469a43ba5db8306d27f4182f97fb325986821"
    end
    if Hardware::CPU.intel?
      url "https://github.com/SuguruOoki/ccdirenv/releases/download/v0.3.2/ccdirenv-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "441495e5c9e7d835755e75a2d0675d8e0e381bf19c6bae62ed4924bee037842e"
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
