// import libs
#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
#include <cuda.h>
// curand for random points generation
#include <curand.h>
#include <curand_kernel.h>
#include <cuda_runtime.h>
#include <cuda_runtime_api.h>

// Number of thread blocks in the grid
#define THREAD_BLOCKS 512
// Number of threads in a thread block
#define THREADS 2
// Number of random points
#define N 1000

// define a kernal to find area within the quarter circle
__global__ void mc_pi(float *d_input_x, float *d_input_y, int *d_area)
{
  // define index and find the value of x,y coordinates
  int index = blockIdx.x * blockDim.x + threadIdx.x;
  int x = d_input_x[index];
  int y = d_input_y[index];

  // increment d_area when a random point is located within the quarter circle
  if (x * x + y * y <= 1.0f)
  {
    atomicAdd(d_area, 1);
  }
}

int main(void)
{
  // step1: initialise GPU
  int deviceid = 0;
  int devCount = 0;
  cudaGetDeviceCount(&devCount);
  if (deviceid < devCount)
  {
    cudaSetDevice(deviceid);
  }
  else
    return 1;

  // step3: allocate memory in GPU
  size_t array_size = N * sizeof(float);
  float *d_input_x;
  float *d_input_y;
  int *d_area;

  cudaMalloc((void **)&d_input_x, array_size);
  cudaMalloc((void **)&d_input_y, array_size);
  cudaMalloc((void **)&d_area, sizeof(int));

  // Step4: Random Number Generator
  curandGenerator_t gen;
  // Create random number generator
  curandCreateGenerator(&gen, CURAND_RNG_PSEUDO_DEFAULT);
  // Set the generator
  curandSetPseudoRandomGeneratorSeed(gen, 123456ULL);
  // generate the randoms
  curandGenerateUniform(gen, d_input_x, N);
  curandGenerateUniform(gen, d_input_y, N);

  // Step5: use the kernel to add area
  mc_pi<<<THREAD_BLOCKS, THREADS>>>(d_input_x, d_input_y, d_area);

  // Step6: copy the data from the host to the device & print results
  int *h_area = (int *)malloc(sizeof(int));
  cudaMemcpy(h_area, d_area, sizeof(int), cudaMemcpyDeviceToHost);

  printf("\nPi:\t%f\n", (4.0 * (*h_area)) / (float)N);

  return (0);
}