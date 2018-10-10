package Stanza::Version;

use strict;
use warnings;
use utf8;

sub new {
  my ($class, %args) = @_;

  my $self = {};
  bless $self, $class;

  $self->{_line} = $args{line};
  $self->{_version} = $args{version};

  return $self;
}

sub lines {
  my $self = shift;

  my $line = $self->{_line};
  $line =~ m/\A\h*version\h*'([\d.]+)'\h*/;

  my $old_version = $1;
  my $new_version = $self->{_version};

  $line =~ s/$old_version/$new_version/;

  return ($line);
}

1;
