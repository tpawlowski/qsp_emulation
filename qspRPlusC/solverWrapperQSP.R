#####################################################################################################
# Version: 2.0.0.28
# Date/time: 23 May 2020 17.28.05
# QSP workspace: CIC_v2.2.6
# Simcyp workspace: Not Loaded
#####################################################################################################

tryInstallRequiredPackages <- FALSE;
if(tryInstallRequiredPackages) {
    if(FALSE == require(deSolve)) {
        install.packages("deSolve");
        require(deSolve);
    } 
} else {
    require(deSolve);
}
sourceDir <- getSrcDirectory(function(dummy) {});
if(0 < length(sourceDir)) {
    if (.Platform$OS.type == "unix"){
        dllPath <- file.path(sourceDir, "ODEFunctions_9bfe43bb-b992-4c07-9082-848b89d72e5f.so");
    } else {
        dllPath <- file.path(sourceDir, "ODEFunctions_9bfe43bb-b992-4c07-9082-848b89d72e5f.dll");
    }
    tryCatch(dyn.unload(dllPath), error = function(dummy) {});
    system(paste("R CMD SHLIB", file.path(sourceDir, "ODEFunctions_9bfe43bb-b992-4c07-9082-848b89d72e5f.c")));
} else {
    dllPath <- "ODEFunctions_9bfe43bb-b992-4c07-9082-848b89d72e5f.dll";
    tryCatch(dyn.unload(dllPath), error = function(dummy) {});
    system("R CMD SHLIB ODEFunctions_9bfe43bb-b992-4c07-9082-848b89d72e5f.c");
}
dyn.load(dllPath);

#####################################################################################################
# Calls the ODE solver
#####################################################################################################
solverWrapperQSP = function(
    integrationTimes, # Times to be integrated over
    s,                # State
    p                 # Parameters
){
    solution <- vode(func = "odeRateStepQSP", dllname = "ODEFunctions_9bfe43bb-b992-4c07-9082-848b89d72e5f", initfunc = "copyParametersQSP", y = s, times = integrationTimes, parms = p, rtol = 1E-12, atol = 1E-12, nout = 51, outnames = names(p));
    return(solution);
}
