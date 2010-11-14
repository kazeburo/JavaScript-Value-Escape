use strict;
use Test::More;

use JavaScript::Value::Escape;

can_ok('main', 'javascript_value_escape');
my $bs = '\\';
is( javascript_value_escape(q!&foo"bar'<b>baz</b>\ / </script>! . qq!\r\nfoo\\!),
    '\u0026foo\u0022bar\u0027\u003cb\u003ebaz\u003c\/b\u003e'.$bs.$bs.' \/ \u003c\/script\u003e\r\nfoo'.$bs.$bs);


done_testing();

