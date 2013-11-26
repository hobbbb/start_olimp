package Model;

use Dancer ':syntax';
use Dancer::Plugin::Database;
use Carp;
use Util;

use Mouse;

has id  => (is => 'ro', isa => 'Int');

### Class methods

=c
sub list {
    my ($class, $cond) = @_;
    $cond ||= {};

    my $list = [ database->quick_select($class->_tname, $cond) ];
    return map { $class->new($_) } @$list;
}

sub get {
    my ($class, $id) = @_;

    my $o = database->quick_select($class->_tname, { id => $id }) || {};
    return $class->new($o);
}
=cut

### Object methods

sub insert {
    my $self = shift;
    croak 'No object' unless $self;

    return database->quick_insert($self->_tname, { %$self }) ? $self : undef;
}

### Other methods

# sub delete {
#     my $self = shift;
#     croak 'No object' unless $self;

#     return database->quick_insert($self->_tname, { %$self }) ? $self : undef;
# }

sub _tname {
    my ($invocant) = @_;
    my $name = ref($invocant) || $invocant;
    $name =~ s/::/_/g;
    return $name;
}

__PACKAGE__->meta->make_immutable();
