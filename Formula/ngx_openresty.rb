class NgxOpenresty < Formula
  desc "The OpenResty platform for nginx"
  homepage "https://openresty.org/"
  url "https://openresty.org/download/ngx_openresty-1.9.7.2.tar.gz"
  version "1.9.7.2"
  sha256 "3a202e6f6898614dfa2c0fa8a565762ac790fa0b572e259e23b246b31a896fb9"

  option "without-luarocks", "luarocks will not be installed"

  depends_on "pcre"
  depends_on "openssl"

  resource "luarocks" do
    url "http://keplerproject.github.io/luarocks/releases/luarocks-2.3.0.tar.gz"
    sha256 "68e38feeb66052e29ad1935a71b875194ed8b9c67c2223af5f4d4e3e2464ed97"
  end

  resource "lua-resty-http" do
    url "https://github.com/pintsized/lua-resty-http/archive/v0.07.tar.gz"
    sha256 "1c6aa06c9955397c94e9c3e0c0fba4e2704e85bee77b4512fb54ae7c25d58d86"
  end

  resource "lua-resty-session" do
    url "https://github.com/bungle/lua-resty-session/archive/v2.3.tar.gz"
    sha256 "17c0d7b201aed607de1363160c3fcf6372a1882e21957016a8aede39f1d44a17"
  end

  resource "lua-resty-openidc" do
    url "https://github.com/pingidentity/lua-resty-openidc.git", :using => :git
  end

  skip_clean("nginx/logs")

  def install
    system "./configure", '--with-cc-opt=-I/usr/local/opt/openssl/include/ -I/usr/local/opt/pcre/include/',
                          '--with-ld-opt=-L/usr/local/opt/openssl/lib/ -L/usr/local/opt/pcre/lib/',
                          "--prefix=#{prefix}"
    system "make", "install"

    if build.with? "luarocks"
      resource("luarocks").stage buildpath/"luarocks_install"
      cd buildpath/"luarocks_install" do
        system "./configure", "--prefix=#{prefix}/luajit",
                              "--with-lua=#{prefix}/luajit/",
                              "--lua-suffix=jit",
                              "--with-lua-include=#{prefix}/luajit/include/luajit-2.1"
        system "make", "build"
        system "make", "install"
      end

      resource("lua-resty-http").stage buildpath/"lua-resty-http_install"
      cd buildpath/"lua-resty-http_install" do
        system "#{prefix}/luajit/bin/luarocks", "make", "lua-resty-http-0.07-0.rockspec"
      end

      resource("lua-resty-session").stage buildpath/"lua-resty-session_install"
      cd buildpath/"lua-resty-session_install" do
        system "#{prefix}/luajit/bin/luarocks", "make", "lua-resty-session-dev-1.rockspec"
      end

      resource("lua-resty-openidc").stage buildpath/"lua-resty-openidc_install"
      cd buildpath/"lua-resty-openidc_install" do
        (prefix/"lualib/resty").install Dir["lib/resty/*.lua"]
      end
    end
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test ngx_openresty`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "#{prefix}/nginx/sbin/nginx", '-V'
  end
end
