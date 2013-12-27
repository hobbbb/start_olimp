package Ctrl::Auth;

use Dancer ':syntax';
use Util;

use Record::User;

get '/' => sub {
    return redirect '/auth/register';
};

get '/register/' => sub {
    return redirect '/' if vars->{loged};

    my $p = {};
    $p->{role} = params->{role} || 'student';

    return template 'auth', $p;
};

get '/logout/' => sub {
    cookie code => '', expires => '0';
    return redirect '/';
};

get '/restore/' => sub {
    return redirect '/' if vars->{loged};
    return template 'restore';
};



post '/register/' => sub {
    my %params = params;

    if ($params{role} =~ /^student|teacher|parent$/) {
        $params{x_real_ip} = request->{env}->{HTTP_X_REAL_IP};

        my $user = Record::User->add(%params);
        if ($user) {
            cookie code => $user->regcode, expires => '1 year';
            return redirect '/';
        }
    }
    else {
        $params{role} = 'student';
    }

    my $p = {
        role => $params{role},
        form => \%params,
    };
    return template 'auth', $p;
};

post '/login/' => sub {
    my $user = Record::User->get_by_login(params);
    if ($user) {
        cookie code => $user->regcode, expires => '1 year';
    }
    return redirect '/';
};

=c
post '/restore/' => sub {
    if (params->{email}) {
        my $user = Record::User->list({ email => params->{email} });
        if ($user) {
            my $new_password = Util::generate(length => 8, light => 1);
            # send_email(
            #     to      => $user->{email},
            #     subject => 'Восстановление пароля',
            #     body    => $new_password,
            # );
            # $user->change(password => Record::User->password_crypt($new_password));
            $user->change(password => $new_password);
        }
    }

    return template 'restore';
};
=cut
true;
