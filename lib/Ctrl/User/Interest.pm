package Ctrl::User::Interest;

use Dancer ':syntax';
use Util;

use Model::User;
use Model::Interest;

get '/' => sub {
    StartOlimp::not_found() unless vars->{loged};
    my $p = {};
    $p->{list} = [ map { $_->as_vars } Model::Interest->list() ];
    return template 'interest', $p;
};

post '/' => sub {
    my $user = Model::User->check_auth(cookie 'code') or StartOlimp::not_found();
    return redirect '/user/interest/';
};

true;
