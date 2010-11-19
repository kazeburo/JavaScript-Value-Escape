package JavaScript::Value::Escape;

use strict;
use warnings;
use 5.8.1;
use base qw/Exporter/;

our $VERSION = '0.02';
our @EXPORT = qw/javascript_value_escape/;

my %e = (
    q!\\! => 'u005c',
    q!"! => 'u0022',
    q!'! => 'u0027',
    q!<! => 'u003c',
    q!>! => 'u003e',
    q!&! => 'u0026',
    q!=! => 'u003d',
    q!-! => 'u002d',
    q!;! => 'u003b',
    "\x{2028}" => 'u2028',
    "\x{2029}" => 'u2029',
);
map { $e{pack('U',$_)} = sprintf("u%04d",$_) } 0..31;

sub javascript_value_escape {
    my $text = shift;
    $text =~ s!([\\"'<>&=\-;\x00-\x1f]|\x{2028}|\x{2029})!\\$e{$1}!g;
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
q!"!, q!'!, q!&!, q!<!, q!>!, q!/!, q!\! and control characters to 
JavaScript unicode characters like "\u0026".

=head1 EXPORT FUNCTION

=over 4

=item javascript_value_escape($value:Str); Str

Escape a string. The argument of this function must be a flagged UTF-8 string
(a.k.a. Perl's internal form). 

=back

=head1 AUTHOR

Masahiro Nagano E<lt>kazeburo {at} gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
