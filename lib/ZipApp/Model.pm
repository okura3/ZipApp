package ZipApp::Model;
use strict;
use warnings;
use Dancer ':syntax';
use Dancer::Plugin::DBIC;

sub new {
  my $class     = shift;
  my $resultset = schema->resultset('Zip');
  bless { resultset => $resultset }, $class;
}

sub entry {
  my $self  = shift;
  my ($id)  = @_;
  my $rs    = $self->{resultset};
  my $entry = $id ? $rs->find($id) : { id => 0, };
}

sub list {
  my $self = shift;
  my ($p) = @_;
  $p = {
    where    => {},
    rows     => 10,
    order_by => { -asc => qw/zip/ },
    page     => 1,
    %$p
  };
  my ( $where, $rows, $order_by, $page ) = @$p{qw/where rows order_by page/};
  my $rs = $self->{resultset}->search(
    $where,
    { rows     => $rows,
      order_by => $order_by,
    }
  )->page($page);
  my $pager = $rs->pager;
  my @rows  = $rs->all();
  ( \@rows, $pager );
}

sub update {
  my $self         = shift;
  my ($p)          = @_;
  my $rs           = $self->{resultset};
  my @column_names = $rs->result_source->columns;
  my %update_data  = map { $_ => $p->{$_} } (@column_names);
  $rs->find( $p->{id} )->update( \%update_data );
}

sub delete {
  my $self = shift;
  my ($id) = @_;
  my $rs   = $self->{resultset};
  $rs->find($id)->delete;
}

sub create {
  my $self         = shift;
  my ($p)          = @_;
  my $rs           = $self->{resultset};
  my @column_names = $rs->result_source->columns;
  my %create_data  = map { $_ => $p->{$_} } (@column_names);
  my $row          = $rs->new_result( \%create_data )->insert;
  return $row->id;
}

sub columns {
  my $self         = shift;
  my $rs           = $self->{resultset};
  my @column_names = $rs->result_source->columns;
  return \@column_names;
}

1;
