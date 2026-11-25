class Apeiron < Formula
  desc "Backups, sync, versions and archives in one engine"
  homepage "https://github.com/efe-clk/apeiron"
  url "https://github.com/efe-clk/apeiron/archive/refs/tags/v0.14.0.tar.gz"
  sha256 "330969c49c8ad8a59b3158e8a444fe26bf0f76e1984cd10a09607e027a22cb86"
  license any_of: ["MIT", "Apache-2.0"]

  depends_on "cmake" => :build
  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/apeiron-cli")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/apeiron --version")
    system bin/"apeiron", "init", testpath/"repo"
    (testpath/"src/a.txt").write "hello"
    system bin/"ape", "--repo", testpath/"repo", "backup", testpath/"src"
    system bin/"apeiron", "--repo", testpath/"repo", "verify"
  end
end
