# Chaplin / Grunt / Bower / Requirejs / Stylus / Handlebars

Based on https://github.com/mehcode/composition.

> Example application using Chaplin with

- grunt
- bower
- require.js
- almond.js
- stylus
- handlebars

## WARNING

This is not production ready, just a playground to build chaplin apps with grunt.


## Requirements

- [npm](https://npmjs.org/)
- [grunt 4.x](https://github.com/gruntjs/grunt/wiki/Getting-started)

### Installing

Run 'npm install' to install the node dependencies.

### Running the development server
```sh
grunt
```

The development server will compile each amd module into separate files to ease debugging.


### Build for distribution
```sh
grunt build
```

The development task will compile and optimize the app into single files, inside the `build` directory.



### Troubleshooting

### npm

If you get any node errors while running `grunt` tasks, try to remove the `node_modules` directory, run `npm cache clean`
and then `npm install` again to ensure you have the right versions of the modules.


## License
Unless otherwise noted, all files contained within this project are liensed
under the MIT opensource license. See the included file LICENSE or visit
[opensource.org][] for more information.

[opensource.org]: http://opensource.org/licenses/MIT
