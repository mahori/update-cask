package Cask::FirefoxESR;

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

  return "https://download-installer.cdn.mozilla.net/pub/firefox/releases/${version}esr/mac/${language}/Firefox%20${version}esr.dmg";
}

1;
