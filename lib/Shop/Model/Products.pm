package Shop::Model::Products;
use Mojo::Base 'MojoX::Model';

use parent 'Shop::Validator';

#has 'pg';

sub get_product_categories {
	my ( $self ) = @_;

	my $res = $self->app->pg->db->query(q{
				SELECT *
				  FROM product.categories 
				})->hashes;

	return [] unless $res && $res->first;

	return $res->to_array;
}

sub add_category {
	my ( $self, $params ) = @_;

	my ( $data, $errors ) = $self->validate($params,
									{
										name => {
													type => 'text',
													required => 1,
												},
										description => {
														type => 'text'
													   },
										parent_id => { type => 'text' },
										
									});

	return ( undef, $errors) if $errors;

	my $res = $self->pg->db->query(q{
					INSERT INTO product.categories(name, description, parent_id)
					VALUES ($1,$2, $3)
					RETURNING id
					},
					$data->{name},
					$data->{description},
					$data->{parent_id}
					)->hash;
					
	unless ( $res && ref $res eq 'HASH' && $res->{id} ){
		return ( undef, { 'common_error' => 'insert_error' } );
	}

	return ( $res->{id}, undef );				
}

sub add_product {
	my ( $self, $params ) = @_;

	my ( $data, $errors ) = $self->validate($params,
									{
										name 			=> {
															type => 'text',
															required => 1,
														   },
										description 	=> { type => 'text' },
										sale_deadline 	=> { type => 'date' },
										unit 			=> { type => 'text' },
										min_value 		=> { type => 'text' },
										category_id 	=> {
															 type => 'uuid',
															 required => 1
														   },
									});

	return ( undef, $errors) if $errors;


	my $res = $self->pg->db->query(q{
					INSERT INTO product.items( name, description, sale_deadline, unit, min_value, category_id )
					VALUES ($1, $2, $3, $4, $5, $6)
					RETURNING id
					},
					$data->{name},
					$data->{description},
					$data->{sale_deadline},
					$data->{unit},
					$data->{min_value},
					$data->{category_id},
					)->hash;
					
	unless ( $res && ref $res eq 'HASH' && $res->{id} ){
		return ( undef, { 'common_error' => 'insert_error' } );
	}

	return ( $res->{id}, undef );		
}

sub get_product {
	my ( $self, $params ) = @_;

	my ( $data, $errors ) = $self->validate($params,
								{
									id => { type => 'uuid',
											required => 1
										  }
								});

	return ( undef, $errors) if $errors;

		my $res = $self->pg->db->query(q{
					SELECT *
					  FROM product.items
					 WHERE id = $1
					},
					$data->{id},
					)->hash;
					
	unless ( $res && ref $res eq 'HASH' && $res->{id} ){
		return ( undef, { 'common_error' => 'not_found' } );
	}

	return ( $res, undef );	
}

1;
