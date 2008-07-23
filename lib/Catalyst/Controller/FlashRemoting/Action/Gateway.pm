package Catalyst::Controller::FlashRemoting::Action::Gateway;
use strict;
use warnings;
use base qw/Catalyst::Action/;

use Data::AMF::Packet;

sub execute {
    my $self = shift;
    my ($controller, $c, @args) = @_;

    if ($c->req->content_type eq 'application/x-amf' and my $body = $c->req->body) {
        my $data = do { local $/; <$body> };

        my $request = Data::AMF::Packet->deserialize($data);

        my @results;
        for my $message (@{ $request->messages }) {
            my $method = $controller->_amf_method->{ $message->target_uri };

            if ($method) {
                my $res = $method->($controller, $c, $message->value);
                push @results, $message->result($res);
            }
            else {
                $c->log->error(qq{method for "@{[ $message->target_uri ]}" does not exist});
            }
        }

        my $response = Data::AMF::Packet->new(
            version  => $request->version,
            headers  => [],
            messages => \@results,
        );

        $c->res->content_type('application/x-amf');
        $c->res->body( $response->serialize );
    }
    else {
        $c->res->status(500);
        $c->res->body('');
    }

    $self->NEXT::execute(@_);
}

1;

