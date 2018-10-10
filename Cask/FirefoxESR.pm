package Cask::FirefoxESR;

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
  my $language = $args{language};

  unless ($version && $language) {
    return undef;
  }

  return "https://download-installer.cdn.mozilla.net/pub/firefox/releases/${version}esr/mac/$language/Firefox%20${version}esr.dmg";
}

1;
