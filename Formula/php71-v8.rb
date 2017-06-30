require Formula['php71'].path.parent.parent + "Abstract/abstract-php-extension"

class Php71V8 < AbstractPhp71Extension
  init
  desc "PHP extension for V8 JavaScript engine"
  homepage "https://github.com/pinepain/php-v8"
  url "https://github.com/pinepain/php-v8/archive/v0.1.7.tar.gz"
  sha256 "19f4950bf1c971fb69913a4ef5ae6ee21db65ffa1b58314412b5998ab4b74d32"
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
