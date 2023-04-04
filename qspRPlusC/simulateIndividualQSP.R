#####################################################################################################
# Version: 2.0.0.28
# Date/time: 23 May 2020 17.28.05
# QSP workspace: CIC_v2.2.6
# Simcyp workspace: Not Loaded
#####################################################################################################

sourceDir <- getSrcDirectory(function(dummy) {});
if(0 < length(sourceDir)) {
    source(file.path(sourceDir, "initialiseQSP.R"));
    source(file.path(sourceDir, "doseEventQSP.R"));
    source(file.path(sourceDir, "odeOutputQSP.R"));
    source(file.path(sourceDir, "integrateQSP.R"));
    source(file.path(sourceDir, "valueIsInOrderedList.R"));
} else {
    source("initialiseQSP.R");
    source("doseEventQSP.R");
    source("odeOutputQSP.R");
    source("integrateQSP.R");
    source("valueIsInOrderedList.R");
}

#####################################################################################################
# Runs the simulation for one set of parameter values
#####################################################################################################
simulateIndividualQSP = function(initialisationData=NULL){

    simDuration <- 398;
    nOutputs <- 200;

    initialised <- initialiseQSP(simDuration, nOutputs, initialisationData);
    s <- initialised$s;
    p <- initialised$p;
    doseIsOn <- initialised$doseIsOn;
    times <- initialised$times;
    outputTimes <- initialised$outputTimes;
    allDosingEventAndConstraintUpdateTimes <- initialised$allDosingEventAndConstraintUpdateTimes;

    sOutput <- odeOutputQSP(allDosingEventAndConstraintUpdateTimes[1], s, p);

    dosed <- doseEventQSP(allDosingEventAndConstraintUpdateTimes[1], s, p, doseIsOn);
    s <- dosed$s;
    doseIsOn <- dosed$doseIsOn;


    for(i in 2:length(allDosingEventAndConstraintUpdateTimes)){
        iterationTimes <- times[allDosingEventAndConstraintUpdateTimes[i - 1] <= times & times <= allDosingEventAndConstraintUpdateTimes[i]];
        solutionComps <- integrateQSP(iterationTimes, s, p, doseIsOn);
        solutionTimeComp <- solutionComps$solutionTimeComp;
        solutionStateComp <- solutionComps$solutionStateComp;
        solutionParamComp <- solutionComps$solutionParamComp;
        if(length(iterationTimes) != length(solutionTimeComp)) {
            stop("Expected solution times to match input times");
        } 

        for(j in 2:length(iterationTimes)){
            if(solutionTimeComp[j, ] != iterationTimes[j]) {
                stop("Expected solution times to match input times");
            } 
            if(valueIsInOrderedList(iterationTimes[j], outputTimes)) {
                sOutput <- rbind(sOutput, odeOutputQSP(solutionTimeComp[j, ], solutionStateComp[j, ], solutionParamComp[j, ]));
            } 
        }

        dosed <- doseEventQSP(solutionTimeComp[nrow(solutionTimeComp), ], solutionStateComp[nrow(solutionTimeComp), ], solutionParamComp[nrow(solutionTimeComp), ], doseIsOn);
        s <- dosed$s;
        doseIsOn <- dosed$doseIsOn;
        p <- solutionParamComp[nrow(solutionTimeComp), ];
    }

    rownames(sOutput) <- NULL;
    return(as.data.frame(sOutput));
}
