require Formula['php72'].path.parent.parent + "Abstract/abstract-php-extension"

class Php72V8 < AbstractPhp72Extension
  init
  desc "PHP extension for V8 JavaScript engine"
  homepage "https://github.com/pinepain/php-v8"
  url "https://github.com/pinepain/php-v8/archive/v0.2.0.tar.gz"
  sha256 "78b91765d5630e1f354ab0cddc2775e92d7043230ee0809bb23e06c2447b8641"
  head "https://github.com/pinepain/php-v8.git"

  depends_on 'v8@6.3'

  bottle do
  end

  def install
    v8_prefix=Formula['v8@6.2'].opt_prefix

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-v8=#{v8_prefix}", phpconfig
    system "make"
    prefix.install "modules/v8.so"
    write_config_file if build.with? "config-file"
  end
end
