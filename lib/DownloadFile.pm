package DownloadFile;

use strict;
use warnings;
use utf8;
use File::Temp qw(tempfile);

use FindBin qw($RealBin);
use lib "$RealBin/lib";
use SHA256;

sub new {
  my ($class, %args) = @_;

  my $self = {};
  bless $self, $class;

  $self->{_url} = $args{URL};
  $self->{_filename} = undef;

  return $self;
}

sub download {
  my $self = shift;

  my $url = $self->{_url};

  my ($fh, $filename) = tempfile;
  system "wget -q -O '$filename' '$url'";
  close $fh;

  if (-z $filename) {
    unlink $filename;
    return;
  }

  $self->{_filename} = $filename;
}

sub remove {
  my $self = shift;

  my $filename = $self->{_filename};

  unless ($filename && -s $filename) {
    return;
  }

  unlink $filename;
}

sub SHA256 {
  my $self = shift;

  my $filename = $self->{_filename};

  my $sha256 = SHA256->new(filename => $filename);

  return $sha256->SHA256;
}

1;
