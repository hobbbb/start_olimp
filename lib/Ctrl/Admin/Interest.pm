package Ctrl::Admin::Interest;

use Dancer ':syntax';

use Interest;
use Util;

get '/' => sub {
    my $p = {};
    $p->{list} = [ map { $_->as_vars } Interest->list() ];
    return template 'admin/interest', $p;
};

get '/:id/' => sub {
    my $p = {};

    if (params->{id} =~ /^\d+$/) {
        my $content = Interest->take(params->{id});
        if ($content) {
            $p->{form} = $content->as_vars;
        }
    }

    return template 'admin/interest', $p;
};

post '/:id/' => sub {
    my $p = { form => \%{ params() } };

    if (params->{id} =~ /^\d+$/) {
        my $content = Interest->take(params->{id});
        if ($content) {
            return redirect '/admin/interest/' if $content->save(params());
        }
    }
    else {
        return redirect '/admin/interest/' if Interest->create(params());
    }

    return template 'admin/interest', $p;
};

del '/:id/' => sub {
    Interest->remove(params->{id});
};

true;
