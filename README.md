tumblrthegame
=============

TUMBLR. THE GAME.

=============

## Quick Start

Install Node.js (http://nodejs.org/download/)
and install ruby and ruby gems. (If Windows: https://forwardhq.com/support/installing-ruby-windows)

```sh
$ git clone git://github.com/metermaid/tumblrthegame
$ cd tumblrthegame
$ sudo npm install -g gulp karma bower
$ npm install
$ bower install
$ gem install sass
$ gulp

```

Open up `http://localhost:9018/` if you want the Karma tests to run automatically.

If you want to run protractor tasks, you'll have to use `gulp protractor`. Sorry for the inconvenience. :P

Finally, open `file:///path/to/tumblrthegame/build/index.html` in your browser.