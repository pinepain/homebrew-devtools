require Formula['php71'].path.parent.parent + "Abstract/abstract-php-extension"

class Php71V8 < AbstractPhp71Extension
  init
  desc "PHP extension for V8 JavaScript engine"
  homepage "https://github.com/pinepain/php-v8"
  url "https://github.com/pinepain/php-v8/archive/v0.1.4.tar.gz"
  sha256 "9868512f146b1f42c440ba8078736e0b958665b47765814fae65326163220a13"
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
