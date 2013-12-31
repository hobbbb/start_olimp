package Ctrl::Admin::Content;

use Dancer ':syntax';

use Record::Content;
use Util;

get '/' => sub {
    my $p = {};
    $p->{list} = [ map { $_->as_vars } Record::Content->list() ];
    return template 'admin/content', $p;
};

get '/:id/' => sub {
    my $p = {};

    if (params->{id} =~ /^\d+$/) {
        my $content = Record::Content->take(params->{id});
        if ($content) {
            $p->{form} = $content->as_vars;
        }
    }

    return template 'admin/content', $p;
};

post '/:id/' => sub {
    my $p = { form => \%{ params() } };

    if (params->{id} =~ /^\d+$/) {
        my $content = Record::Content->take(params->{id});
        if ($content) {
            return redirect '/admin/content/' if $content->save(params());
        }
    }
    else {
        return redirect '/admin/content/' if Record::Content->create(params());
    }

    return template 'admin/content', $p;
};

del '/:id/' => sub {
    Record::Content->remove(params->{id});
};

true;
