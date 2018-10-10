package Cask::UniversalMediaServer;

use strict;
use warnings;
use utf8;

sub new {
  my ($class, %args) = @_;

  my $self = {};
  bless $self, $class;

  $self->{_version} = $args{version};

  return $self;
}

sub url {
  my ($self, %args) = @_;

  my $version = $self->{_version};

  unless ($version) {
    return undef;
  }

  return "https://downloads.sourceforge.net/unimediaserver/Official%20Releases/OS%20X/UMS-${version}.dmg";
}

1;
