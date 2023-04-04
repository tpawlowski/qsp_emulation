#####################################################################################################
# Version: 2.0.0.28
# Date/time: 23 May 2020 17.28.05
# QSP workspace: CIC_v2.2.6
# Simcyp workspace: Not Loaded
#####################################################################################################

sourceDir <- getSrcDirectory(function(dummy) {});
if(0 < length(sourceDir)) {
    source(file.path(sourceDir, "simulateIndividualQSP.R"));
} else {
    source("simulateIndividualQSP.R");
}

#####################################################################################################
# Runs the simulation
#####################################################################################################
simulateQSP = function(input=NULL){

    # Alternate initial values
    initialisationData <- vector();
    if(0 == length(input)) {
        initialisationData["doseOn"] <- 1;
        initialisationData["Leuk_frac"] <- 0.14;
        initialisationData["Tc_frac"] <- 0.074;
        initialisationData["APC_frac"] <- 0.066;
        initialisationData["mu"] <- 0.4;
        initialisationData["kv1"] <- 0.01;
        initialisationData["beta_tumor"] <- 0.0231;
        initialisationData["kkill"] <- 0.3;
        initialisationData["kPD1"] <- 300;
        initialisationData["Pro_Tc_ln"] <- 1.5;
        initialisationData["Initial_tumor_volume"] <- 0.01259253909;
    } else {
        initialisationData["doseOn"] <- input[1];
        initialisationData["Leuk_frac"] <- input[2];
        initialisationData["Tc_frac"] <- input[3];
        initialisationData["APC_frac"] <- input[4];
        initialisationData["mu"] <- input[5];
        initialisationData["kv1"] <- input[6];
        initialisationData["beta_tumor"] <- input[7];
        initialisationData["kkill"] <- input[8];
        initialisationData["kPD1"] <- input[9];
        initialisationData["Pro_Tc_ln"] <- input[10];
        initialisationData["Initial_tumor_volume"] <- input[11];
    }

    # The data frame for a given individual should be accessed like e.g. results[[1]] not results[1] to preserve it as a data frame
    results <- replicate(1, simulateIndividualQSP(initialisationData), FALSE);
    return(results);
}
