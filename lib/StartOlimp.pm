package StartOlimp;

use Dancer ':syntax';
use User;
use Data::Dumper;

load_app 'Ctrl::Admin', prefix => '/admin';

hook before => sub {
    if (request->path_info =~ m!^/admin!) {
        set layout => 'admin.tpl';
    }
    else {
        set layout => 'main.tpl';
    }
=c
    my $glob_vars = [ database->quick_select('glob_vars', {}) ];
    var glob_vars_array => $glob_vars;

    my $gb;
    for (@$glob_vars) {
        my @s = split /\./, $_->{name};
        if (scalar @s > 1) {
            $gb->{$s[0]}->{$s[1]} = $_->{val};
        }
        else {
            $gb->{$s[0]} = $_->{val};
        }
    }
    var glob_vars => $gb;

    var loged => Users::check_auth();
    Users::last_visit();
=cut
};

any '/' => sub {
    my $p = {};
    return template 'index.tpl', $p;
};

prefix '/auth' => sub {
    any '/' => sub {
        my $p = {};
        # die Dumper(User->list);
        template 'auth.tpl', $p;
    };

    any ['get', 'post'] => '/register/' => sub {
        # return redirect 'http://'. request->host .'/' if check_auth();

        my ($form, $err) = ({},{});
=c
        if (request->method() eq 'POST') {
            my %params = params;
            ($form, $err) = _check_user(\%params);

            unless (scalar keys %$err) {
                $form->{registered} = func::now();
                $form->{regcode} = func::generate();
                $form->{password} = func::generate(8);
                $form->{x_real_ip} = request->{env}->{HTTP_X_REAL_IP};
                database->quick_insert('users', $form);

                if (_login($form->{phone}, $form->{password}, 1)) {
                    return redirect 'http://'. request->host .'/';
                }
            }
        }
=cut
        template 'auth.tpl', { form => $form, err => $err };
    };
};

true;
