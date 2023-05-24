/*------------------------ Customer Acquisition and Churn Dynamics ------------------------*/


/* _-_-_-_-_-_-_-_-_-_-_ Params _-_-_-_-_-_-_-_-_-_-_ */


param potential_customers = 1000;


/* Rate of acquiring new customers */
param acquisition_rate = 0.2;

/* Rate of churn (customers leaving the service) */
param churn_rate = 0.1;

/* _-_-_-_-_-_-_-_-_-_-_ Consts _-_-_-_-_-_-_-_-_-_-_ */

const max_cutomers = 1000;

const max_marketing_strategies = 5;

const daily_marketing_emails = 1000;

const daily_targeted_emails = 100;

const useof_MachineLearning tools = 1;

/* _-_-_-_-_-_-_-_-_-_-_ Species _-_-_-_-_-_-_-_-_-_-_ */

species A of [0, max_customers];    /* Acquired customers */
species C;    /* Churned customers */

/* _-_-_-_-_-_-_-_-_-_-_ Rules _-_-_-_-_-_-_-_-_-_-_ */

rule CustomerAcquisition for i in [0, potential_customers]{

        A[i] -[ initial_customers * acquisition_rate ]-> A[i]


}

rule CustomerChurn for i in [0, max_customers]{

        A[i] -[ #A  * churn_rate]-> C[i]|A[n-1]

}


/* _-_-_-_-_-_-_-_-_-_-_ Measures _-_-_-_-_-_-_-_-_-_-_ */


/* Total number of customers over time */
measure total_customers = initial_customers + #acquired_customers - #churned_customers;

/* Total number of aquired customers over time */
measure acquired_customers = #A;

/* Total number of churned customers over time */
measure churned_customers = #C;



/* _-_-_-_-_-_-_-_-_-_-_ System Initial values_-_-_-_-_-_-_-_-_-_-_ */


system init = P<potential_customers>;