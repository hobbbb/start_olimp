package Record::Content;

use Mouse;

use Util;
use Errors;

extends 'Record';

has name  => (is => 'rw', isa => 'Str', required => 1);
has descr => (is => 'rw', isa => 'Str', required => 1);

sub validate {
    my ($invocant, $params, $opt) = @_;
    my $class = ref($invocant) || $invocant;
    $opt ||= {};

    for (qw/name descr/) {
        fail $_ unless $params->{$_} and length($params->{$_}) >= 3;
    }

    return failed() ? 0 : 1;
}

__PACKAGE__->meta->make_immutable();
