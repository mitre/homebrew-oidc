class OpenidConnectJavaSpringServer < Formula
  desc "OpenID Connect server implementation"
  homepage "https://github.com/mitreid-connect/"
  url "https://github.com/mitreid-connect/OpenID-Connect-Java-Spring-Server/archive/mitreid-connect-1.2.5.tar.gz"
  version "1.2.5"
  sha256 "ad8315921a563d838cfada3dab9848f0ff73d0b5cecd9054094208d84d2de0c5"

  depends_on "maven32"

  def install
    prefix.install Dir['*']
    cd prefix
    system "mvn", "clean", "install"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test OpenID-Connect-Java-Spring-Server`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
