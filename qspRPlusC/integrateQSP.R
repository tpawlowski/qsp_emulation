#####################################################################################################
# Version: 2.0.0.28
# Date/time: 23 May 2020 17.28.05
# QSP workspace: CIC_v2.2.6
# Simcyp workspace: Not Loaded
#####################################################################################################

sourceDir <- getSrcDirectory(function(dummy) {});
if(0 < length(sourceDir)) {
    source(file.path(sourceDir, "solverWrapperQSP.R"));
} else {
    source("solverWrapperQSP.R");
}

#####################################################################################################
# Integrates between the specified times
#####################################################################################################
integrateQSP = function(integrationTimes, s, p, doseIsOn){


    solution <- solverWrapperQSP(integrationTimes, s, p);
    solutionComps <- list();
    solutionComps$solutionTimeComp <- solution[, 1:1, drop = FALSE];
    solutionComps$solutionStateComp <- solution[, 2:12, drop = FALSE];
    solutionComps$solutionParamComp <- solution[, 13:63, drop = FALSE];
    return(solutionComps);
}
