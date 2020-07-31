package Shop::Model::File;
use Mojo::Base 'MojoX::Model';


sub create {
	my ( $self, $asset ) = @_;

	unless ( $asset ){
		return ( undef, { 'file_upload' => 'require_file' } )
	}

	warn "\n\nmove to @{[ $self->app->dumper( $self->app->config )  ]}\n\n";
	$asset->move_to( $self->app->config->{file_dir} );

	return ( { ok => 1 }, undef );
	
}

1;
