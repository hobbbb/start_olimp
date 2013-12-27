package Ctrl::Admin::Content;

use Dancer ':syntax';

use Record::Content;

get '/' => sub {
    my $p = {};
    $p->{list} = [ map { $_->as_vars } Record::Content->list() ];
    return template 'admin/content', $p;
};

any ['get', 'post'] => '/:id/' => sub {
    my $p = {};

    my %params = params();

    if (request->method() eq 'POST') {
        if (params->{id} =~ /^\d+$/) {
        }
        else {
            my $content = Record::Content->add(%params);
            if ($user) {
                cookie code => $user->regcode, expires => '1 year';
                return redirect '/';
            }
        }
    }
    else {
        # if (params->{id} =~ /^\d+$/) {
        #     my $content = Record::Content->take(params->{id});
        #     $p->{item} = $content->as_vars if $content;
        # }
    }

    return template 'admin/content', $p;
};

post '/' => sub {
    return template 'admin/content';
};

true;
