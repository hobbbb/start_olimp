package StartOlimp;

use Dancer ':syntax';
use Util;

# use Model::User;

load_app 'Ctrl::Admin', prefix => '/admin';
load_app 'Ctrl::Auth', prefix => '/auth';

hook before => sub {
    if (request->path_info =~ m!^/admin!) {
        set layout => 'admin.tpl';
    }
    else {
        set layout => 'main.tpl';
    }

    # my $user = Model::User->check_auth;
    # if ($user) {
    #     var loged => $user->as_vars;
    # }
};

any '/' => sub {
    my $p = {};
    return template 'index.tpl', $p;
};

true;
