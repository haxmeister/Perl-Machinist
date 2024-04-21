use v5.38;
use feature 'class';
use warnings -experimental;

class Machine::Lathe::Calculator 0.1;

field $SFM   :param //= 0;
field $IPM   :param //= 0;
field $FPT   :param //= 0;
field $FPR   :param //= 0;
field $DOC   :param //= 0;
field $WOC   :param //= 0;
field $D     :param //= 0;
field $Z     :param //= 0;
field $AFPT;
field $MRR;


# method rpm ($nrpm //= 0){
#     if ($nrpm){
#         $rpm = $nrpm;
#         return $self;
#     }else{
#         return $rpm;
#     }
# }
#
# method sfm ($nsfm //= 0){
#     if ($sfm){
#         $sfm = $nsfm;
#         return $self;
#     }else{
#         return $sfm;
#     }
# }
#
# method dia ($ndia //= 0){
#     if ($ndia){
#         $dia = $ndia;
#         return $self;
#     }else{
#         return $dia;
#     }
# }
#
# method teeth ($nteeth //= 0){
#     if ($nteeth){
#         $teeth = $nteeth;
#         return $self;
#     }else{
#         return $teeth;
#     }
# }
#
# method clt ($nclt //= 0){
#     if ($nclt){
#         $clt = $nclt;
#         return $self;
#     }else{
#         return $clt;
#     }
# }

method calc_rpm ($sfm, $d){
    return ($sfm * 3.82)/$d;
}

method calc_sfm ($rpm, $d){
    return ($rpm * $d)/3.82;
}

method calc_ipm ($rpm, $z, $fpt){
    return $rpm * $fpt * $z;
}

method calc_fpr ($z, $rpm, $ipm){
    return ($ipm/$rpm)/$z;
}

=head2 calc_fpt ($z, $ipm, $rpm)

Required arguments:
$z    = the number of effective teeth the cutter has
$ipm  = the inches per minute the tool is moving
$rpm  = the revolutions per minute that the tool is spinning
returns a value that is the chip thickness per tooth when cutting

=cut
method calc_fpt ($z, $ipm, $rpm){
    return ($ipm/$rpm)/$z;
}
