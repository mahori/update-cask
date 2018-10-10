package Stanza::SHA256;

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

  $self->{_line} = $args{line};
  $self->{_url} = $args{URL};

  return $self;
}

sub lines {
  my $self = shift;

  my $url = $self->{_url};
  my $download_file = DownloadFile->new(URL => $url);

  print STDERR 'downloading ...';
  $download_file->download;
  say STDERR ' done';

  my $sha256 = $download_file->SHA256;

  $download_file->remove;

  my $line = $self->{_line};
  $line =~ s/'[\da-f]+'/'$sha256'/;

  return ($line);
}

1;
