package JavaScript::Value::Escape;

use strict;
use warnings;
use base qw/Exporter/;

our $VERSION = '0.01';
our @EXPORT = qw/javascript_value_escape/;

my $bs = '\\';
my %e = (
    q!\\! => $bs,
    q!"! => 'u0022',
    q!'! => 'u0027',
    q!/! => '/',
    q!<! => 'u003c',
    q!>! => 'u003e',
    q!&! => 'u0026',
    "\x0D" => "r",
    "\x0A" => "n",
);

sub javascript_value_escape {
    my $text = shift;
    $text =~ s!([\\"'/<>&]|\x0D|\x0A)!${bs}$e{$1}!g;
    return $text;
}



1;
__END__

=head1 NAME

JavaScript::Value::Escape - Avoid XSS in JavaScript value.

=head1 SYNOPSIS

  use JavaScript::Value::Escape;

=head1 DESCRIPTION

JavaScript::Value::Escape is

=head1 AUTHOR

Masahiro Nagano E<lt>kazeburo {at} gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
