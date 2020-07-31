use Mojo::Base -strict;

use Test::More;
use Test::Mojo;
use Data::Dumper;
my $t = Test::Mojo->new('Shop');


subtest 'get categories' => sub {
	$t->get_ok('/product/categories')
	  ->status_is(200)
	  ->json_has('/0/id')
	  ->json_has('/0/name')
	  ->json_has('/0/description')
	  ->json_has('/0/parent_id')
	  ->json_like('/0/id', qr/[a-f0-9\-]{36}/, 'id is uuid');
	  
	#say Dumper($t->tx->res->json);  	
  
};

subtest 'add product' => sub {
	$t->post_ok('/product/add' => json )
}


done_testing();
