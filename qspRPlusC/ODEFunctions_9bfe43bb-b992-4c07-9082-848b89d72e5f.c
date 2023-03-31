// ************************************************************************************************************
// Version: 2.0.0.28
// Date/time: 23 May 2020 17.28.05
// QSP workspace: CIC_v2.2.6
// Simcyp workspace: Not Loaded
// ************************************************************************************************************

#include <R.h>
#include <math.h>
#include <string.h>
#include <Rmath.h>
#include <float.h>
#include <limits.h>

static double p[51];
static double rReact[17];
double findNearestRootConvergenceTol = 1E-10;
int findNearestRootMaxIterations = INT_MAX;
static double tCopy;
static double* sCopy;

// ************************************************************************************************************
// Frees memory used in the simulation
// ************************************************************************************************************
void freeMemory(){

}

// ************************************************************************************************************
// Allocates memory used in the simulation
// ************************************************************************************************************
void allocateMemory(){

    freeMemory();

    atexit(freeMemory);
}

// ************************************************************************************************************
// Copies parameters into array
// ************************************************************************************************************
void copyParametersQSP(void (*odeparms)(int*, double*)){
    int nParameters = 51;
    odeparms(&nParameters, p);
}

// ************************************************************************************************************
// Finds the nearest root using Newton's method
// ************************************************************************************************************
double findNearestRoot(double (*constraintValue)(double), double (*constraintDerivative)(double), double initialGuess){
    double previousValue;
    double currentValue = initialGuess;

    for(int i = 0; i <= (findNearestRootMaxIterations - 1); i = i + 1){
        previousValue = currentValue;
        currentValue = currentValue - constraintValue(previousValue) / constraintDerivative(previousValue);
        if(fabs(currentValue - previousValue) < findNearestRootConvergenceTol) {
            break;
        } 
    }
    return currentValue;
}

// ************************************************************************************************************
// Does assignments to quantities that are repeatedly assigned
// ************************************************************************************************************
void odeQuantityAssignmentsQSP(
    double* tInput, // Simulation time
    double* s       // State
){
    double t = *tInput;
    sCopy = s;
    tCopy = t;

    p[11] = p[38] / p[33];
    p[0] = s[2] * p[32] / p[49];
    s[1] = p[12] * s[2];
    p[46] = (s[10] + s[6] + s[9]) * p[50];
    p[34] = 100.0 * s[9] / (p[46] / p[50]);
    p[10] = p[25] / p[46];
    p[42] = 100.0 * (p[46] - p[14]) / p[14];
    p[48] = p[46];
    p[35] = 100.0 * s[6] / (p[46] / p[50]);
    p[36] = 100.0 * s[10] / (p[46] / p[50]);

}

// ************************************************************************************************************
// Does assignments to quantities that are repeatedly assigned, taking parameters as an argument
// ************************************************************************************************************
void odeQuantityAssignmentsWithParamsArgQSP(
    double* tInput, // Simulation time
    double* s,      // State
    double* pInput  // Parameters
){
    int nParameters = 51;

    memmove(p, pInput, nParameters * sizeof(double));

    odeQuantityAssignmentsQSP(tInput, s);

    memmove(pInput, p, nParameters * sizeof(double));


}

// ************************************************************************************************************
// Sets the values of the rate variables based on the current state
// ************************************************************************************************************
void odeRateStepQSP(
    int* nEquations,
    double* tInput,       // Simulation time
    double* s,            // State
    double* r,            // Rate
    double* extraOutputs,
    int* extraOutputsKey 
){
    double t = *tInput;
    sCopy = s;
    tCopy = t;

    p[11] = p[38] / p[33];
    p[0] = s[2] * p[32] / p[49];
    s[1] = p[12] * s[2];
    rReact[12] = p[15] * s[2] - p[16] * s[4];
    rReact[11] = p[18] * s[2];
    rReact[9] = (1.0 - p[13]) * p[17] * s[3];
    rReact[8] = p[13] * p[17] * s[3];
    rReact[7] = s[8] * p[7];
    rReact[6] = p[5] * s[5];
    rReact[5] = p[37] * s[5];
    rReact[15] = p[8] * s[9];
    rReact[1] = p[6] * s[6];
    rReact[13] = p[9] * s[10];
    rReact[4] = p[31] * s[10] * (1.0 - s[10] / s[7]);
    p[46] = (s[10] + s[6] + s[9]) * p[50];
    p[34] = 100.0 * s[9] / (p[46] / p[50]);
    rReact[14] = p[11] * s[8] * (1.0 - p[34] / p[45]);
    rReact[3] = p[19] * s[10] * (p[34] / (p[34] + p[20]));
    p[10] = p[25] / p[46];
    p[42] = 100.0 * (p[46] - p[14]) / p[14];
    p[48] = p[46];
    p[35] = 100.0 * s[6] / (p[46] / p[50]);
    rReact[2] = p[23] * 5000.0 * (1.0 - p[35] / p[4]);
    p[36] = 100.0 * s[10] / (p[46] / p[50]);
    rReact[16] = p[21] * (1.0 - s[1] / (s[1] + p[1])) * s[9] * (p[36] / (p[36] + p[22]));
    rReact[10] = p[24] * s[10] * (p[47] / p[36]);
    rReact[0] = p[10] * s[6] * s[0] / (p[46] / p[50]);

    r[0] = rReact[3] - rReact[0];
    r[1] = 0;
    r[2] = rReact[8] - rReact[12] - rReact[11];
    r[3] = -rReact[8] - rReact[9];
    r[4] = rReact[12];
    r[5] = rReact[0] - rReact[6];
    r[6] = rReact[2] * p[46] - rReact[1] - rReact[0];
    r[7] = rReact[10];
    r[8] = -rReact[14] + rReact[5] - rReact[7];
    r[9] = rReact[14] - rReact[15] - rReact[16];
    r[10] = rReact[4] - rReact[3] - rReact[13];



    memmove(extraOutputs, p, 51 * sizeof(double));
}