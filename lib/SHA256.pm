package SHA256;

use strict;
use warnings;
use utf8;

sub new {
  my ($class, %args) = @_;

  my $self = {};
  bless $self, $class;

  $self->{_filename} = $args{filename};

  return $self;
}

sub SHA256 {
  my $self = shift;

  my $filename = $self->{_filename};

  unless ($filename) {
    return undef;
  }

  open my $fh, '-|', "shasum -a 256 $filename";
  my $line = <$fh>;
  close $fh;

  my ($sha256) = split '\h+', $line;

  return $sha256;
}

1;
