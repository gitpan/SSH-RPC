package SSH::RPC::Result;

our $VERSION = 1.200;

use strict;
use Class::InsideOut qw(private id register);

=head1 NAME

SSH::RPC::Result - Provides methods for the response from a SSH::RPC::Client run() method request.

=head1 DESCRIPTION

This module is never used directly by you. Instead you'll ge a reference to this object as it's created by L<SSH::RPC::Client>.

=head1 METHODS

The following methods are accessible from this class.

=cut

private response => my %response;

#-------------------------------------------------------------------

=head2 getError ()

Returns the human readable error message (if any).

=cut

sub getError {
    my $self = shift;
    return $response{id $self}{error};
}

#-------------------------------------------------------------------

=head2 getResponse ()

Returns the return value(s) from the RPC, whether that be a scalar value, or a hash reference or array reference.

=cut

sub getResponse {
    my $self = shift;
    return $response{id $self}{response};
}

#-------------------------------------------------------------------

=head2 getShellVersion ()

Returns the $VERSION from the shell. This is useful if you have different versions of your shell running on different machines, and you need to do something differently to account for that.

=cut

sub getShellVersion {
    my $self = shift;
    return $response{id $self}{version};
}

#-------------------------------------------------------------------

=head2 getStatus ()

Returns a status code for the RPC. The built in status codes are:

 200 - Success
 400 - Malform request received by shell.
 405 - RPC called a method that doesn't exist.
 406 - Error transmitting RPC.
 500 - An undefined error occured in the shell.
 510 - Error translating return document in client.
 511 - Error translating return document in shell.

=cut

sub getStatus {
    my $self = shift;
    return $response{id $self}{status};
}

#-------------------------------------------------------------------

=head2 isSuccess ()

Returns true if the request was successful, or false if it wasn't.

=cut

sub isSuccess {
    my $self = shift;
    return ($self->getStatus == 200);
}

#-------------------------------------------------------------------

=head2 new ( result ) 

Constructor.

=head3 result

Result hash ref data structure generated by SSH::RPC::Client.

=cut

sub new {
    my ($class, $result) = @_;
    my $self = register($class);
    $response{id $self} = $result;
    return $self;
}

=head1 PREREQS

This package requires the following modules:

L<Class::InsideOut>

=head1 AUTHOR

JT Smith <jt_at_plainblack_com>

=head1 LEGAL

 -------------------------------------------------------------------
  SSH::RPC::Result is Copyright 2008-2009 Plain Black Corporation
  and is licensed under the same terms as Perl itself.
 -------------------------------------------------------------------
  http://www.plainblack.com                     info@plainblack.com
 -------------------------------------------------------------------

=cut


1;

