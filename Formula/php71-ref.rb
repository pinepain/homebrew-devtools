require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Ref < AbstractPhp71Extension
  init
  desc "Soft and Weak references support for PHP"
  homepage "https://github.com/pinepain/php-ref"
  url "https://github.com/pinepain/php-ref/archive/v0.4.4.tar.gz"
  sha256 "51da1e0625e2c89da05bdef5166e1046f5594870df4b0f6925eaa01b69925a9b"
  head "https://github.com/pinepain/php-ref.git"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig

    system "make"
    prefix.install "modules/ref.so"
    write_config_file if build.with? "config-file"
  end
end
