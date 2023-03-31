#####################################################################################################
# Version: 2.0.0.28
# Date/time: 23 May 2020 17.28.05
# QSP workspace: CIC_v2.2.6
# Simcyp workspace: Not Loaded
#####################################################################################################

sourceDir <- getSrcDirectory(function(dummy) {});
if(0 < length(sourceDir)) {
    source(file.path(sourceDir, "odeQuantityAssignmentsQSP.R"));
} else {
    source("odeQuantityAssignmentsQSP.R");
}

#####################################################################################################
# Sets the values of the output state variables from current values of the simulation state variables
# Performs unit conversions as well as conversions from amounts to concentrations
#####################################################################################################
odeOutputQSP = function(
    t, # Simulation time
    s, # State
    p  # Parameters
){
    assigned <- odeQuantityAssignmentsQSP(t, s, p);
    s <- assigned$s;
    p <- assigned$p;

    sOutput <- vector();
    sOutput["t"] <- 24 * t;



    sOutput["antigens"] <- s["antigens"];
    sOutput["antiPD1"] <- 1000000000 * s["antiPD1"];
    sOutput["antiPD1_Central"] <- 1000000000 * s["antiPD1_Central"];
    sOutput["antiPD1_IS"] <- 1000000000 * s["antiPD1_IS"];
    sOutput["antiPD1_Peripheral"] <- 1000000000 * s["antiPD1_Peripheral"];
    sOutput["APC_ln"] <- s["APC_ln"];
    sOutput["APC_tme"] <- s["APC_tme"];
    sOutput["capacity"] <- s["capacity"];
    sOutput["Tc_ln"] <- s["Tc_ln"];
    sOutput["Tc_tme"] <- s["Tc_tme"];
    sOutput["Tumor"] <- s["Tumor"];

    sOutput["antiPD1_conc"] <- 1000 * p["antiPD1_conc"];
    sOutput["antiPD1_KD"] <- 1000000000 * p["antiPD1_KD"];
    sOutput["APC_frac"] <- p["APC_frac"];
    sOutput["APC_frac_ratio"] <- p["APC_frac_ratio"];
    sOutput["APC_max"] <- p["APC_max"];
    sOutput["beta_APC_ln"] <- p["beta_APC_ln"];
    sOutput["beta_APC_tme"] <- p["beta_APC_tme"];
    sOutput["beta_Tc_ln"] <- p["beta_Tc_ln"];
    sOutput["beta_Tc_tme"] <- p["beta_Tc_tme"];
    sOutput["beta_tumor"] <- p["beta_tumor"];
    sOutput["delta_APC_ln"] <- p["delta_APC_ln"];
    sOutput["delta_Tc_tme"] <- p["delta_Tc_tme"];
    sOutput["doseOn"] <- p["doseOn"];
    sOutput["Fabs"] <- p["Fabs"];
    sOutput["Initial_tumor_volume"] <- 1000 * p["Initial_tumor_volume"];
    sOutput["k12"] <- p["k12"];
    sOutput["k21"] <- p["k21"];
    sOutput["kabs"] <- p["kabs"];
    sOutput["kel"] <- p["kel"];
    sOutput["kkill"] <- p["kkill"];
    sOutput["Kkill"] <- p["Kkill"];
    sOutput["kPD1"] <- p["kPD1"];
    sOutput["KPD1"] <- p["KPD1"];
    sOutput["ksyn_APC_tme"] <- 1E-06 * p["ksyn_APC_tme"];
    sOutput["kv1"] <- p["kv1"];
    sOutput["L"] <- 1000 * p["L"];
    sOutput["L_unit"] <- 1000 * p["L_unit"];
    sOutput["Leuk_frac"] <- p["Leuk_frac"];
    sOutput["Lymph_node"] <- 1000 * p["Lymph_node"];
    sOutput["mean_APC"] <- p["mean_APC"];
    sOutput["mean_Tc"] <- p["mean_Tc"];
    sOutput["mu"] <- p["mu"];
    sOutput["MWantiPD1"] <- 1000 * p["MWantiPD1"];
    sOutput["P"] <- 1000 * p["P"];
    sOutput["Percent_CC"] <- p["Percent_CC"];
    sOutput["Percent_myeloid"] <- p["Percent_myeloid"];
    sOutput["Percent_tumor"] <- p["Percent_tumor"];
    sOutput["Pro_Tc_ln"] <- p["Pro_Tc_ln"];
    sOutput["Q"] <- 1000 * p["Q"];
    sOutput["rate_units"] <- p["rate_units"];
    sOutput["SD_APC"] <- p["SD_APC"];
    sOutput["SD_Tc"] <- p["SD_Tc"];
    sOutput["Size_change"] <- p["Size_change"];
    sOutput["Tc_frac"] <- p["Tc_frac"];
    sOutput["Tc_frac_ratio"] <- p["Tc_frac_ratio"];
    sOutput["Tc_max"] <- p["Tc_max"];
    sOutput["TME"] <- 1000000000 * p["TME"];
    sOutput["tumor_max"] <- p["tumor_max"];
    sOutput["Tumor_volume"] <- 1000 * p["Tumor_volume"];
    sOutput["Vblood"] <- 1000 * p["Vblood"];
    sOutput["Vcell"] <- 1000000000 * p["Vcell"];

    return(sOutput)
}
