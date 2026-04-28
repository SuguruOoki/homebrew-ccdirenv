class Ccdirenv < Formula
  desc "direnv-style automatic Claude Code account switching"
  homepage "https://github.com/SuguruOoki/ccdirenv"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/SuguruOoki/ccdirenv/releases/download/v0.3.0/ccdirenv-aarch64-apple-darwin.tar.xz"
      sha256 "20c026c58dc3ad683e83a666cdd046b53d20b9a36f36ff3098b402dd599d4c32"
    end
    if Hardware::CPU.intel?
      url "https://github.com/SuguruOoki/ccdirenv/releases/download/v0.3.0/ccdirenv-x86_64-apple-darwin.tar.xz"
      sha256 "691c1cbde66633657fa4bf3957723f58ed1a815fa6394cc166f9c6e5e42384a1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/SuguruOoki/ccdirenv/releases/download/v0.3.0/ccdirenv-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "89a0a9ccd71bee0a35e4c6f9aa12b1bb195ac744cba92ee6e31678efd37b3a96"
    end
    if Hardware::CPU.intel?
      url "https://github.com/SuguruOoki/ccdirenv/releases/download/v0.3.0/ccdirenv-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f4706192b96ce2a11fdbb1f78d5a0755cfe6009ea4fc297016c5729fdca1d4bc"
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
