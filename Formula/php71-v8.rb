require Formula['php71'].path.parent.parent + "Abstract/abstract-php-extension"

class Php71V8 < AbstractPhp71Extension
  init
  desc "PHP extension for V8 JavaScript engine"
  homepage "https://github.com/pinepain/php-v8"
  url "https://github.com/pinepain/php-v8/archive/v0.1.5.tar.gz"
  sha256 "a51126ea1453248bf9eec3bc2fe2632e39266b68d0786262edb5a951dbdf328c"
  head "https://github.com/pinepain/php-v8.git"

  depends_on 'v8@6.0'

  bottle do
  end

  def install
    ENV.universal_binary if build.universal?

    v8_prefix=Formula['v8@6.0'].opt_prefix

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-v8=#{v8_prefix}", phpconfig
    system "make"
    prefix.install "modules/v8.so"
    write_config_file if build.with? "config-file"
  end
end
