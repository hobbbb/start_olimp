package Interest;

use Mouse;

use Util;
use Errors;

extends 'Storage';

has name  => (is => 'rw', isa => 'Str', required => 1);

sub list_by_user_rh {
    my ($class, $user_interest) = @_;

    my @list = ();
    for my $i (map { $_->as_vars } $class->list()) {
        $i->{checked} = grep(/^$i->{id}$/, @$user_interest) ? 1 : 0;
        push @list, $i;
    }

    return \@list;
}

sub validate {
    my ($invocant, %args) = @_;
    my %params = $invocant->merge_params(%args);

    for (qw/name/) {
        fail $_ unless $params{$_} and length($params{$_}) >= 3;
    }

    return failed() ? 0 : 1;
}

__PACKAGE__->meta->make_immutable();
