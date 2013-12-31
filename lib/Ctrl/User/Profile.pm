package Ctrl::User::Profile;

use Dancer ':syntax';
use Util;

use Record::User;

get '/' => sub {
    StartOlimp::not_found() unless vars->{loged};
    return template 'profile';
};

post '/' => sub {
    my $user = Record::User->check_auth(cookie 'code') or StartOlimp::not_found();
    $user->save(params());
    var loged => $user->as_vars;
    return template 'profile';
};

true;
