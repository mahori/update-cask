package Cask::Thunderbird;

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
  my $language = $args{language};

  unless ($version && $language) {
    return undef;
  }

  return "https://ftp.mozilla.org/pub/thunderbird/releases/$version/mac/$language/Thunderbird%20$version.dmg";
}

1;
