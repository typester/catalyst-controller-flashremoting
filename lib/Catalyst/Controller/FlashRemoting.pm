package Catalyst::Controller::FlashRemoting;
use strict;
use warnings;
use base 'Catalyst::Controller';

__PACKAGE__->mk_accessors(qw/_amf_method/);

our $VERSION = '0.01';

sub new {
    my $self = shift->NEXT::new(@_);
    $self->{_amf_method} = {};

    $self;
}

sub _parse_AMFGateway_attr {
    my ($self, $c, $name, $value) = @_;

    return ActionClass => 'Catalyst::Controller::FlashRemoting::Action::Gateway',
}

sub _parse_AMFMethod_attr {
    my ($self, $c, $name, $value) = @_;

    my $method = $value || $name;
    $self->_amf_method->{ $method } = $self->can($name);

    return;
}

=head1 NAME

Catalyst::Controller::FlashRemoting - Module abstract (<= 44 characters) goes here

=head1 SYNOPSIS

    package MyApp::Controller::Gateway;
    use strict;
    use warnings;
    use base qw/Catalyst::Controller::FlashRemoting/;
    
    sub gateway :Path :AMFGateway { }
    
    sub echo :AMFMethod {
        my ($self, $c, $args) = @_;
    
        return $args;
    }
    
    sub sum :AMFMethod('sum') {
        my ($self, $c, $args) = @_;
    
        return $args->[0] + $args->[1];
    }

=head1 DESCRIPTION

Stub documentation for this module was created by ExtUtils::ModuleMaker.
It looks like the author of the extension was negligent enough
to leave the stub unedited.

Blah blah blah.

=head1 AUTHOR

Daisuke Murase <typester@cpan.org>

=head1 COPYRIGHT

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

=cut

1;
