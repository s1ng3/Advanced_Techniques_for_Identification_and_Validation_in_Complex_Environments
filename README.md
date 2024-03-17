_﻿Advanced Techniques for System Identification and Validation in Complex Environments_

**Author:** Tudor-Cristian Sîngerean 

1. **Project description**

The objective of this project is to develop a nonlinear ARX model that captures the relationship between the system's input and output signals. This model, based on a linear-in-parameters structure with a polynomial form, is characterized by parameters ***na***, ***nb***, ***nk*** and ***m***.

The code utilizes MATLAB to approach, identify and approximate a dynamic system using a model with a polynomial structure. The choice of parameters ***na***, ***nb***, ***nk***, and ***m*** allows for flexibility in sketching the model to specific system characteristics.

The project focuses on building and validating a system model based on input-output data. The identified model is then used for prediction and simulation, and the performance is evaluated through mean squared errors. The system could be a dynamic system in a control or industrial process, and the project aims to develop a mathematical representation of its behavior.

![datedein2](https://github.com/s1ng3/Shoe_Shop/assets/89934251/fb9a4d12-55ab-4a63-904d-67eb2bd1b6da)

2. **Implementation**

For developing a nonlinear ARX model using the identification data, constructing the regressor line based on past input and output values and also the design matrix '**ϕ**' for identification and simulation is considered to be an optimal approach.

The model is based on two main functions which will be used in order to create the design matrices.

The '**phi\_line\_function**' is a recursive function that constructs a single row of the design matrix '**ϕ**'. This function is called by other functions (ex: '**phi\_id**' or '**phi\_val**') in order to build the rows of the design matrices.

The other function, '**regline**’, is used to construct the regressor line for each data point based on past input and

output values.

The other functions (**'phi\_function\_id**', **'phi\_function\_id\_sim**', **'phi\_function\_val**', **'phi\_function\_val\_sim**') construct the design matrix '**ϕ'** for identification, identification simulation, validation, and validation simulation, respectively. These matrices are essential for parameter estimation in the ARX model.

**Output Validation Data** 

The NARX model structure is implemented through the construction of design matrix ϕ.

Upon achieving the coefficients θ , the generation of the predictive model for both the identification and validation datasets results through the matrix multiplication of ϕ and θ.

The model parameters are estimated through linear regression, and the performance is evaluated using MSE values for prediction and simulation errors.

3. **Tuning parameters**

One can observe that by taking ***na = nb** ,* the structure of the model is simplified by reducing the number of independent parametric combinations.

By increasing the ***na = nb*** , the model will capture more history and it could potentially make the model much more detailed and by resulting in a more wide-ranging representation of the system dynamics.

By decreasing the ***na = nb*** , the model will capture simplifies the model interpretation and could possibly result in a straightforward interpretation.

By increasing ***nk*** , a time delay is added and also applied to both the past input and output terms.

By decreasing ***nk*** , the time delay doesn’t affect the system in such a manner and it leads to a faster response in the model.

Increasing ***m*** allows the model to capture more complex patterns while decreasing ***m*** simplifies the model, making it more linear.


4. **Plots**

To provide the precision of our model on the validation data, we calculate the Mean Squared Error (MSE). This way we can measure how close our model's predictions are to the actual values from the validation set.

By calculating the MSE for different values with the below formula, the understanding of how well our model is doing under certain conditions is easier.

The most straightforward way to visualize the accuracy of the model is by using MATLAB in order to calculate and display the Mean Square Errors.


![idinval2](https://github.com/s1ng3/Shoe_Shop/assets/89934251/7f835b43-cb49-40db-9fa8-7eab61cb6012)


In our provided dataset, the optimal model for the validation data corresponds to ***na = nb = 1***. ***nk*** will be taken as **1** by default and the best fitting degree will be ***m = 3***.

Additionally, it's noticeable that as increases, the Mean Squared Error (MSE) for the identification and validation data decreases, indicating a better fit. 


5. **Conclusions**
- The provided MATLAB code offers a systematic approach to identify and approximate a dynamic system using a linear-in-parameters model with a polynomial structure.

- The choice of parameters ***na***, ***nb***, ***nk***, and ***m*** allows for flexibility in tailoring the model to specific system characteristics.

- The effectiveness of the model is evaluated through MSE calculations, providing insights into the accuracy of both prediction and simulation results.

- This approach is valuable in various engineering applications where accurate system modeling is needed for successful control and optimization.

- For example, aircraft control systems must ensure stability, performance, and safety during various flight conditions. Accurate modeling is essential for designing control systems that respond predictably to pilot commands and external factors like turbulence.
