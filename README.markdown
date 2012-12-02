# travis-lite

Travis Lite is a more light-weight interface to the [Travis CI][] continuous integration service. It's meant for users
who for various reasons can't use the JavaScript-heavy main site.

[Travis CI]: http://travis-ci.org

## Features

To begin with, the lite site will implement all of the read-only parts of the main site, as we don't have to deal with
authentication that way. Currently this is implemented:

* List the most recent builds
* List the most recent builds for a repository

The URLs will mostly be the same as for the main Travis site.

## Live Version

There is a version of this app live at <http://travis-lite.herokuapp.com>. Go to [/deployed-sha][] to see what commit
is currently deployed.

[/deployed-sha]: http://travis-lite.herokuapp.com/deployed-sha

## Contributions

Contributions are welcome! If you find a bug, please report it in [the issue tracker][issues]. If you know how to fix
it, or if you can write a failing spec, a pull request would be greatly appreciated.

[issues]: https://github.com/henrikhodne/travis-lite

## License

Copyright © 2012 Henrik Hodne. See the LICENSE file for details.
