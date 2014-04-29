#!/bin/env perl
use strict;
use warnings;
use Image::LibRSVG;
use File::Basename;
use Archive::Zip;

  my $rsvg = new Image::LibRSVG();
  my @svgs = glob "./src/*.svg";
  
  mkdir "./dist";

  for my $svg(@svgs){

    my $svg_filename = basename($svg, '.svg');
    my $png = sprintf("./dist/%s.png", $svg_filename);

    my ($x,$y) = (370,320);
    if ($svg_filename eq "main"){
      $x = 240;
      $y = 240;
    }
    if ($svg_filename eq "tab"){
      $x = 96;
      $y = 74;
    }

    printf "convert $svg->$png\n", $svg, $png;
    $rsvg->convertAtSize($svg, $png, $x, $y);

  }

  my $zip = Archive::Zip->new();
  my $dir_member = $zip->addDirectory( 'dist/' );
  my @pngs = glob "./dist/*.png"; 

  for my $png(@pngs){
    my $file_member = $zip->addFile( $png );
  }

  unless ( $zip->writeToFileNamed('./stamp.zip') == Archive::Zip::AZ_OK ) {
       die 'write error';
   }

