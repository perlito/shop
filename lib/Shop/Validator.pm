package Shop::Validator;
use Mojo::Base -base;


sub validate {
	my ( $self, $params, $param_types ) = @_;
	
	unless ( $params && ref $params eq 'HASH'){
		return ( undef, { common_error => 'incorrect_input' } );
	}


	unless ( $param_types && ref $param_types eq 'HASH'){
		return ( undef, { common_error => 'incorrect_input' } );
	}

	my ( %errors, %data );
	for my $param ( keys %$param_types ){
		if ( exists $params->{$param} ){
			my $validate_method = "validate_$param_types->{$param}->{type}";

			unless ( $self->can($validate_method) ){
				$errors{$param} = 'unknown_type';
			}

			my $value = $self->$validate_method( $params->{$param} );

			unless ( defined $value ){
				$errors{$param} = 'invalid';
				next;
			}

			$data{$param} = $value;
			
		}
		elsif( $param_types->{$param}->{required} ) {
			$errors{$param} = "required";
		} 
	}


	return ( \%data, ( keys %errors ? \%errors : undef ) );
	
}

sub validate_text {
	return $_[1] if defined $_[1];
	return undef;
}

sub validate_email {
    return $_[1] if $_[1] =~ /^[a-zA-Z0-9_][a-zA-Z0-9_.-]+[@]([a-zA-Z0-9_][a-zA-Z0-9_-]*[.])+[a-zA-Z]{2,4}$/;
    return undef;
}

sub validate_int {
	return $_[1] if defined $_[1] && $_[1] =~ /^\d+$/;
	return undef;
}

sub validate_numeric {
	return $_[1] if defined $_[1] && $_[1] =~ /^\d+\.?\d*$/;
	return undef;
}


sub validate_uuid {
	return $_[1] if defined $_[1] && $_[1] =~ /^[a-f0-9]{8}\-[a-f0-9]{4}\-[a-f0-9]{4}\-[a-f0-9]{4}\-[a-f0-9]{12}$/;
	return undef;

}

sub validate_date {
	return $_[1] if defined $_[1] && $_[1] =~ /^\d{4}\-\d{2}\-\d{2}$/;
	return undef;
}

1;
