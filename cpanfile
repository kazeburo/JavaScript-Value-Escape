requires 'perl', '5.008001';

on build => sub {
    requires 'ExtUtils::MakeMaker', '6.42';
    requires 'Test::More';
};
