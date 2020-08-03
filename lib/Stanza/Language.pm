package Stanza::Language;

use strict;
use warnings;
use utf8;

use FindBin qw($RealBin);
use lib "$RealBin/lib";
use Cask::Base;
use DownloadFile;

sub new {
  my ($class, %args) = @_;

  my $self = {};
  bless $self, $class;

  $self->{_cask} = $args{cask};
  $self->{_language_line} = $args{language_line};
  $self->{_sha256_line} = $args{sha256_line};
  $self->{_localized_line} = $args{localized_line};

  return $self;
}

sub lines {
  my $self = shift;

  $self->{_language_line} =~ m/\A\h*language\h*"([-A-Za-z]+)"[,\h]*/;
  my $language = $1;

  $self->{_localized_line} =~ m/"([-A-Za-z]+)"/;
  my $localized = $1;

  print STDERR "downloading $language [$localized] ...";

  my $cask = $self->{_cask};
  my $url = $cask->url(language => $localized);
  my $download_file = DownloadFile->new(URL => $url);

  if ($download_file->download) {
    say STDERR ' done';
  } else {
    say STDERR ' failed';
    exit 1;
  }

  my $sha256 = $download_file->SHA256;

  $download_file->remove;

  my $sha256_line = $self->{_sha256_line};
  $sha256_line =~ s/"[\da-f]+"/"$sha256"/;

  return ($self->{_language_line}, $sha256_line, $self->{_localized_line});
}

1;
