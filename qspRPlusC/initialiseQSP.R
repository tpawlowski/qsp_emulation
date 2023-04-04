#####################################################################################################
# Version: 2.0.0.28
# Date/time: 23 May 2020 17.28.05
# QSP workspace: CIC_v2.2.6
# Simcyp workspace: Not Loaded
#####################################################################################################

sourceDir <- getSrcDirectory(function(dummy) {});
if(0 < length(sourceDir)) {
    source(file.path(sourceDir, "findNearestRoot.R"));
} else {
    source("findNearestRoot.R");
}



#####################################################################################################
# Performs initialisation for the simulation
#####################################################################################################
initialiseQSP = function(simDuration, nOutputs, initialisationData){

    .C("allocateMemory", PACKAGE = "ODEFunctions_9bfe43bb-b992-4c07-9082-848b89d72e5f");


    # Initialising the state array
    s <- vector(length = 11);

    # Parameters
    p <- vector(length = 51);

    names(s)[1] <- "antigens";
    names(s)[2] <- "antiPD1";
    names(s)[3] <- "antiPD1_Central";
    names(s)[4] <- "antiPD1_IS";
    names(s)[5] <- "antiPD1_Peripheral";
    names(s)[6] <- "APC_ln";
    names(s)[7] <- "APC_tme";
    names(s)[8] <- "capacity";
    names(s)[9] <- "Tc_ln";
    names(s)[10] <- "Tc_tme";
    names(s)[11] <- "Tumor";

    names(p)[1] <- "antiPD1_conc";
    names(p)[2] <- "antiPD1_KD";
    names(p)[3] <- "APC_frac";
    names(p)[4] <- "APC_frac_ratio";
    names(p)[5] <- "APC_max";
    names(p)[6] <- "beta_APC_ln";
    names(p)[7] <- "beta_APC_tme";
    names(p)[8] <- "beta_Tc_ln";
    names(p)[9] <- "beta_Tc_tme";
    names(p)[10] <- "beta_tumor";
    names(p)[11] <- "delta_APC_ln";
    names(p)[12] <- "delta_Tc_tme";
    names(p)[13] <- "doseOn";
    names(p)[14] <- "Fabs";
    names(p)[15] <- "Initial_tumor_volume";
    names(p)[16] <- "k12";
    names(p)[17] <- "k21";
    names(p)[18] <- "kabs";
    names(p)[19] <- "kel";
    names(p)[20] <- "kkill";
    names(p)[21] <- "Kkill";
    names(p)[22] <- "kPD1";
    names(p)[23] <- "KPD1";
    names(p)[24] <- "ksyn_APC_tme";
    names(p)[25] <- "kv1";
    names(p)[26] <- "L";
    names(p)[27] <- "L_unit";
    names(p)[28] <- "Leuk_frac";
    names(p)[29] <- "Lymph_node";
    names(p)[30] <- "mean_APC";
    names(p)[31] <- "mean_Tc";
    names(p)[32] <- "mu";
    names(p)[33] <- "MWantiPD1";
    names(p)[34] <- "P";
    names(p)[35] <- "Percent_CC";
    names(p)[36] <- "Percent_myeloid";
    names(p)[37] <- "Percent_tumor";
    names(p)[38] <- "Pro_Tc_ln";
    names(p)[39] <- "Q";
    names(p)[40] <- "rate_units";
    names(p)[41] <- "SD_APC";
    names(p)[42] <- "SD_Tc";
    names(p)[43] <- "Size_change";
    names(p)[44] <- "Tc_frac";
    names(p)[45] <- "Tc_frac_ratio";
    names(p)[46] <- "Tc_max";
    names(p)[47] <- "TME";
    names(p)[48] <- "tumor_max";
    names(p)[49] <- "Tumor_volume";
    names(p)[50] <- "Vblood";
    names(p)[51] <- "Vcell";

    # Contains bools that specify whether a given dose is on
    doseIsOn <- vector(length = 0);

    # Sets the duration of the simulation
    outputTimes <- seq(0, simDuration, length.out = nOutputs);

    # Times of all dosing events and constraint updates, as well as start and end times
    allDosingEventAndConstraintUpdateTimes <- sort(unique(c(c(0, simDuration), c(0, 21, 42, 63, 84, 105, 126, 147, 168, 189, 210, 231, 252, 273, 294, 315, 336, 357, 378))));

    # Combine output times with dosing times
    times <- sort(unique(c(outputTimes, allDosingEventAndConstraintUpdateTimes)));

    # Constraint start values
    constraintStartValues <- vector(length = 0);



    if("APC_frac" %in% names(initialisationData)) {
        p["APC_frac"] <- initialisationData["APC_frac"];
    } else {
        p["APC_frac"] <- 0.066;
    }
    if("APC_frac_ratio" %in% names(initialisationData)) {
        p["APC_frac_ratio"] <- initialisationData["APC_frac_ratio"];
    } else {
        p["APC_frac_ratio"] <- p["APC_frac"] / p["APC_frac"];
    }
    if("Tc_frac" %in% names(initialisationData)) {
        p["Tc_frac"] <- initialisationData["Tc_frac"];
    } else {
        p["Tc_frac"] <- 0.074;
    }
    if("Tc_frac_ratio" %in% names(initialisationData)) {
        p["Tc_frac_ratio"] <- initialisationData["Tc_frac_ratio"];
    } else {
        p["Tc_frac_ratio"] <- p["Tc_frac"] / p["APC_frac"];
    }
    if("Vblood" %in% names(initialisationData)) {
        p["Vblood"] <- 0.001 * initialisationData["Vblood"];
    } else {
        p["Vblood"] <- 0.00275;
    }
    if("MWantiPD1" %in% names(initialisationData)) {
        p["MWantiPD1"] <- 0.001 * initialisationData["MWantiPD1"];
    } else {
        p["MWantiPD1"] <- 146;
    }
    if("L" %in% names(initialisationData)) {
        p["L"] <- 0.001 * initialisationData["L"];
    } else {
        p["L"] <- 0.00703;
    }
    if("doseOn" %in% names(initialisationData)) {
        p["doseOn"] <- initialisationData["doseOn"];
    } else {
        p["doseOn"] <- 1;
    }
    if("Initial_tumor_volume" %in% names(initialisationData)) {
        p["Initial_tumor_volume"] <- 0.001 * initialisationData["Initial_tumor_volume"];
    } else {
        p["Initial_tumor_volume"] <- 1.259253909E-05;
    }
    if("P" %in% names(initialisationData)) {
        p["P"] <- 0.001 * initialisationData["P"];
    } else {
        p["P"] <- 0.005;
    }
    if("Q" %in% names(initialisationData)) {
        p["Q"] <- 0.001 * initialisationData["Q"];
    } else {
        p["Q"] <- 4.73;
    }
    if("Leuk_frac" %in% names(initialisationData)) {
        p["Leuk_frac"] <- initialisationData["Leuk_frac"];
    } else {
        p["Leuk_frac"] <- 0.14;
    }
    if("KPD1" %in% names(initialisationData)) {
        p["KPD1"] <- initialisationData["KPD1"];
    } else {
        p["KPD1"] <- 43.5;
    }
    if("antiPD1_KD" %in% names(initialisationData)) {
        p["antiPD1_KD"] <- 1E-09 * initialisationData["antiPD1_KD"];
    } else {
        p["antiPD1_KD"] <- 7.6595741E-11;
    }
    if("kPD1" %in% names(initialisationData)) {
        p["kPD1"] <- initialisationData["kPD1"];
    } else {
        p["kPD1"] <- 300;
    }
    if("beta_Tc_tme" %in% names(initialisationData)) {
        p["beta_Tc_tme"] <- initialisationData["beta_Tc_tme"];
    } else {
        p["beta_Tc_tme"] <- 0.0014;
    }
    if("Tc_max" %in% names(initialisationData)) {
        p["Tc_max"] <- initialisationData["Tc_max"];
    } else {
        p["Tc_max"] <- 100 * p["Leuk_frac"] * (p["Tc_frac_ratio"] / (p["Tc_frac_ratio"] + p["APC_frac_ratio"]));
    }
    p["delta_Tc_tme"] <- p["Q"] / p["P"];
    if("beta_tumor" %in% names(initialisationData)) {
        p["beta_tumor"] <- initialisationData["beta_tumor"];
    } else {
        p["beta_tumor"] <- 0.0231;
    }
    if("antiPD1_Peripheral" %in% names(initialisationData)) {
        s["antiPD1_Peripheral"] <- 1E-09 * initialisationData["antiPD1_Peripheral"];
    } else {
        s["antiPD1_Peripheral"] <- 0;
    }
    if("k21" %in% names(initialisationData)) {
        p["k21"] <- initialisationData["k21"];
    } else {
        p["k21"] <- 0.43;
    }
    if("k12" %in% names(initialisationData)) {
        p["k12"] <- initialisationData["k12"];
    } else {
        p["k12"] <- 0.4;
    }
    if("antiPD1_Central" %in% names(initialisationData)) {
        s["antiPD1_Central"] <- 1E-09 * initialisationData["antiPD1_Central"];
    } else {
        s["antiPD1_Central"] <- 0;
    }
    p["antiPD1_conc"] <- s["antiPD1_Central"] * p["MWantiPD1"] / p["Vblood"];
    s["antiPD1"] <- p["doseOn"] * s["antiPD1_Central"];
    if("kel" %in% names(initialisationData)) {
        p["kel"] <- initialisationData["kel"];
    } else {
        p["kel"] <- 0.07342571;
    }
    if("tumor_max" %in% names(initialisationData)) {
        p["tumor_max"] <- initialisationData["tumor_max"];
    } else {
        p["tumor_max"] <- 100 * (1 - p["Leuk_frac"]);
    }
    if("kv1" %in% names(initialisationData)) {
        p["kv1"] <- initialisationData["kv1"];
    } else {
        p["kv1"] <- 0.01;
    }
    if("antiPD1_IS" %in% names(initialisationData)) {
        s["antiPD1_IS"] <- 1E-09 * initialisationData["antiPD1_IS"];
    } else {
        s["antiPD1_IS"] <- 0;
    }
    if("kabs" %in% names(initialisationData)) {
        p["kabs"] <- initialisationData["kabs"];
    } else {
        p["kabs"] <- 2;
    }
    if("Fabs" %in% names(initialisationData)) {
        p["Fabs"] <- initialisationData["Fabs"];
    } else {
        p["Fabs"] <- 0.9815751;
    }
    if("beta_Tc_ln" %in% names(initialisationData)) {
        p["beta_Tc_ln"] <- initialisationData["beta_Tc_ln"];
    } else {
        p["beta_Tc_ln"] <- 0.0014;
    }
    if("Tc_ln" %in% names(initialisationData)) {
        s["Tc_ln"] <- initialisationData["Tc_ln"];
    } else {
        s["Tc_ln"] <- 137554.400017073;
    }
    if("beta_APC_ln" %in% names(initialisationData)) {
        p["beta_APC_ln"] <- initialisationData["beta_APC_ln"];
    } else {
        p["beta_APC_ln"] <- 0.0466;
    }
    if("APC_ln" %in% names(initialisationData)) {
        s["APC_ln"] <- initialisationData["APC_ln"];
    } else {
        s["APC_ln"] <- 1000000;
    }
    if("Pro_Tc_ln" %in% names(initialisationData)) {
        p["Pro_Tc_ln"] <- initialisationData["Pro_Tc_ln"];
    } else {
        p["Pro_Tc_ln"] <- 1.5;
    }
    if("mu" %in% names(initialisationData)) {
        p["mu"] <- initialisationData["mu"];
    } else {
        p["mu"] <- 0.4;
    }
    if("Kkill" %in% names(initialisationData)) {
        p["Kkill"] <- initialisationData["Kkill"];
    } else {
        p["Kkill"] <- 3.45;
    }
    if("kkill" %in% names(initialisationData)) {
        p["kkill"] <- initialisationData["kkill"];
    } else {
        p["kkill"] <- 0.3;
    }
    if("APC_max" %in% names(initialisationData)) {
        p["APC_max"] <- initialisationData["APC_max"];
    } else {
        p["APC_max"] <- 100 * p["Leuk_frac"] * (p["APC_frac_ratio"] / (p["Tc_frac_ratio"] + p["APC_frac_ratio"]));
    }
    if("ksyn_APC_tme" %in% names(initialisationData)) {
        p["ksyn_APC_tme"] <- 1000000 * initialisationData["ksyn_APC_tme"];
    } else {
        p["ksyn_APC_tme"] <- 108005973888.231;
    }
    if("beta_APC_tme" %in% names(initialisationData)) {
        p["beta_APC_tme"] <- initialisationData["beta_APC_tme"];
    } else {
        p["beta_APC_tme"] <- 0.0466;
    }
    if("antigens" %in% names(initialisationData)) {
        s["antigens"] <- initialisationData["antigens"];
    } else {
        s["antigens"] <- 0;
    }
    if("Vcell" %in% names(initialisationData)) {
        p["Vcell"] <- 1E-09 * initialisationData["Vcell"];
    } else {
        p["Vcell"] <- 1E-15;
    }
    if("capacity" %in% names(initialisationData)) {
        s["capacity"] <- initialisationData["capacity"];
    } else {
        s["capacity"] <- p["tumor_max"] / 100 * p["Initial_tumor_volume"] / p["Vcell"];
    }
    if("Tc_tme" %in% names(initialisationData)) {
        s["Tc_tme"] <- initialisationData["Tc_tme"];
    } else {
        s["Tc_tme"] <- p["Tc_max"] / 100 * p["Initial_tumor_volume"] / p["Vcell"];
    }
    if("APC_tme" %in% names(initialisationData)) {
        s["APC_tme"] <- initialisationData["APC_tme"];
    } else {
        s["APC_tme"] <- p["APC_max"] / 100 * p["Initial_tumor_volume"] / p["Vcell"];
    }
    if("Tumor" %in% names(initialisationData)) {
        s["Tumor"] <- initialisationData["Tumor"];
    } else {
        s["Tumor"] <- p["tumor_max"] / 100 * p["Initial_tumor_volume"] / p["Vcell"];
    }
    p["TME"] <- (s["Tumor"] + s["APC_tme"] + s["Tc_tme"]) * p["Vcell"];
    p["Percent_CC"] <- 100 * s["Tc_tme"] / (p["TME"] / p["Vcell"]);
    p["delta_APC_ln"] <- p["L"] / p["TME"];
    p["Size_change"] <- 100 * (p["TME"] - p["Initial_tumor_volume"]) / p["Initial_tumor_volume"];
    p["Tumor_volume"] <- p["TME"];
    p["Percent_myeloid"] <- 100 * s["APC_tme"] / (p["TME"] / p["Vcell"]);
    p["Percent_tumor"] <- 100 * s["Tumor"] / (p["TME"] / p["Vcell"]);
    if("rate_units" %in% names(initialisationData)) {
        p["rate_units"] <- initialisationData["rate_units"];
    } else {
        p["rate_units"] <- 1;
    }
    if("L_unit" %in% names(initialisationData)) {
        p["L_unit"] <- 0.001 * initialisationData["L_unit"];
    } else {
        p["L_unit"] <- 0.001;
    }
    if("Lymph_node" %in% names(initialisationData)) {
        p["Lymph_node"] <- 0.001 * initialisationData["Lymph_node"];
    } else {
        p["Lymph_node"] <- 0.000293;
    }
    if("mean_APC" %in% names(initialisationData)) {
        p["mean_APC"] <- initialisationData["mean_APC"];
    } else {
        p["mean_APC"] <- -2.58098;
    }
    if("mean_Tc" %in% names(initialisationData)) {
        p["mean_Tc"] <- initialisationData["mean_Tc"];
    } else {
        p["mean_Tc"] <- -2.436;
    }
    if("SD_APC" %in% names(initialisationData)) {
        p["SD_APC"] <- initialisationData["SD_APC"];
    } else {
        p["SD_APC"] <- 0.69689;
    }
    if("SD_Tc" %in% names(initialisationData)) {
        p["SD_Tc"] <- initialisationData["SD_Tc"];
    } else {
        p["SD_Tc"] <- 0.62335;
    }


    initialised <- list();
    initialised$s <- s;
    initialised$p <- p;
    initialised$doseIsOn <- doseIsOn;
    initialised$times <- times;
    initialised$outputTimes <- outputTimes;
    initialised$allDosingEventAndConstraintUpdateTimes <- allDosingEventAndConstraintUpdateTimes;
    return(initialised);
}
