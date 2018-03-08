require Formula['php'].path.parent.parent.parent + "homebrew-php/Abstract/abstract-php-extension"

class Php72V8 < AbstractPhp72Extension
  init
  desc "PHP extension for V8 JavaScript engine"
  homepage "https://github.com/pinepain/php-v8"
  url "https://github.com/pinepain/php-v8/archive/v0.2.2.tar.gz"
  sha256 "6c8cf2fa57ba45ccf19b238114cb3b0dec2ad7d8533f5ba6d8a809dd3482eb02"
  head "https://github.com/pinepain/php-v8.git"

  depends_on 'v8@6.6'

  bottle do
    root_url "https://dl.bintray.com/pinepain/bottles-devtools"
    sha256 "7f9051a6cd8226e7bc5b0b0db203901841a2bcae21341fcfe0f91b3364c89c99" => :high_sierra
  end

  def install
    v8_prefix=Formula['v8@6.6'].opt_prefix

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-v8=#{v8_prefix}", phpconfig
    system "make"
    prefix.install "modules/v8.so"
    write_config_file if build.with? "config-file"
  end
end
