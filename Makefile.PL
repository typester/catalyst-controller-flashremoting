use inc::Module::Install;
name 'Catalyst-Controller-FlashRemoting';
all_from 'lib/Catalyst/Controller/FlashRemoting.pm';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
