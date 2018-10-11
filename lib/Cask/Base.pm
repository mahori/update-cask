package Cask::Base;

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

  return undef;
}

sub version {
  my $self = shift;

  return $self->{_version};
}

1;
