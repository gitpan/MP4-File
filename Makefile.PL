################################################################################
#
#  $Revision: 5 $
#  $Author: mhx $
#  $Date: 2008/04/20 23:37:09 +0200 $
#
################################################################################
# 
# Copyright (c) 2008 Marcus Holland-Moritz. All rights reserved.
# This program is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.
# 
################################################################################

require 5.008;

use strict;
use ExtUtils::MakeMaker;
use IO::File;
use Config;

my %prereq = (
  'Test::More' => '0.45',
  'Encode'     => '1.75',
);

WriteMakefile(
  NAME          => 'MP4::File',
  VERSION_FROM  => 'lib/MP4/File.pm',
  PREREQ_PM     => \%prereq,
  LIBS          => ['-lmp4v2'],
  ABSTRACT_FROM => 'lib/MP4/File.pm',
  realclean     => { FILES => 'copy.m4a' },
  CONFIGURE     => \&configure,
);

sub configure
{
  my @moreopts;

  if (eval $ExtUtils::MakeMaker::VERSION >= 6) {
    push @moreopts, AUTHOR => 'Marcus Holland-Moritz <mhx@cpan.org>',
                    ABSTRACT_FROM => 'lib/MP4/File.pm';
  }

  if (eval $ExtUtils::MakeMaker::VERSION >= 6.30_01) {
    print "Setting license tag...\n";
    push @moreopts, LICENSE => 'perl';
  }

  print "Checking for a C compiler...\n";

  unless (test_compile(<<ENDC)) {
int main() { return 0; }
ENDC
    die <<EOM;

You don't seem to have a C compiler installed.

This module cannot be built without a C compiler.

EOM
  }

  print "Checking for libmp4v2 header...\n";

  unless (test_compile(<<ENDC)) {
#include <mp4.h>
int main() { return 0; }
ENDC
    die <<EOM;

You don't seem to have mpeg4ip or the mp4v2 library installed.

Please make sure to install the mp4v2 library before attempting
to build this module.

  http://mpeg4ip.net/
  http://resare.com/libmp4v2/

EOM
  }

  return { @moreopts };
}

sub test_compile
{
  my $code = shift;
  my $base = 'test';
  my $file = "$base.c";
  my $fh = IO::File->new(">$file") or die "$file: $!\n";
  $fh->print($code);
  undef $fh;
  my $obj = "$base$Config{obj_ext}";
  my $ok = not system "$Config{cc} $Config{ccflags} -o $obj $file";
  unlink $file, $obj;
  return $ok;
}
