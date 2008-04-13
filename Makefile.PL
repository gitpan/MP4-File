################################################################################
#
#  $Revision: 3 $
#  $Author: mhx $
#  $Date: 2008/04/13 14:03:21 +0200 $
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

  return { @moreopts };
}

