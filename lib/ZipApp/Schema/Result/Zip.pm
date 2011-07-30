package ZipApp::Schema::Result::Zip;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

ZipApp::Schema::Result::Zip

=cut

__PACKAGE__->table("zip");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 code

  data_type: 'char'
  is_nullable: 1
  size: 5

=head2 zipold

  data_type: 'char'
  is_nullable: 1
  size: 5

=head2 zipcode

  data_type: 'char'
  is_nullable: 1
  size: 7

=head2 ken_kana

  data_type: 'varchar'
  is_nullable: 1
  size: 128

=head2 siku_kana

  data_type: 'varchar'
  is_nullable: 1
  size: 128

=head2 cho_kana

  data_type: 'varchar'
  is_nullable: 1
  size: 128

=head2 ken_char

  data_type: 'varchar'
  is_nullable: 1
  size: 128

=head2 siku_char

  data_type: 'varchar'
  is_nullable: 1
  size: 128

=head2 cho_char

  data_type: 'varchar'
  is_nullable: 1
  size: 128

=head2 flg1

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 flg2

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 flg3

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 flg4

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 flg5

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 flg6

  data_type: 'char'
  is_nullable: 1
  size: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "code",
  { data_type => "char", is_nullable => 1, size => 5 },
  "zipold",
  { data_type => "char", is_nullable => 1, size => 5 },
  "zipcode",
  { data_type => "char", is_nullable => 1, size => 7 },
  "ken_kana",
  { data_type => "varchar", is_nullable => 1, size => 128 },
  "siku_kana",
  { data_type => "varchar", is_nullable => 1, size => 128 },
  "cho_kana",
  { data_type => "varchar", is_nullable => 1, size => 128 },
  "ken_char",
  { data_type => "varchar", is_nullable => 1, size => 128 },
  "siku_char",
  { data_type => "varchar", is_nullable => 1, size => 128 },
  "cho_char",
  { data_type => "varchar", is_nullable => 1, size => 128 },
  "flg1",
  { data_type => "char", is_nullable => 1, size => 1 },
  "flg2",
  { data_type => "char", is_nullable => 1, size => 1 },
  "flg3",
  { data_type => "char", is_nullable => 1, size => 1 },
  "flg4",
  { data_type => "char", is_nullable => 1, size => 1 },
  "flg5",
  { data_type => "char", is_nullable => 1, size => 1 },
  "flg6",
  { data_type => "char", is_nullable => 1, size => 1 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-05-28 12:17:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:dtj8xP55Bjq4+bojqD1JyA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
