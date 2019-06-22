package Cask::TorBrowser;

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
  my $language = $args{language};

  unless ($version && $language) {
    return undef;
  }

  return "https://dist.torproject.org/torbrowser/${version}/TorBrowser-${version}-osx64_${language}.dmg";
}

1;
