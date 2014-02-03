package Ctrl::User::Interest;

use Dancer ':syntax';
use Util;

use Record::User;
use Record::Interest;

get '/' => sub {
    StartOlimp::not_found() unless vars->{loged};
    my $p = {};
    $p->{list} = [ map { $_->as_vars } Record::Interest->list() ];
    return template 'interest', $p;
};

post '/' => sub {
    my $user = Record::User->check_auth(cookie 'code') or StartOlimp::not_found();
    return redirect '/user/interest/';
};

true;
