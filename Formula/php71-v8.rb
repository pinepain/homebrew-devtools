require Formula['php71'].path.parent.parent + "Abstract/abstract-php-extension"

class Php71V8 < AbstractPhp71Extension
  init
  desc "PHP extension for V8 JavaScript engine"
  homepage "https://github.com/pinepain/php-v8"
  url "https://github.com/pinepain/php-v8/archive/v0.1.3.tar.gz"
  sha256 "17901de8a563e3f99e66564a69768c2cdddc4341f2da8a76014396dee74af4a5"
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
