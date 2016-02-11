Please navigate to this directory on the command line and run the following:

`librarian-puppet install --path=./modules`


**Note:** You can install librarian-puppet as a gem, just use `gem install librarian-puppet` - if you run into permissions errors, try `sudo gem install librarian-puppet`. You may also need `gem install puppet`.

You may need to use `--clean` as well.


After you run this, you will need to symlink the dsc module in or install it by some other means.

For symbolic links, use the following example

`ln -s ~/code/puppetlabs/modules/puppetlabs-powershell modules/powershell`
