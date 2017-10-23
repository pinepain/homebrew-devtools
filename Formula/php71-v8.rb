require Formula['php71'].path.parent.parent + "Abstract/abstract-php-extension"

class Php71V8 < AbstractPhp71Extension
  init
  desc "PHP extension for V8 JavaScript engine"
  homepage "https://github.com/pinepain/php-v8"
  url "https://github.com/pinepain/php-v8/archive/v0.2.1.tar.gz"
  sha256 "b06b8b266c753ebc9c41f59f86474bb9b90eeb711da6d2abc7a47e7ba5f57f0b"
  head "https://github.com/pinepain/php-v8.git"

  depends_on 'v8@6.4'

  bottle do
    root_url "https://dl.bintray.com/pinepain/bottles-devtools"
    sha256 "e194e554f28a94f665c4ec1ee68989312b72e95db82605ea46431aed554125a4" => :high_sierra
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
