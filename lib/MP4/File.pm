################################################################################
#
#  $Revision: 2 $
#  $Author: mhx $
#  $Date: 2008/04/08 08:04:14 +0200 $
#
################################################################################
# 
# Copyright (c) 2008 Marcus Holland-Moritz. All rights reserved.
# This program is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.
# 
################################################################################

package MP4::File;

use strict;
use warnings;
use vars qw(@ISA @EXPORT_OK %EXPORT_TAGS $VERSION $XS_VERSION);
use XSLoader;
use Exporter;

@ISA = qw( Exporter );

$VERSION = do { my @r = '$Snapshot: /MP4-File/0.02 $' =~ /(\d+\.\d+(?:_\d+)?)/; @r ? $r[0] : '9.99' };
$XS_VERSION = $VERSION;
$VERSION = eval $VERSION;

XSLoader::load 'MP4::File', $XS_VERSION;

%EXPORT_TAGS = (
  constants => [qw(
    MP4_OD_TRACK_TYPE
    MP4_SCENE_TRACK_TYPE
    MP4_AUDIO_TRACK_TYPE
    MP4_VIDEO_TRACK_TYPE
    MP4_HINT_TRACK_TYPE
    MP4_CNTL_TRACK_TYPE
    MP4_CLOCK_TRACK_TYPE
    MP4_MPEG7_TRACK_TYPE
    MP4_OCI_TRACK_TYPE
    MP4_IPMP_TRACK_TYPE
    MP4_MPEGJ_TRACK_TYPE
  )],
);

@EXPORT_OK = map @$_, values %EXPORT_TAGS;

1;

__END__

=head1 NAME

MP4::File - Read/Write MP4 files

=head1 SYNOPSIS

  use MP4::File;

  $mp4 = MP4::File->new;
  $mp4->Modify($filename);
  $mp4->SetMetadataArtist("Dire Straits");

=head1 DESCRIPTION

Please refer to the libmp4v2 documentation.

=head1 AUTHOR

Marcus Holland-Moritz <mhx@cpan.org>

=cut

