package Shop;
use Mojo::Base 'Mojolicious';
use Mojo::Pg;

# This method will run once at server start
sub startup {
	my $app = shift;

	# Load configuration from hash returned by config file
	my $config = $app->plugin('Config');

	# Configure the application
	$app->secrets($config->{secrets});

    my $pg = Mojo::Pg->new( $app->config->{pg}->{uri} );

    $app->helper(
        pg => sub {
            return $pg;
        }
    );

	$app->plugin('Model');
	$app->plugin('Shop::Routes');

}

1;
