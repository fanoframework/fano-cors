# Fano Web Framework CORS Example Application

Example web application skeleton using Fano Framework, Pascal web application framework which demostrate how to handle Cross-Origin Resource Sharing (CORS) request.

This project is generated using [Fano CLI](https://github.com/fanoframework/fano-cli)
command line tools to help scaffolding web application using Fano Framework.

## Requirement

- [Free Pascal](https://www.freepascal.org/) >= 3.0
- Web Server (Apache, nginx)
- [Fano Web Framework](https://github.com/fanoframework/fano)

## TLDR

```
$ git clone git@github.com:fanoframework/fano-cors.git --recursive
$ cd fano-cors && ./tools/config.setup.sh
$ ./build.sh
```
Setup virtual host as described in Run with a webserver section below.

## Free Pascal installation

Make sure [Free Pascal](https://www.freepascal.org/) is installed. Run

    $ fpc -i

If you see something like `Free Pascal Compiler version 3.0.4`,  you are good to go.

## Clone this repository

    $ git clone git@github.com:fanofamework/fano-cors.git --recursive

`--recursive` is needed so git also pull [Fano](https://github.com/fanoframework/fano) repository.

If you are missing `--recursive` when you clone, you may find that `vendor/fano` directory is empty. In this case run

    $ git submodule update --init

## Setup required configuration

Run

    $ ./tools/config.setup.sh

## Build application

Run

    $ ./build.sh

By default, it will output binary executable in `bin` directory.

To build for different environment, set `BUILD_TYPE` environment variable.

### Build for production environment

    $ BUILD_TYPE=prod ./build.sh

Build process will use compiler configuration defined in `vendor/fano/fano.cfg`, `build.cfg` and `build.prod.cfg`. By default, `build.prod.cfg` contains some compiler switches that will aggressively optimize executable both in speed and size.

### Build for development environment

    $ BUILD_TYPE=dev ./build.sh

Build process will use compiler configuration defined in `vendor/fano/fano.cfg`, `build.cfg` and `build.dev.cfg`.

If `BUILD_TYPE` environment variable is not set, production environment will be assumed.

## Run

### Run with a webserver

Setup a virtual host. Please consult documentation of web server you use.

This example project is a SCGI web application. You may want to read [Deployment as SCGI application](https://fanoframework.github.io/deployment/scgi/) for more information on how to setup virtual host to deploy SCGI web application.

## Deployment

You need to deploy only executable binary and any supporting files such as HTML templates, images, css stylesheets, application config.
Any `pas` or `inc` files or shell scripts is not needed in deployment machine in order application to run.

So for this repository, you will need to copy `public`, `Templates`, `config`
and `storages` directories to your deployment machine. make sure that
`storages` directory is writable by web server.

## Testing CORS feature

Create a simple web page to call our API via ajax, for example

```
<html>
<head><title>CORS Test</title></head>
<body>
    <div id="content"></div>
    <button id="btnLoad">Load</button>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script>
        $(document).ready(function(){
            $('#btnLoad').click(function(){
                $.ajax({
                    url: "http://fano-cors.fano/",
                    headers: { 'x-my-custom-header': 'some value' }
                }).then(function(resp){
                    $('#content').text(resp.hello);
                });
            });
        });
    </script>
</body>
</html>
```
Save code above as `client.html` in your web server document root. It is assumed that our application is at `http://fano-cors.fano/`.

Open browser and go to `http://localhost/client.html`, click `Load` button
to execute ajax request to our API.

Because of different domain, CORS restriction will apply for AJAX request executed in `client.html`.

## Known Issues

### Issue with GNU Linker

When running `build.sh` script, you may encounter following warning:

```
/usr/bin/ld: warning: public/link.res contains output sections; did you forget -T?
```

This is known issue between Free Pascal and GNU Linker. See
[FAQ: link.res syntax error, or "did you forget -T?"](https://www.freepascal.org/faq.var#unix-ld219)

However, this warning is minor and can be ignored. It does not affect output executable.

### Issue with unsynchronized compiled unit with unit source

Sometime Free Pascal can not compile your code because, for example, you deleted a
unit source code (.pas) but old generated unit (.ppu, .o, .a files) still there
or when you switch between git branches. Solution is to remove those files.

Run `tools/clean.sh` to remove all compiled binaries generated during compilation.

```
$ ./tools/clean.sh
```

### Windows user

Free Pascal supports Windows as target operating system, however, this repository is not yet tested on Windows. To target Windows, in `build.cfg` replace
compiler switch `-Tlinux` with `-Twin64` and uncomment line `#-WC` to
become `-WC`.

### Lazarus user

While you can use Lazarus IDE, it is not mandatory tool. Any text editor for code editing (Atom, Visual Studio Code, Sublime, Vim etc) should suffice.
