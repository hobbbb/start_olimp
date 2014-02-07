package StartOlimp;

use Dancer ':syntax';
use Util;

use User;

load_app 'Ctrl::Admin', prefix => '/admin';
load_app 'Ctrl::Auth', prefix => '/auth';
load_app 'Ctrl::User';

hook before => sub {
    my $user = User->check_auth(cookie 'code');
    if ($user) {
        var loged => $user;
    }
    else {
        cookie code => '', expires => '0';
    }
};

hook before_template_render => sub {
    my $tokens = shift;

    my $user = delete $tokens->{vars}->{loged};
    if ($user) {
        $tokens->{LOGED} = $user->as_vars;
    }
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
