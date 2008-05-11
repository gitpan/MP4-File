################################################################################
#
#  $Revision: 6 $
#  $Author: mhx $
#  $Date: 2008/05/11 04:17:43 +0200 $
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
use lib 'support';
use ExtUtils::MakeMaker;
use Devel::CheckLib;

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
                    EXTRA_META => <<'META';
no_index:
    directory:
        - support
META
  }

  print "Checking for a C compiler and libmp4v2...\n";

  eval { assert_lib(lib => 'mp4v2', header => 'mp4.h') };

  if ($@) {
    warn <<EOM;

$@
There either is a problem with your C compiler or you
don't have mpeg4ip or the mp4v2 library installed.

This module cannot be built without a C compiler, and
please make sure to install the mp4v2 library before
attempting to build this module.

  http://mpeg4ip.net/
  http://resare.com/libmp4v2/

EOM

    exit 0;
  }

  return { @moreopts };
}
