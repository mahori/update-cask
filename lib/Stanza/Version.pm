package Stanza::Version;

use strict;
use warnings;
use utf8;

use FindBin qw($RealBin);
use lib "$RealBin/lib";
use Cask::Base;

sub new {
  my ($class, %args) = @_;

  my $self = {};
  bless $self, $class;

  $self->{_cask} = $args{cask};
  $self->{_line} = $args{line};

  return $self;
}

sub lines {
  my $self = shift;

  my $line = $self->{_line};
  $line =~ m/\A\h*version\h*'([\d.]+)'\h*/;
  my $old_version = $1;

  my $cask = $self->{_cask};
  my $new_version = $cask->version;

  $line =~ s/$old_version/$new_version/;

  return ($line);
}

1;
