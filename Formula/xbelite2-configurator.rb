class Xbelite2Configurator < Formula
  desc "Remap Xbox Elite Series 2 paddles, buttons and profile colors"
  homepage "https://github.com/jamesboehmer/xbelite2-configurator"
  url "https://github.com/jamesboehmer/xbelite2-configurator/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "39d70fb1e67ae0bd8bbc7061657c15be8d03a25b0a7405455f29bcb35126d57f"
  license "MIT"
  head "https://github.com/jamesboehmer/xbelite2-configurator.git", branch: "main"

  depends_on "go" => :build
  depends_on "pkgconf" => :build
  depends_on "libusb"

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=v#{version}")
  end

  def caveats
    <<~EOS
      Connect the controller with a USB data cable, then run:
        sudo #{opt_bin}/xbelite2-configurator
      Root is needed to detach the operating system's controller driver.
    EOS
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/xbelite2-configurator -version")
  end
end
