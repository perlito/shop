use Mojo::Base -strict;

use Test::More;
use Mojo::Pg;
use Shop::Model::Products;
use YAML::Tiny;
use Data::Dumper;
my $yaml = YAML::Tiny->read($ENV{SHOP_CONFIG}) or die "Can't read config!";

my $config = $yaml->[0];

my $pg = Mojo::Pg->new($config->{pg}->{uri}) or die "Cant connect to DB";

my $products = Shop::Model::Products->new(pg => $pg);

my %common_data;

subtest 'add_category' => sub {
	my $error;
	( $common_data{category_id}, $error )= $products->add_category({ name => 'test_category' });

	ok($common_data{category_id}, 'category_created');
};

subtest 'get_product_categories' => sub {
	my $categories = $products->get_product_categories;
	
	is(ref $categories, 'ARRAY', 'ref is array');
	is( scalar( grep { $common_data{category_id} eq $_->{id} } @$categories ), 1, 'categories contains new category' );
	
};

subtest 'add_product' => sub {
	my $error;
	( $common_data{product_id}, $error ) = $products->add_product(
						{
							name          => 'test_product',
							category_id    => $common_data{category_id},
							sale_deadline => '2020-01-01'
						});
						
	ok( $common_data{product_id}, 'product_created' );	
};

subtest 'get_product' => sub {
	my $error;

	($common_data{product}, $error) = $products->get_product({
										id => $common_data{product_id}
										});

	ok($common_data{product}->{id}, 'get_product');
	ok($common_data{product}->{category_id}, 'has category');
};


done_testing();
