use inc::Module::Install;
name 'JavaScript-Value-Escape';
all_from 'lib/JavaScript/Value/Escape.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
