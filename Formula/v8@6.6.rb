# Track Chrome stable.
# https://omahaproxy.appspot.com/
class V8AT66 < Formula
  desc "Google's JavaScript engine"
  homepage "https://github.com/v8/v8/wiki"
  url "https://github.com/v8/v8/archive/6.6.275.tar.gz"
  sha256 "746d63306347eeb438091d06a90d7caed7ad231f678044b4cc56f72a32c2de49"

  bottle do
    root_url ""
    cellar :any
    sha256 "a8824063678ad9f4c82debd6eb32acb5d86d639a1a8e601f6471b4f30564be53" => :high_sierra
  end

  keg_only "Provided V8 formula is co-installable and it is not installed in the library path."

  # not building on Yosemite
  # https://bugs.chromium.org/p/chromium/issues/detail?id=620127
  depends_on :macos => :high_sierra

  # depot_tools/GN require Python 2.7+
  depends_on "python" => :build

  needs :cxx14

  resource "depot_tools" do
    url "https://chromium.googlesource.com/chromium/tools/depot_tools.git",
        :revision => "64e33cba179461490f51e7f1fed2caecdc097014"
  end

  def install
    (buildpath/"depot_tools").install resource("depot_tools")
    ENV.prepend_path "PATH", buildpath/"depot_tools"

    # This env variable used by gclient to prevent depot_tools to update depot_tools on every call
    # see https://www.chromium.org/developers/how-tos/depottools#TOC-Disabling-auto-update
    ENV["DEPOT_TOOLS_UPDATE"] = "0"

    repo_cache = HOMEBREW_CACHE/"#{name}--v8--gclient/"
    repo_cache.mkpath

    # Configure build
    gn_args = {
        is_debug: false,
        is_official_build: true,
        is_component_build: true,
        use_allocator_shim: false,
        v8_use_external_startup_data: false,
        treat_warnings_as_errors: false
    }

    v8_version = version
    arch = MacOS.prefer_64_bit? ? "x64" : "x86"
    output_name = "#{arch}.release"
    output_path = "out.gn/#{output_name}"

    gn_command = "gn gen #{output_path} --args=\"#{gn_args.map { |k, v| "#{k}=#{v}" }.join(' ')}\""
    gn_command_show_args = "gn args #{output_path} --list"
    gn_command_show_args_store = "#{gn_command_show_args} > #{output_path}/gn_args.txt"

    cd repo_cache do
      system "gclient", "root"
      system "gclient", "config", "--spec", <<-EOS.undent
        solutions = [
          {
            "url": "https://chromium.googlesource.com/v8/v8.git",
            "managed": False,
            "name": "v8",
            "deps_file": "DEPS",
            "custom_deps": {},
          },
        ]
        target_os = [ "mac" ]
        target_os_only = True
      EOS

      if ENV["CI"] then
        system "gclient", "sync", "--no-history", "--reset", "-j #{Hardware::CPU.cores}", "-r", v8_version
      else
        system "gclient", "sync", "-vvv", "--reset", "-j #{Hardware::CPU.cores}", "-r", v8_version
      end

      cd "v8" do
        system gn_command
        system gn_command_show_args_store

        unless ENV["CI"] then
          system gn_command_show_args
        end

        system "ninja", "-j #{Hardware::CPU.cores}", "-v", "-C", output_path, "d8"

        include.install Dir["include/*", "#{output_path}/gn_args.txt"]

        cd output_path do
          lib.install Dir["lib*.dylib", "icudtl.dat", "d8"]
        end
      end
    end
  end

  test do
    test_basic_script = <<~EOS.strip
      print("Hello World!");
    EOS

    test_icu_script = <<~EOS.tr("\n", " ").strip
      var date = new Date(Date.UTC(2012, 11, 20, 3, 0, 0));
      print(new Intl.DateTimeFormat("en-US").format(date));
    EOS

    assert_equal "Hello World!", pipe_output("#{lib}/d8 -e '#{test_basic_script}'").chomp
    assert_match %r{12/\d{2}/2012}, pipe_output("#{lib}/d8 -e '#{test_icu_script}'").chomp
  end
end
