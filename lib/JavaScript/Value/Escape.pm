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

JavaScript::Value::Escape - Avoid JavaScript value XSS

=head1 SYNOPSIS

  use JavaScript::Value::Escape;

  my $escaped = javascript_value_escape(q!&foo"bar'</script>!);
  # $escaped is "\u0026foo\u0022bar\u0027\u003c\/script\u003e"

  my $html_escaped = javascript_value_escape(Text::Xslate::Util::escape_html(q!&foo"bar'</script>!));

  print <<EOF;
  <script>
  var param = '$escaped';
  alert(param);

  document.write('$html_escaped');

  </script>
  EOF

=head1 DESCRIPTION

To avoid XSS with JavaScript Value, JavaScript::Value::Escape escapes 
q!"!, q!'!, q!&!, q!<!, q!>!, q!/!, q!\!, qq!\r! and qq!\n! to JavaScript
unicode characters like "\u5bae".

=head1 EXPORT FUNCTION

=over 4

=item javascript_value_escape($value:Str); Str

Escape a string. 

=back

=head1 AUTHOR

Masahiro Nagano E<lt>kazeburo {at} gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
