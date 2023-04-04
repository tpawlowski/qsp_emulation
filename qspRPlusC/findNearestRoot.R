#####################################################################################################
# Version: 2.0.0.28
# Date/time: 23 May 2020 17.28.05
# QSP workspace: CIC_v2.2.6
# Simcyp workspace: Not Loaded
#####################################################################################################

#####################################################################################################
# Finds the nearest root using Newton's method
#####################################################################################################
findNearestRoot = function(constraintValue, constraintDerivative, initialGuess){
    findNearestRootConvergenceTol <- 1E-10;
    findNearestRootMaxIterations <- .Machine$integer.max;
    currentValue <- initialGuess;

    for(i in 0:(findNearestRootMaxIterations - 1)){
        previousValue <- currentValue;
        currentValue <- currentValue - constraintValue(previousValue) / constraintDerivative(previousValue);
        if(abs(currentValue - previousValue) < findNearestRootConvergenceTol) {
            break;
        } 
    }
    return(currentValue);
}
