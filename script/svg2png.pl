#!/bin/env perl
use Image::LibRSVG;
use File::Basename;
use Archive::Zip;
use Data::Dumper;

  my $rsvg = new Image::LibRSVG();
 my $formats       = Image::LibRSVG->getSupportedFormats();
  print Dumper($formats);
  my @svgs = glob "./src/*.svg"; 

  for $svg(@svgs){

    print $svg;
    my $svg = basename($svg, '.svg');
    my $png = sprintf("./dist/%s.png", $svg);
    print $png;

    my ($x,$y) = (370,320);
    if ($svg eq "main"){
      $x = 240;
      $y = 240;
    }
    if ($svg eq "tab"){
      $x = 96;
      $y = 74;
    }

    $rsvg->convertAtSize("./src/01.svg", "./dist/01.png", $x, $y);

  }

  my $zip = Archive::Zip->new();
  my $dir_member = $zip->addDirectory( 'dist/' );

  unless ( $zip->writeToFileNamed('./stamp.zip') == AZ_OK ) {
       die 'write error';
   }

