#####################################################################################################
# Version: 2.0.0.28
# Date/time: 23 May 2020 17.28.05
# QSP workspace: CIC_v2.2.6
# Simcyp workspace: Not Loaded
#####################################################################################################

#####################################################################################################
# Performs required actions for the dose event identified
#####################################################################################################
doseEventQSP = function(
    t,        # Simulation time
    s,        # State
    p,        # Parameters
    doseIsOn  # Contains bools that specify whether a given dose is on
){
    odeQuantityAssignmentsQSP(t, s, p);

    if(t == 0) {
        s["antiPD1_IS"] <- s["antiPD1_IS"] + 4.794521E-06;
    } else if(t == 21) {
        s["antiPD1_IS"] <- s["antiPD1_IS"] + 4.794521E-06;
    } else if(t == 42) {
        s["antiPD1_IS"] <- s["antiPD1_IS"] + 4.794521E-06;
    } else if(t == 63) {
        s["antiPD1_IS"] <- s["antiPD1_IS"] + 4.794521E-06;
    } else if(t == 84) {
        s["antiPD1_IS"] <- s["antiPD1_IS"] + 4.794521E-06;
    } else if(t == 105) {
        s["antiPD1_IS"] <- s["antiPD1_IS"] + 4.794521E-06;
    } else if(t == 126) {
        s["antiPD1_IS"] <- s["antiPD1_IS"] + 4.794521E-06;
    } else if(t == 147) {
        s["antiPD1_IS"] <- s["antiPD1_IS"] + 4.794521E-06;
    } else if(t == 168) {
        s["antiPD1_IS"] <- s["antiPD1_IS"] + 4.794521E-06;
    } else if(t == 189) {
        s["antiPD1_IS"] <- s["antiPD1_IS"] + 4.794521E-06;
    } else if(t == 210) {
        s["antiPD1_IS"] <- s["antiPD1_IS"] + 4.794521E-06;
    } else if(t == 231) {
        s["antiPD1_IS"] <- s["antiPD1_IS"] + 4.794521E-06;
    } else if(t == 252) {
        s["antiPD1_IS"] <- s["antiPD1_IS"] + 4.794521E-06;
    } else if(t == 273) {
        s["antiPD1_IS"] <- s["antiPD1_IS"] + 4.794521E-06;
    } else if(t == 294) {
        s["antiPD1_IS"] <- s["antiPD1_IS"] + 4.794521E-06;
    } else if(t == 315) {
        s["antiPD1_IS"] <- s["antiPD1_IS"] + 4.794521E-06;
    } else if(t == 336) {
        s["antiPD1_IS"] <- s["antiPD1_IS"] + 4.794521E-06;
    } else if(t == 357) {
        s["antiPD1_IS"] <- s["antiPD1_IS"] + 4.794521E-06;
    } else if(t == 378) {
        s["antiPD1_IS"] <- s["antiPD1_IS"] + 4.794521E-06;
    } 

    dosed <- list();
    dosed$s <- s;
    dosed$doseIsOn <- doseIsOn;
    return(dosed);
}
