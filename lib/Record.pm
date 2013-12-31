package Record;

use Mouse;

use Dancer ':syntax';
use Dancer::Plugin::Database;
use Util;

has id => (
    is      => 'ro',
    isa     => 'Int',
    clearer => 'clear_id',
);

sub take {
    my ($class, $id) = @_;
    return $class->list({ id => $id });
}

sub list {
    my ($class, $cond) = @_;
    $cond ||= {};

    my $list = [ database->quick_select($class->TABLE, $cond) ];

    if (scalar @$list == 1) {
        return wantarray ? map { $class->new($_) } @$list : $class->new($list->[0]);
    }
    else {
        return map { $class->new($_) } @$list;
    }
}

sub count {
    my ($class, $cond) = @_;
    $cond ||= {};

    return database->quick_count($class->TABLE, $cond);
}

sub create {
    my ($class, %params) = @_;
    if ($class->can('validate')) {
        return unless $class->validate(\%params);
    }

    $params{id} = $class->_insert(%params);
    return $class->new(%params);
}

sub save {
    my ($self, %params) = @_;
    if (ref($self)->can('validate')) {
        return unless $self->validate(\%params, { skip_empty => 1 });
    }

    return $self->_update(%params);
}

sub remove {
    my ($invocant, $id) = @_;
    if (ref($invocant)) {
        return ref($invocant)->_delete;
    }
    elsif ($id) {
        my $self = $invocant->take($id) or return;
        return $self->_delete;
    }
}

sub _insert {
    my ($class, %params) = @_;

    $class->clear_params(\%params);
    database->quick_insert($class->TABLE, \%params) or return;
    return database->last_insert_id(undef, undef, undef, undef) or return;
}

sub _update {
    my ($self, %params) = @_;
    return unless $self->id;

    for my $k ($self->clear_params(\%params)) {
        $self->$k($params{$k});
    }
    database->quick_update($self->TABLE, { id => $self->id }, { %$self }) or return;

    return $self;
}

sub _delete {
    my $self = shift;
    return database->quick_delete($self->TABLE, { id => $self->id });
}

### Other methods

sub as_vars {
    my $self = shift;
    return +{ %$self };
}

sub TABLE {
    my ($invocant) = @_;
    my $name = ref($invocant) || $invocant;
    $name =~ s/^Record:://;
    $name =~ s/::/_/g;
    return $name;
}

sub clear_params {
    my ($invocant, $params) = @_;
    my $class = ref($invocant) || $invocant;

    for my $k (keys %$params) {
        unless (grep(/^$k$/, $class->meta->get_attribute_list)) {
            delete $params->{$k};
        }
    }
    return keys %$params;
}

__PACKAGE__->meta->make_immutable();
