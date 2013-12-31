package StartOlimp;

use Dancer ':syntax';
use Util;

use Record::User;

load_app 'Ctrl::Admin', prefix => '/admin';
load_app 'Ctrl::Auth', prefix => '/auth';
load_app 'Ctrl::User';

hook before => sub {
    my $user = Record::User->check_auth(cookie 'code');
    if ($user) {
        var loged => $user->as_vars;
    }
    else {
        cookie code => '', expires => '0';
    }
};

hook before_template_render => sub {
    my $tokens = shift;

    $tokens->{LOGED} = delete $tokens->{vars}->{loged};
    $tokens->{fail} = delete $tokens->{vars}->{fail};
};

any '/' => sub {
    my $p = {};
    return template 'index', $p;
};

get '/404/' => sub {
    status 'not_found';
    return template '404.tx';
};

sub not_found {
    return redirect '/404/';
}

true;
