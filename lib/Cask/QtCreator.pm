package Cask::QtCreator;

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

  my ($version_major, $version_minor) = split /\./, $version;
  my $version_major_minor = join '.', $version_major, $version_minor;

  return "https://download.qt.io/official_releases/qtcreator/${version_major_minor}/${version}/qt-creator-opensource-mac-x86_64-${version}.dmg";
}

1;
