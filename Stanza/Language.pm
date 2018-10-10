package Stanza::Language;

use strict;
use warnings;
use utf8;

use FindBin qw($RealBin);
use lib "$RealBin";
use DownloadFile;

sub new {
  my ($class, %args) = @_;

  my $self = {};
  bless $self, $class;

  $self->{_language_line} = $args{language_line};
  $self->{_sha256_line} = $args{sha256_line};
  $self->{_localized_line} = $args{localized_line};
  $self->{_language} = $args{language};
  $self->{_localized} = $args{localized};
  $self->{_url} = $args{URL};

  return $self;
}

sub lines {
  my $self = shift;

  my $language = $self->{_language};
  my $localized = $self->{_localized};

  print STDERR "downloading $language [$localized] ...";

  my $url = $self->{_url};
  my $download_file = DownloadFile->new(URL => $url);

  $download_file->download;
  say STDERR ' done';

  my $sha256 = $download_file->SHA256;

  $download_file->remove;

  my $sha256_line = $self->{_sha256_line};
  $sha256_line =~ s/'[\da-f]+'/'$sha256'/;

  return ($self->{_language_line}, $sha256_line, $self->{_localized_line});
}

1;
