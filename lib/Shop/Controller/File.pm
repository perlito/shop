package Shop::Controller::File;
use Mojo::Base 'Mojolicious::Controller';

sub create {
	my ( $self ) = @_;

	my $asset = $self->param('upload')->asset;
	warn $self->dumper($asset);

	my ( $error, $res ) = $self->model('File')->create( $self->param('upload')->asset );
	warn "\n\n Error => @{[ $self->dumper($error) ]}, res => @{[ $self->dumper($res) ]} \n\n"; 
    return $self->render(json => $error || $res );
}


1;
