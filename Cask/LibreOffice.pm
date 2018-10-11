package Cask::LibreOffice;

use strict;
use warnings;
use utf8;

use FindBin qw($RealBin);
use lib "$RealBin";
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

  return "https://download.documentfoundation.org/libreoffice/stable/$version/mac/x86_64/LibreOffice_${version}_MacOS_x86-64.dmg";
}

1;
