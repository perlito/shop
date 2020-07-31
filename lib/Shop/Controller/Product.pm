package Shop::Controller::Product;
use Mojo::Base 'Mojolicious::Controller';

sub categories {
	my $self = shift;

	
	$self->render( json => $self->model('Products')->get_product_categories() );
}

1;
