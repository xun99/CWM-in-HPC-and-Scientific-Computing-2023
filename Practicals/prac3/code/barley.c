/**************************************************
 *                                                *
 * First attempt at a code to calcule lost barley *
 * by A. Farmer                                   *
 * 18/05/18                                       *
 *                                                *
 **************************************************/

// Include any headers from the C standard library here
#include <stdio.h>

// Define any constants that I need to use here
#define PI 3.14

// This is where I should put my function prototypes
float area_of_circle(float radius); 

// Now I start my code with main()
int main() {

    // In here I need to delare my variables
    int i = 0;
    float radius[3];
    float area[3];
    float total_area;

    // Next I need to get input from the user.
    // I'll do this by using a printf() to ask the user to input the radii.
    printf("\nEnter three radii:\t");
    scanf("%f %f %f", &radius[0], &radius[1], &radius[2]);

    // Now I need to loop through the radii caluclating the area for each
    while(i<3){
    	area[i] = area_of_circle(radius[i]);
	i++;
    }
    // Next I'll sum up all of the individual areas
    total_area = 0.0;
    for(i=0; i<3; i++) {
    	total_area += area[i];
    }
    /******************************************************************
     *                                                                *
     * Now I know the total area I can use the following information: *
     *                                                                *
     * One square meter of crop produces about 135 grams of barley    *
     *                                                                *
     * One kg of barley sells for about 10 pence                      *
     *                                                                *
     ******************************************************************/

    // Using the above I'll work out how much barley has been lost.
    loss_in_kg = total_area*0.135;

    // Finally I'll use a printf() to print this to the screen.
    printf("\nTotal area lossed in m^2 is:\t%f\n", total_area);
    printf("Total loss in kg is:\t\t%f\n", loss_in_kg);

    return(0);
}

// I'll put my functions here:

