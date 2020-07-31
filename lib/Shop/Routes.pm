package Shop::Routes;
use Mojo::Base 'Mojolicious::Plugin';

sub register {
    my ($self, $app) = @_;

	my $routes = $app->routes;

	my $product = $routes->under('/product');

	$product->get('categories')->to('product#categories');

	my $file = $routes->under('/file');

	$file->put('/')->to('file#create');
	$file->get('/')->to('file#list');
	$file->get('/:uuid')->to('file#get');
	$file->delete('/:uuid')->to('file#delete');
	
}

1;
