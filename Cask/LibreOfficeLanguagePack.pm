package Cask::LibreOfficeLanguagePack;

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

  return "https://download.documentfoundation.org/libreoffice/stable/$version/mac/x86_64/LibreOffice_${version}_MacOS_x86-64_langpack_$language.dmg";
}

1;