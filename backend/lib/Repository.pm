package Repository;

use strict;
use warnings;
use DBI;

sub new {
    my $class = shift;
    my $self = {
        dbh => DBI->connect("DBI:SQLite:dbname=repository.db", "", "")
    };
    bless $self, $class;
    $self->_init_db();
    return $self;
}

sub _init_db {
    my $self = shift;
    $self->{dbh}->do("CREATE TABLE IF NOT EXISTS papers (
        id INTEGER PRIMARY KEY,
        title TEXT,
        author TEXT,
        content TEXT
    )");
    # Add some sample data if the table is empty
    my $count = $self->{dbh}->selectrow_array("SELECT COUNT(*) FROM papers");
    if ($count == 0) {
        $self->{dbh}->do("INSERT INTO papers (title, author, content) VALUES (?, ?, ?)", undef,
            "Introduction to Perl", "John Doe", "Perl is a highly capable, feature-rich programming language...");
        $self->{dbh}->do("INSERT INTO papers (title, author, content) VALUES (?, ?, ?)", undef,
            "Web Development with Mojolicious", "Jane Smith", "Mojolicious is a next generation web framework...");
    }
}

sub search_papers {
    my ($self, $query) = @_;
    my $sth = $self->{dbh}->prepare("SELECT id, title, author FROM papers WHERE title LIKE ? OR author LIKE ?");
    $sth->execute("%$query%", "%$query%");
    my @papers;
    while (my $row = $sth->fetchrow_hashref) {
        push @papers, $row;
    }
    return \@papers;
}

sub get_paper {
    my ($self, $id) = @_;
    my $sth = $self->{dbh}->prepare("SELECT * FROM papers WHERE id = ?");
    $sth->execute($id);
    return $sth->fetchrow_hashref;
}

1;