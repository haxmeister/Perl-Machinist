use v5.40;
use warnings qw(-experimental);
use feature "class";

class Machinist::Math::Imperial :isa(Machinist::Math){
use DDP;
    method rpm(%params){
        my $calc  = $self->SUPER::rpm(%params) * 12;
        return $calc;
    }
    
    # inches per minute
    method ss(%params){
        my $calc = $self->SUPER::ss(%params) / 12;
        return $calc;
    }

    # cubic inches per minute milling
    method mill_mrr(%params){
        my $calc = $self->SUPER::mill_mrr(%params);
        return $calc;
    }

    # cubic inches per minute turning
    method turn_mrr(%params){
        $params{ss} *= 12; # convert feet to inches
        my $calc = $self->SUPER::turn_mrr(%params);
        return $calc;
    }
    
    # cubic inches per minute drilling
    method drill_mrr(%params){
        my $calc = $self->SUPER::drill_mrr(%params);
        return $calc;
    }
}
