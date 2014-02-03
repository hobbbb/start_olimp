package Ctrl::Admin::Content;

use Dancer ':syntax';

use Model::Content;
use Util;

get '/' => sub {
    my $p = {};
    $p->{list} = [ map { $_->as_vars } Model::Content->list() ];
    return template 'admin/content', $p;
};

get '/:id/' => sub {
    my $p = {};

    if (params->{id} =~ /^\d+$/) {
        my $content = Model::Content->take(params->{id});
        if ($content) {
            $p->{form} = $content->as_vars;
        }
    }

    return template 'admin/content', $p;
};

post '/:id/' => sub {
    my $p = { form => \%{ params() } };

    if (params->{id} =~ /^\d+$/) {
        my $content = Model::Content->take(params->{id});
        if ($content) {
            return redirect '/admin/content/' if $content->save(params());
        }
    }
    else {
        return redirect '/admin/content/' if Model::Content->create(params());
    }

    return template 'admin/content', $p;
};

del '/:id/' => sub {
    Model::Content->remove(params->{id});
};

true;
