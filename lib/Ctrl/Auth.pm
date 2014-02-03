package Ctrl::Auth;

use Dancer ':syntax';
use Util;
use Errors;

use Model::User;

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

        my $user = Model::User->create(%params);
        if ($user) {
            cookie code => $user->regcode, expires => '1 year';
            return redirect '/';
        }
    }
    else {
        $params{role} = 'student';
    }

    return template 'auth', {
        role => $params{role},
        form => \%params,
    };
};

post '/login/' => sub {
    my $user = Model::User->get_by_login(params());
    if ($user) {
        cookie code => $user->regcode, expires => '1 year';
    }
    return redirect '/';
};

post '/restore/' => sub {
    my %params = params;

    my $user;
    if ($params{email}) {
        $user = Model::User->list({ email => $params{email} });
        if ($user) {
            my $new_password = Util::generate(length => 8, light => 1);
            $user->save(password => $new_password);
            if ($user) {
                send_email(
                    to      => $user->email,
                    subject => 'Восстановление пароля',
                    body    => $new_password,
                );
            }
        }
        else {
            fail 'restore_no_user';
        }
    }

    return template 'restore', {
        user => $user,
        form => \%params,
    };
};

true;
