package Model::Interest;

use Mouse;

use Util;
use Errors;

extends 'Storage';

has name  => (is => 'rw', isa => 'Str', required => 1);

sub validate {
    my ($invocant, %args) = @_;
    my %params = $invocant->merge_params(%args);

    for (qw/name/) {
        fail $_ unless $params{$_} and length($params{$_}) >= 3;
    }

    return failed() ? 0 : 1;
}

__PACKAGE__->meta->make_immutable();
