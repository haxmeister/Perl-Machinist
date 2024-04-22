
=head1 SYNOPSIS

 my $imp    = Machine::Calculator->new(units => 'imperial');
 my $metric = Machine::Calculator->new(units => 'metric');

 say "rpm";
 say $imp->rpm (180.4, 1);
 say $metric->rpm (55, 25.4);

 say "surface speed";
 say $imp->surface_speed (3000, 1)." surface feet per minute";
 say $metric->surface_speed (3000, 25.4)." surface meters per minute";

 say "feed per minute";
 say $imp->feed_per_minute(3000, 4, .004)." inches per minute";
 say $metric->feed_per_minute(3000, 4, .1016)." millimeters per minute";

 say "feed per revolution";
 say $imp->feed_per_rev (3000, 48)." inches per revolution";
 say $metric->feed_per_rev (3000, 1219.2)." millimeters per revolution";

 say "feed per tooth";
 say $imp->feed_per_tooth (4, 48, 3000)." inches per tooth";
 say $metric->feed_per_tooth (4, 1219.2, 3000)." millimeters per tooth";

 say "material removal rate when milling";
 say $imp->removal_rate_milling(1, .5, 48)." cubic inches per minute";
 say $metric->removal_rate_milling(25.4, 12.7, 1219.2)." cubic centimeters per minute";

 say "removal rate when turning";
 say $imp->removal_rate_turning(.125, .012, 180.4)." cubic inches per minute";
 say $metric->removal_rate_turning(3.175, .3048, 55)." cubic centimeters per minute";

 say "removal rate when drilling";
 say $imp->removal_rate_drilling(.5, .004, 180.4)." cubic inches per minute";
 say $imp->removal_rate_drilling(12.7, .1016, 55)." cubic inches per minute";


=head1 DESCRIPTION

This class provides functions commonly used by machinists when calculating
everything from feed rates to material removal rates. It uses the class keyword
to reduce the amount of code required. This module is intended to provide
return values in the units of measure that machinists expect, even when this
makes the underlying math more combersome to implement. For instance, machinists
using imperial measures will expect feet or inches depending on the calculation
being done but machinists using metric may use meters, centimeters and
millimeters. Please pay close attention to the units that these methods are
documented to return.

=cut

use v5.38;
use feature 'class';
use warnings -experimental;

class Machine::Calculator 0.1;
use constant PI    => 4 * atan2(1, 1);

field $units :param //= "imperial";
=head1 Methods

=head2 rpm

 rpm( <surface speed>, <diameter> )

where <surface speed> is in "meters per minute" (metric) or "feet per minute" (imperial).

where <diameter> is in millimeters (metric) or inches (imperial)

Returns the "rounds per minute" or rpm

=cut

method rpm ($surface_speed, $d){
    if($units eq "imperial"){
        return ($surface_speed * 12) / (PI * $d);
    }elsif($units eq "metric"){
        return ($surface_speed * 1000) / (PI * $d);
    }
}

=head2 surface_speed

 surface_speed ( <RPM>, <diameter> )

where diameter is in millimeters (metric) or inches (imperial)

returns the surface speed in "meters per minute" (metric) or "feet per minute" (imperial)

=cut

method surface_speed ($rpm, $d){
    if($units eq "imperial"){
        return ($rpm * ($d * PI)) / 12;
    }elsif($units eq "metric"){
        return ($rpm * ($d * PI)) / 1000;
    }

}

=head2 feed_per_minute

 feed_per_minute ( <RPM>, <number of flutes>, <feed per flute> )

where the "feed per flute" is in millimeters (metric) or inches (imperial)

returns the feed in "millimeters per minute" (metric) or "inches per minute" (imperial)

=cut

method feed_per_minute ($rpm, $z, $fpt){
    if($units eq "imperial"){
        return $rpm * $fpt * $z;
    }elsif($units eq "metric"){
        return $rpm * $fpt * $z;
    }
}

=head2 feed_per_rev

 feed_per_rev ( <RPM>, <feed per minute> )

where "feed per minute" is in millimeters (metric) or inches (imperial)

returns the feed in "millimeters per revolution" (metric) or "inches per revolution" (imperial)

=cut

method feed_per_rev ($rpm, $feed_per_minute){
    return $feed_per_minute / $rpm;
}

=head2 feed_per_tooth

 feed_per_tooth ( <number of flutes>, <feed per minute>, <RPM> )

where "feed per minute" is in millimeters (metric) or inches (imperial)

returns the feed in "millimeters per tooth" (metric) or "inches per tooth" (imperial)

=cut

method feed_per_tooth ($z, $feed_per_minute, $rpm){
    return ($feed_per_minute/$rpm)/$z;
}

=head2 removal_rate_milling

 removal_rate_milling( <width of cut>, <depth of cut>, <feed per minute>)

where "feed per minute" is in millimeters (metric) or inches (imperial)

returns the material removal rate in cubic centimeters (metric) or cubic inches (imperial)

=cut

method removal_rate_milling($woc, $doc, $feed_per_minute){
    if($units eq "imperial"){
        return $woc * $doc * $feed_per_minute;
    }elsif($units eq "metric"){
        return $woc * $doc * $feed_per_minute / 1000 ;
    }
}

=head2 removal_rate_turning

 removal_rate_turning( <depth of cut>, <feed per revolution>, <surface speed>)

where "depth of cut" is in millimeters (metric) or inches (imperial). This is
using a radial value, not diametric (some CNC lathes use diametric values when setting DOC).

where "feed per revolution" is in millimeters (metric) or inches (imperial)

returns the material removal rate in cubic centimeters (metric) or cubic inches (imperial)

=cut

method removal_rate_turning($doc, $feed_per_rev, $surface_speed){
    if($units eq "imperial"){
        return  $doc * $feed_per_rev * $surface_speed * 12;
    }elsif($units eq "metric"){
        return  $doc * $feed_per_rev * $surface_speed;
    }
}

=head2 removal_rate_drilling

 removal_rate_drilling( <diameter>, <feed per revolution>, <surface speed> )

where "diameter" is in millimeters (metric) or inches (imperial).

where "feed per revolution" is in millimeters (metric) or inches (imperial)

where "surface speed" is in "meters per minute" (metric) or "feet per minute" (imperial)

returns the material removal rate in cubic centimeters (metric) or cubic inches (imperial)

=cut

method removal_rate_drilling($d, $feed_per_rev, $surface_speed){
    if($units eq "imperial"){
        return  ($d * $feed_per_rev * $surface_speed * 12) / 4;
    }elsif($units eq "metric"){
        return  $d * $feed_per_rev * $surface_speed * 3;
    }
}

# ABSTRACT: A class providing functions that are commonly used by machinists using the new class keyword.

__END__


=head1 BUGS

Please report bugs to the Github repository for this project.

L<https://github.com/haxmeister/Perl-Machinist>


=head1 AUTHOR

HAX (Joshua S. Day)
E<lt>haxmeister@hotmail.comE<gt>

=head1 LICENSE & COPYRIGHT

This software is copyright (c) 2024 by Joshua S. Day.

This is free software; you can redistribute it and/or modify it under the same
terms as the Perl 5 programming language system itself.
