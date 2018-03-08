require Formula['php'].path.parent.parent.parent + "homebrew-php/Abstract/abstract-php-extension"

class Php72Ref < AbstractPhpExtension
  init
  desc "Soft and Weak references support for PHP"
  homepage "https://github.com/pinepain/php-ref"
  url "https://github.com/pinepain/php-ref/archive/v0.6.0.tar.gz"
  sha256 "747b2b4d73334406c6c5a04dd70eb138c347a9c31be370c118b13fd56b6fcc70"
  head "https://github.com/pinepain/php-ref.git"

  bottle do
    root_url "https://dl.bintray.com/pinepain/bottles-devtools"
    cellar :any_skip_relocation
    sha256 "dacc268920f15e75400109cad87643552f2254b4ed28ec0534d8f6044da0fdfb" => :high_sierra
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig

    system "make"
    prefix.install "modules/ref.so"
    write_config_file if build.with? "config-file"
  end
end
