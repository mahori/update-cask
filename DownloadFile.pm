package DownloadFile;

use strict;
use warnings;
use utf8;
use File::Temp qw(tempfile);

use FindBin qw($RealBin);
use lib "$RealBin";
use SHA256;

sub new {
  my ($class, %args) = @_;

  my $self = {};
  bless $self, $class;

  $self->{_url} = $args{URL};

  return $self;
}

sub download {
  my $self = shift;

  my $url = $self->{_url};

  my ($fh_temp, $temp_filename) = tempfile;
  system "wget -q -O '$temp_filename' '$url'";
  close $fh_temp;

  if (-z $temp_filename) {
    unlink $temp_filename;
    return;
  }

  $self->{_temp_filename} = $temp_filename;
}

sub SHA256 {
  my $self = shift;

  my $sha256 = SHA256->new(filename => $self->{_temp_filename});

  return $sha256->SHA256;
}

sub remove {
  my $self = shift;

  my $temp_filename = $self->{_temp_filename};

  unless ($temp_filename && -s $temp_filename) {
    return;
  }

  unlink $temp_filename;
}

1;
