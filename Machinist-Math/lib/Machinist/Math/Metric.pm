use v5.40;
use warnings qw(-experimental);
use feature "class";

class Machinist::Math::Metric :isa(Machinist::Math){

    method rpm(%params){
        my $calc  = $self->SUPER::rpm(%params) * 1000;
        return $calc;
    }

    # meters per minute
    method ss(%params){
        my $calc = $self->SUPER::ss(%params) / 1000;
        return $calc;
    }

    # cubic centimeters per minute in milling
    method mill_mrr(%params){
        my $calc = $self->SUPER::mill_mrr(%params) / 10;
        return $calc;
    }

    # cubic centimeters per minute in turning
    method turn_mrr(%params){
        $params{ss} *= 1000; # convert meters to millimeters
        my $calc = $self->SUPER::turn_mrr(%params);
        return $calc;
    }
    
    # cubic centimeters per minute drilling
    method drill_mrr(%params){
        my $calc = $self->SUPER::turn_mrr(%params) / 10;
        return $calc;
    }
}
