require Formula['php71'].path.parent.parent + "Abstract/abstract-php-extension"

class Php71V8 < AbstractPhp71Extension
  init
  desc "PHP extension for V8 JavaScript engine"
  homepage "https://github.com/pinepain/php-v8"
  url "https://github.com/pinepain/php-v8/archive/v0.2.0.tar.gz"
  sha256 "7a8f9268e11fde6660ec16ffd16d782fe3740cca57591dbf07303baae9752a47"
  head "https://github.com/pinepain/php-v8.git"

  depends_on 'v8@6.3'

  bottle do
    root_url "https://dl.bintray.com/pinepain/bottles-devtools"
    sha256 "e1c2ec4b508e348e5991da975d604c7dddf1da1620d57cfc96a3551ee7eec59c" => :high_sierra
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
