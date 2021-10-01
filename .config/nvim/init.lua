local plugins = require('thinkofher.plugins')

plugins.bootstrap()

require('packer').startup(function(use)
    plugins.mount(use)
end)

require('thinkofher.init')
