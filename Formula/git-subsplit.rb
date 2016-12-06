class GitSubsplit < Formula
  desc "Automate and simplify managing read-only git subtree splits"
  homepage "https://github.com/pinepain/git-subsplit" # point to the fork for now
  url "https://github.com/pinepain/git-subsplit/archive/0.1.0.tar.gz"
  sha256 "dbc2f1bbd1d26bf19c0d93d1a28e0b3f396cfaa26b5209ef6477a3a53cefb3f0"
  head "https://github.com/pinepain/git-subsplit.git"

  def install
    bin.install "git-subsplit.sh" => "git-subsplit"

    bash_completion.install "git-subsplit-completion.bash"
  end

  test do
    mkdir "repo" do
      system "git", "init"
      touch "HELLO"
      system "git", "add", "HELLO"
      system "git", "commit", "-m", "testing"
      system "git", "subsplit", "init", "./"

      assert(File.directory?(".subsplit"), "Subsplit directory is not created")
      assert(File.directory?(".subsplit/.git"), "Subsplit directory is not versioned")
      assert(File.exist?(".subsplit/HELLO"), "Subspict directory doesn't contain file from origin repository")
    end
  end
end
