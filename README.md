# homebrew-oidc
[Homebrew](http://brew.sh/) formula to set up OpenID Connect related tools. This repository
contains a formula to set up [OpenResty](https://openresty.org/). Which is an
[nginx](http://nginx.org/) based platform for building applications. In addition
to installing OpenResty, the formula sets up [LuaRocks](https://luarocks.org/).
The intention is to make it easier to set up [lua-resty-openidc](https://github.com/pingidentity/lua-resty-openidc).
This project makes your nginx instance an [OpenID Connect](http://openid.net/connect/)
Relying Party. As such, it can be set up as a authentication gateway to web applications
sitting behind the nginx instance.

This repo also contains a formula for [MITREid Connect](https://github.com/mitreid-connect).
This is a server  implementation of OpenID Connect. It can be used in conjunction
with the nginx relying party to authenticate requests coming into a web application.

## Usage

You must have Homebrew installed.

```
brew tap mitre/oidc
brew install ngx_openresty
brew install openid-connect-java-spring-server
```

## TODO
* Update the formula to have OpenResty fully set up with lua-resty-openidc
* Describe how to run both servers
* Describe how to register a client with MITREid Connect
* Describe how to configure nginx with the client information so that it can authenticate users
against the MITREid Connect server

## License

Copyright 2016 The MITRE Corporation

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
