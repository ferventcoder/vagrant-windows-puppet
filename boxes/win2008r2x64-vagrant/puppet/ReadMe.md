Please navigate to this directory on the command line.

For symbolic links, use the following example

`ln -s ~/code/puppetlabs/modules/puppetlabs-powershell modules/powershell`

Then run the following command:

`librarian-puppet install --path=./modules`

**Note:** You can install librarian-puppet as a gem, just use `gem install librarian-puppet` - if you run into permissions errors, try `sudo gem install librarian-puppet`. You may also need `gem install puppet`.

You may need to use `--clean` as well.
