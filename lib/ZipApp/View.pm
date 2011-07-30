package ZipApp::View;
use strict;
use warnings;
use Dancer ':syntax';
use URI::Escape;
use ZipApp::Model;

sub new {
  my $class = shift;
  bless {}, $class;
}

sub entry {
  my $self = shift;
  my ( $model, $p ) = @_;
  $p = { id => 0, subaction => "form", %$p };
  my $id   = $p->{id};
  my %data = ();
  if ( $id != 0 ) {
    my $entry = $model->entry($id);
    my $columns = $model->columns;
    %data
        = map { $_ => $entry->$_ } ( @$columns );
  }
  template 'entry',
      {
    entry => { %data, %$p },
    %$p
      };
}

sub list {
  my $self = shift;
  my ( $model, $p ) = @_;
  if ( request->is_post ) {
    my ( $zipcode, $siku_char, $cho_char )
        = map { uri_escape_utf8($_) } @$p{qw/zipcode siku_char cho_char/};
    return redirect uri_for("/list/1")
        . qq{?zipcode=$zipcode&siku_char=$siku_char&cho_char=$cho_char};
  }
  $p = {
    rows     => 10,
    order_by => { -asc => qw/zipcode/ },
    page     => 1,
    %$p
  };
  my ( $zipcode, $siku_char, $cho_char, $rows, $order_by, $page )
      = @$p{qw/zipcode siku_char cho_char rows order_by page/};
  my $where = {};
  $where->{zipcode}   = { -like => "$zipcode%" }    if defined $zipcode;
  $where->{siku_char} = { -like => "%$siku_char%" } if defined $siku_char;
  $where->{cho_char}  = { -like => "%$cho_char%" }  if defined $cho_char;
  my ( $entries, $pager ) = $model->list(
    { where    => $where,
      rows     => $rows,
      order_by => $order_by,
      page     => $page,
    }
  );
  template 'list',
      {
    entries => $entries,
    pager   => $pager,
    %$p,
      };
}

sub confirm {
  my $self = shift;
  my ( $model, $p ) = @_;
  my $entry = { id => $p->{id} };
  template 'confirm', { entry => $entry, %$p };
}

1;
