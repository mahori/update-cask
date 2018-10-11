package CaskFile;

use strict;
use warnings;
use utf8;
use feature qw(say);

use FindBin qw($RealBin);
use lib "$RealBin";
use Cask::Firefox;
use Cask::FirefoxESR;
use Cask::LibreOffice;
use Cask::LibreofficeLanguagePack;
use Cask::Thunderbird;
use Cask::UniversalMediaServer;
use DownloadFile;
use Stanza::Language;
use Stanza::SHA256;
use Stanza::Version;

sub new {
  my ($class, %args) = @_;

  my $self = {};
  bless $self, $class;

  $self->{_input_filename} = $args{input_filename};
  $self->{_output_filename} = $args{output_filename};

  my $cask_name = $args{cask_name};
  my $version = $args{version};

  $self->{_cask} = "Cask::$cask_name"->new(version => $version);
  $self->{_version} = $version;

  return $self;
}

sub update {
  my $self = shift;

  my $input_filename = $self->{_input_filename};
  my $output_filename = $self->{_output_filename};

  open my $fh_in, '<', $input_filename or die "$!: $input_filename";
  open my $fh_out, '>', $output_filename or die "$!: $output_filename";

  while (my $line = <$fh_in>) {
    chomp $line;

    my @lines = ($line);

    # version stanza
    if ($line =~ /\A\h*version\h*'([\d.]+)'\h*/) {
      my $stanza = Stanza::Version->new(cask => $self->{_cask},
                                        line => $line);

      @lines = $stanza->lines;
    }

    # sha256 stanza
    if ($line =~ /\A\h*sha256\h*'([A-Fa-f0-9]+)'\h*/) {
      my $stanza = Stanza::SHA256->new(cask => $self->{_cask},
                                       line => $line);

      @lines = $stanza->lines;
    }

    # language stanza
    if ($line =~ /\A\h*language\h*'([-A-Za-z]+)'\h*/) {
      my $sha256_line = <$fh_in>;
      chomp $sha256_line;

      my $localized_line = <$fh_in>;
      chomp $localized_line;

      my $stanza = Stanza::Language->new(cask => $self->{_cask},
                                         language_line => $line,
                                         sha256_line => $sha256_line,
                                         localized_line => $localized_line);

      @lines = $stanza->lines;
    }

    say $fh_out join("\n", @lines);
  }

  close $fh_out;
  close $fh_in;
}

1;
