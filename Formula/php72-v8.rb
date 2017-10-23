require Formula['php72'].path.parent.parent + "Abstract/abstract-php-extension"

class Php72V8 < AbstractPhp72Extension
  init
  desc "PHP extension for V8 JavaScript engine"
  homepage "https://github.com/pinepain/php-v8"
  url "https://github.com/pinepain/php-v8/archive/v0.2.1.tar.gz"
  sha256 "b06b8b266c753ebc9c41f59f86474bb9b90eeb711da6d2abc7a47e7ba5f57f0b"
  head "https://github.com/pinepain/php-v8.git"

  depends_on 'v8@6.4'

  bottle do
    root_url "https://dl.bintray.com/pinepain/bottles-devtools"
    sha256 "a7ab717d3b8da5c6c17234e364b75887556934d7d6970243db35789071a26c8b" => :high_sierra
  end

  def install
    v8_prefix=Formula['v8@6.4'].opt_prefix

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-v8=#{v8_prefix}", phpconfig
    system "make"
    prefix.install "modules/v8.so"
    write_config_file if build.with? "config-file"
  end
end
