package ZipApp;
use strict;
use warnings;
use Dancer;
use URI::Escape;
use ZipApp::Model;
use ZipApp::View;
use Dancer::Plugin::Auth::Twitter::Lite; # not cpan module

auth_twitter_init();

hook before => sub {
  var view  => ZipApp::View->new();
  var model => ZipApp::Model->new();

  my $request_path = request->path;
  return if $request_path =~ m{^/auth/twitter/callback};
  return if $request_path =~ m{^/fail};
  return if $request_path !~ m{^/entry};
  if ( not session('twitter_user') ) {
    #request->params->{'screen_name'} = undef;
    session '_stash' => { request_path => $request_path };
    return redirect auth_twitter_authenticate_url;
  }
  #request->params->{'screen_name'} = session('twitter_user')->{'screen_name'};
};

get '/success' => sub {
  my $request_path = session('_stash')->{request_path};
  session '_stash' => { request_path => undef };
  return redirect uri_for( $request_path );
};

get '/fail' => sub {"FAIL"};

get '/logout' => sub {
  session->destroy();
  return "Logout";
};

get '/' => sub {
  redirect '/list';
};

get qr{/entry/?} => sub {
  my ( $view, $model ) = @{ scalar vars }{qw/view model/};
  $view->entry( $model, {} );
};

get qr{/entry/(\d+)} => sub {
  my ($id) = splat;
  my ( $view, $model ) = @{ scalar vars }{qw/view model/};
  $view->entry( $model, { id => $id } );
};

post qr{/entry/?} => sub {
  my ( $view,   $model )     = @{ scalar vars }{qw/view model/};
  my ( $action, $subaction ) = @{ scalar params }{qw/action subaction/};
  if ( $action eq 'Create' ) {
    my $id = eval { $model->create( {params} ); };
    return redirect "/entry/$id" unless $@;
    params->{flash} = $@;
  }
  else {
    die "Can't happen";
  }
  $view->entry( $model, { params, id => 0, } );
};

any [qw/put post/] => qr{/entry/(\d+)} => sub {
  my ($id) = splat;
  my ( $view,   $model )     = @{ scalar vars }{qw/view model/};
  my ( $action, $subaction ) = @{ scalar params }{qw/action subaction/};
  if ( $action eq 'Update' ) {
    eval { $model->update( { id => $id, params } ) };
    return redirect "/entry/$id" unless $@;
    params->{flash} = $@;
    return $view->entry( $model, { params, id => $id } );
  }
  elsif ( $action eq 'Delete' and $subaction eq 'exec' ) {
    return $view->confirm( $model, { id => $id, params } );
  }
  die "Can't happen";
};

get qr{/list/?} => sub {
  foreach my $key (qw/zipcode siku_char cho_char/) {
    session $key => undef;
  }
  template 'list', {};
};

post qr{/list/?} => sub {
  my ( $view, $model ) = @{ scalar vars }{qw/view model/};
  foreach my $key (qw/zipcode siku_char cho_char/) {
    session $key => params->{$key};
  }
  session page => 1;
  $view->list( $model, { params, method => "POST", page => 1, } );
};

get qr{/list/(\d+)} => sub {
  my ($page) = splat;
  my ( $view, $model ) = @{ scalar vars }{qw/view model/};
  foreach my $key (qw/zipcode siku_char cho_char/) {
    session $key => params->{$key};
  }
  session page => $page;
  $view->list( $model, { params, method => "GET", page => $page, } );
};

any [qw/post delete/] => qr{/delete/(\d+)} => sub {
  my ($id) = splat;
  my ( $view,   $model )     = @{ scalar vars }{qw/view model/};
  my ( $action, $subaction ) = @{ scalar params }{qw/action subaction/};
  if ( $action eq 'Delete' ) {
    eval { $model->delete($id) };
    if ( $@ eq "" ) {
      my $zipcode   = session->{zipcode};
      my $siku_char = session->{siku_char};
      my $cho_char  = session->{cho_char};
      my $page      = session->{page};
      return
            redirect "/list/"
          . uri_escape_utf8($page)
          . "?zipcode="
          . uri_escape_utf8($zipcode)
          . "&siku_char="
          . uri_escape_utf8($siku_char)
          . "&cho_char="
          . uri_escape_utf8($cho_char);
    }
    params->{flash} = $@;
    return $view->entry( $model, {params} );
  }
  else {
    return $view->entry( $model, { id => $id } );
  }
};

1;
