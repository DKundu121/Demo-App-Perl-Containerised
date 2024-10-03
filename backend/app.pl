use Mojolicious::Lite -signatures;
use lib 'lib';
use Repository;

my $repo = Repository->new();

# Enable CORS
app->hook(before_dispatch => sub ($c) {
  $c->res->headers->header('Access-Control-Allow-Origin' => '*');
  $c->res->headers->header('Access-Control-Allow-Methods' => 'GET, POST, OPTIONS');
  $c->res->headers->header('Access-Control-Allow-Headers' => 'Content-Type');
});

get '/api/papers' => sub ($c) {
  my $query = $c->param('q') // '';
  my $papers = $repo->search_papers($query);
  $c->render(json => $papers);
};

get '/api/paper/:id' => sub ($c) {
  my $id = $c->param('id');
  my $paper = $repo->get_paper($id);
  $c->render(json => $paper);
};

app->start('daemon', '-l', 'http://*:3000');