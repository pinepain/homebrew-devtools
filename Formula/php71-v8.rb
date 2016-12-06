require Formula['php71'].path.parent.parent + "Abstract/abstract-php-extension"

class Php71V8 < AbstractPhp71Extension
  init
  desc "PHP extension for V8-5.7.92 JavaScript engine"
  homepage "https://github.com/pinepain/php-v8"
  url "https://github.com/pinepain/php-v8/archive/v0.1.0.tar.gz"
  sha256 "b203da5b7fc72ef0cd71af26b409e2a1977c7e9a1c48648b33882c325ab755a3"
  head "https://github.com/pinepain/php-v8.git"

  depends_on 'v8@5.7'

  bottle do
  end

  def install
    ENV.universal_binary if build.universal?

    v8_prefix=Formula['v8@5.7'].opt_prefix

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-v8=#{v8_prefix}", phpconfig
    system "make"
    prefix.install "modules/v8.so"
    write_config_file if build.with? "config-file"
  end
end
