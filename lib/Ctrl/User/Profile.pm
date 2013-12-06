package Ctrl::User::Profile;

use Dancer ':syntax';
# use Util;

# use Record::User;

get '/' => sub {
    return template 'profile';
};

post '/' => sub {
    return unless vars->{loged};
    my %params = params;
=c
    my $user = Record::User->take(vars->{loged}->{id});
    if ($user) {
        $user->change(\%params);
    }
    else {
        my $p = {
            role => $params{role},
            form => \%params,
        };
        return template 'profile.tpl', $p;
    }
=cut
};

true;
