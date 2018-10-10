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

    # version stanza
    if ($line =~ /\A\h*version\h*'([\d.]+)'\h*/) {
      $line =~ s/$1/$self->{_version}/;
    }

    # sha256 stanza
    if ($line =~ /\A\h*sha256\h*'([A-Fa-f0-9]+)'\h*/) {
      my $cask = $self->{_cask};
      my $url = $cask->url;
      my $download_file = DownloadFile->new(URL => $url);

      print STDERR 'downloading ...';
      $download_file->download;
      say STDERR ' done';

      my $sha256 = $download_file->SHA256;

      $download_file->remove;

      $line =~ s/'[\da-f]+'/'$sha256'/;
    }

    # language stanza
    if ($line =~ /\A\h*language\h*'([-A-Za-z]+)'\h*/) {
      my $language = $1;

      my $line_sha256 = <$fh_in>;
      chomp $line_sha256;

      my $line_language = <$fh_in>;
      chomp $line_language;

      my $localized;
      if ($line_language =~ /'([-A-Za-z]+)'/) {
        $localized = $1;
      }

      if ($language && $localized) {
        my $cask = $self->{_cask};
        my $download_url = $cask->url(language => $localized);

        my $download_file = DownloadFile->new(URL => $download_url);

        print STDERR "downloading $language [$localized] ...";
        $download_file->download;
        say STDERR ' done';

        my $sha256 = $download_file->SHA256;

        $download_file->remove;

        $line_sha256 =~ s/'[\da-f]+'/'$sha256'/;
      }

      say $fh_out $line;
      say $fh_out $line_sha256;
      say $fh_out $line_language;

      next;
    }

    say $fh_out $line;
  }

  close $fh_out;
  close $fh_in;
}

1;
