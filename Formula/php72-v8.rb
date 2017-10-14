require Formula['php72'].path.parent.parent + "Abstract/abstract-php-extension"

class Php72V8 < AbstractPhp72Extension
  init
  desc "PHP extension for V8 JavaScript engine"
  homepage "https://github.com/pinepain/php-v8"
  url "https://github.com/pinepain/php-v8/archive/v0.2.0.tar.gz"
  sha256 "7a8f9268e11fde6660ec16ffd16d782fe3740cca57591dbf07303baae9752a47"
  head "https://github.com/pinepain/php-v8.git"

  depends_on 'v8@6.4'

  bottle do
    root_url "https://dl.bintray.com/pinepain/bottles-devtools"
    sha256 "84b1ef0a8503e832b113f7e7d92406373fba98cecb752540125b5742422659b4" => :high_sierra
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
