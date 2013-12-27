package Ctrl::Admin;

use Dancer ':syntax';

load_app 'Ctrl::Admin::User', prefix => '/admin/users';
load_app 'Ctrl::Admin::Content', prefix => '/admin/content';

get '/' => sub {
    return template 'admin/index';
};

true;
