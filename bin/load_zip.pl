#!/usr/bin/perl
use strict;
use Encode qw(encode decode);
use Encode::EUCJPMS;
use Encode::JP::H2Z;
use DBI;
use DBD::SQLite;
use SQL::Abstract;

my $database  = "data/zip.sqlite";
my $table     = "zip";
my @item_name = qw( code zipold zipcode ken_kana siku_kana
    cho_kana ken_char siku_char cho_char
    flg1 flg2 flg3 flg4 flg5 flg6 );
my $dsn = "dbi:SQLite:dbname=$database";
my $dbh = DBI->connect( $dsn, "", "",
  { AutoCommit => 0, sqlite_unicode => 1, } );
my %zip;
$zip{$_} = $_ for (@item_name);
my $sql = SQL::Abstract->new;
my ( $stmt, @bind ) = $sql->insert( $table, \%zip );
my $sth = $dbh->prepare($stmt);
open my $ken_all, '-|', '/usr/bin/lha p data/ken_all.lzh | /usr/bin/nkf -w -Lu -d' or die;
<$ken_all> for ( 1 .. 3 );

my $utf8;
while ( defined( my $line = <$ken_all> ) ) {
  chomp $line;
  $utf8 = decode 'UTF8', $line;
  @zip{@item_name} = map { s/^"|"$//g; $_ } split ',', $utf8;
  $sth->execute( @zip{@bind} );
}
close $ken_all;
$sth->finish;
$dbh->commit;
$dbh->disconnect;
exit;
