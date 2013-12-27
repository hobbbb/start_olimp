package Ctrl::Admin::User;

use Dancer ':syntax';
use Util;

use Record::User;

get '/' => sub {
    my $p = {};
    $p->{role} = params->{role} || 'student';

    $p->{list} = [ map { $_->as_vars } Record::User->list({ role => $p->{role} }) ];
    return template 'admin/users', $p;
};

get '/:id/' => sub {
    my $p = {};

    my $user = Record::User->take(params->{id});
    if ($user) {
        $p->{form} = $user->as_vars;
    }

    return template 'admin/users', $p;
};

true;
