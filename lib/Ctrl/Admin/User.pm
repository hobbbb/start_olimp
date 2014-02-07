package Ctrl::Admin::User;

use Dancer ':syntax';

use User;
use Util;

get '/' => sub {
    my $p = {};
    $p->{role} = params->{role} || 'student';

    $p->{list} = [ map { $_->as_vars } User->list({ role => $p->{role} }) ];
    return template 'admin/users', $p;
};

get '/:id/' => sub {
    my $p = {};

    my $user = User->take(params->{id});
    if ($user) {
        $p->{form} = $user->as_vars;
    }

    return template 'admin/users', $p;
};

post '/:id/' => sub {
    my $p = { form => \%{ params() } };

    if (params->{id} =~ /^\d+$/) {
        my $user = User->take(params->{id});
        if ($user) {
            return redirect '/admin/users/?role=' . $user->role if $user->save(params());
        }
    }

    return template 'admin/users', $p;
};

true;
