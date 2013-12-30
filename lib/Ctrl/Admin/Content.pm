package Ctrl::Admin::Content;

use Dancer ':syntax';

use Record::Content;

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
            $p->{item} = $content->as_vars;
        }
    }

    return template 'admin/content', $p;
};

post '/:id/' => sub {
    my $p = { params => \%{ params() } };

    if (params->{id} =~ /^\d+$/) {
        my $content = Record::Content->take(params->{id});
        if ($content) {
            return redirect '/admin/content/' if $content->change(params());
        }
    }
    else {
        return redirect '/admin/content/' if Record::Content->add(params());
    }

    return template 'admin/content', $p;
};

true;
