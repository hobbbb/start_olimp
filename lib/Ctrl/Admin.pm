package Ctrl::Admin;

use Dancer ':syntax';
use Util;
# use Dancer::Plugin::Ajax;

use Model::User;

get '/' => sub {
    template 'admin/index.tpl';
};

prefix '/users' => sub {
    get '/' => sub {
        my $p = {};

# my $self = Model::User->create(email => 'test', password => 'test');
# my $self = Model::User->get({ email => 'test' });
# $self->delete;
# w $self->as_vars;

        $p->{list} = [ map { $_->as_vars } Model::User->list ];
        template 'admin/users.tpl', $p;
    };

    any '/:id/' => sub {
        my $p = {};
        $p->{user} = Model::User->get(params->{id})->as_vars;
        template 'admin/users.tpl', $p;
    };
};

true;
