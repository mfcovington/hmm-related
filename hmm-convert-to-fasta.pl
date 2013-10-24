#!/usr/bin/env perl
# Mike Covington
# created: 2013-10-23
#
# Description: Converts data to Fasta format for HMM analysis
#
use strict;
use warnings;
use autodie;
use feature 'say';
use Getopt::Long;

my $input_file;
my $fasta_file;
my $help;

my $options = GetOptions (
    "input_file=s" => \$input_file,
    "fasta_file=s" => \$fasta_file,
    "help"         => \$help,
);

my $usage = <<USAGE;
Usage:
  $0 --input_file INPUT.CSV --fasta_file OUTPUT.FA
USAGE

die $usage if $help;
die $usage unless
  defined $input_file &&
  defined $fasta_file;

my %convert_ids = (
    't.m82' => 'M82',
    't.pen' => 'PEN',
    't.het' => 'HET',
    'intd'  => 'DISTANCE',
);

open my $input_fh, "<", $input_file;
open my $fasta_fh,    ">", $fasta_file;
for (<$input_fh>) {
    chomp;
    my ( $id, @scores ) = split /,/;
    say $fasta_fh ">$convert_ids{$id}";
    say $fasta_fh join " ", @scores;
}
close $input_fh;
close $fasta_fh;
exit;
