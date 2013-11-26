package Ctrl::Admin;

use Dancer ':syntax';
# use Dancer::Plugin::Database;
# use Dancer::Plugin::Ajax;
# use File::Copy;
# use func;

get '/' => sub {
    template 'admin/index.tpl';
};

true;
