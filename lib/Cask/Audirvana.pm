package Cask::Audirvana;

use strict;
use warnings;
use utf8;

use FindBin qw($RealBin);
use lib "$RealBin/lib";
use base qw(Cask::Base);

sub new {
  my ($class, %args) = @_;

  my $self = $class->SUPER::new(version => $args{version});
  bless $self, $class;

  return $self;
}

sub url {
  my ($self, %args) = @_;

  my $version = $self->{_version};

  unless ($version) {
    return undef;
  }

  return "https://audirvana.com/delivery/Audirvana_${version}.dmg";
}

1;
