require Formula['php70'].path.parent.parent + "Abstract/abstract-php-extension"

class Php70V8 < AbstractPhp71Extension
  init
  desc "PHP extension for V8 JavaScript engine"
  homepage "https://github.com/pinepain/php-v8"
  url "https://github.com/pinepain/php-v8/archive/v0.1.8.tar.gz"
  sha256 "aa5480e72d750b367d82a48396caeadfdf7c3dd4a3e4c504d95a84bea49d35a3"
  head "https://github.com/pinepain/php-v8.git"

  depends_on 'v8@6.1'

  bottle do
  end

  def install
    v8_prefix=Formula['v8@6.1'].opt_prefix

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-v8=#{v8_prefix}", phpconfig
    system "make"
    prefix.install "modules/v8.so"
    write_config_file if build.with? "config-file"
  end
end
