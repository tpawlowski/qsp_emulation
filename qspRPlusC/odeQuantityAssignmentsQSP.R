#####################################################################################################
# Version: 2.0.0.28
# Date/time: 23 May 2020 17.28.05
# QSP workspace: CIC_v2.2.6
# Simcyp workspace: Not Loaded
#####################################################################################################

#####################################################################################################
# Does assignments to quantities that are repeatedly assigned
#####################################################################################################
odeQuantityAssignmentsQSP = function(t, s, p){
    retVal <- .C("odeQuantityAssignmentsWithParamsArgQSP", PACKAGE = "ODEFunctions_9bfe43bb-b992-4c07-9082-848b89d72e5f", tInput = as.double(t), s = as.double(s), pInput = as.double(p));

    for(i in 1:length(s)){
        s[i] <- retVal$s[i];
    }
    for(i in 1:length(p)){
        p[i] <- retVal$pInput[i];
    }


    assigned <- list();
    assigned$s <- s;
    assigned$p <- p;
    return(assigned);
}
