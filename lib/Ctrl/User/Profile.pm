package Ctrl::User::Profile;

use Dancer ':syntax';
use Util;

use Model::User;

get '/' => sub {
    my $user = vars->{loged} or StartOlimp::not_found();
    return template 'profile';
};

post '/' => sub {
    my $user = vars->{loged} or StartOlimp::not_found();
    $user->save(params());
    var loged => $user;
    return template 'profile';
};

true;
