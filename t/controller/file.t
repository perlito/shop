use Mojo::Base -strict;

use Test::More;
use Test::Mojo;
use Data::Dumper;
my $t = Test::Mojo->new('Shop');

subtest 'create' => sub {

	my $upload = {upload => {content => 'bar', filename => 'baz.txt'}};
	$t->put_ok('/file' => form => $upload)
	  ->status_is(200)
	  ->json_is('/ok' => 1);

	
};

done_testing();
