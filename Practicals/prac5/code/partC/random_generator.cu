// random number generation
#include <cuda.h>
#include <curand.h>

// Declare variable
curandGenerator_t gen;

// Create random number generator
curandCreateGenerator(&gen, CURAND_RNG_PSEUDO_DEFAULT);

// Set the generator options
curandSetPsuedoRandomGenerator(gen, 1234ULL);

// Generator the randoms
curandGenerateNormal(gen, d_input, NUM_ELS, 0.0f, 1.0f);
